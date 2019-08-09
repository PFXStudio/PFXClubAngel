import 'package:clubangel/defines/define_enums.dart';
import 'package:clubangel/singletons/account_singleton.dart';
import 'package:clubangel/singletons/snack_bar_singleton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AccountAuthSmsWidget extends StatefulWidget {
  @override
  _AccountAuthSmsWidgetState createState() => _AccountAuthSmsWidgetState();
}

class _AccountAuthSmsWidgetState extends State<AccountAuthSmsWidget> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  Future<void> linkWithPhoneNumber(AuthCredential credential) async {
    final errorMessage = "We couldn't verify your code, please try again!";

    final result = await AccountSingleton()
        .firebaseUser
        .linkWithCredential(credential)
        .catchError((error) {
      print("Failed to verify SMS code: $error");
      SnackBarSingleton().showError(errorMessage);
    });

    AccountSingleton().firebaseUser = result.user;

    await onCodeVerified(AccountSingleton().firebaseUser)
        .then((codeVerified) async {
      if (codeVerified == true) {
        await finishSignIn();
      } else {
        SnackBarSingleton().showError(errorMessage);
      }
    });
  }

  finishSignIn() async {
    await onCodeVerified(AccountSingleton().firebaseUser).then((result) {
      if (result) {
        // Here, instead of navigating to another screen, you should do whatever you want
        // as the user is already verified with Firebase from both
        // Google and phone number methods
        // Example: authenticate with your own API, use the data gathered
        // to post your profile/user, etc.

        Navigator.of(context)
            .pushReplacement(CupertinoPageRoute(builder: (context) {
          // TODO : Main
        }));
      } else {
        setState(() {
          AccountSingleton().authSequenceType = AuthSequenceType.smsAuth;
        });

        SnackBarSingleton().showError(
            "We couldn't create your profile for now, please try again later");
      }
    });
  }

  Future<bool> onCodeVerified(FirebaseUser user) async {
    final isUserValid = (user != null &&
        (user.phoneNumber != null && user.phoneNumber.isNotEmpty));
    if (isUserValid) {
      setState(() {
        // Here we change the status once more to guarantee that the SMS's
        // text input isn't available while you do any other request
        // with the gathered data
        AccountSingleton().authSequenceType = AuthSequenceType.profileAuth;
      });
    } else {
      SnackBarSingleton()
          .showError("We couldn't verify your code, please try again!");
    }
    return isUserValid;
  }
}
