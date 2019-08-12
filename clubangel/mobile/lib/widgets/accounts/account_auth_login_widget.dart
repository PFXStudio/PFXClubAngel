import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clubangel/defines/define_enums.dart';
import 'package:clubangel/themes/main_theme.dart';
import 'package:clubangel/widgets/accounts/account_init_profile_widget.dart';
import 'package:clubangel/widgets/accounts/account_widget.dart';
import 'package:clubangel/widgets/mains/main_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_account_kit/flutter_account_kit.dart';
import 'package:core/src/networking/firestore_account_api.dart';
import 'package:core/src/models/member.dart';

class AccountAuthLoginWidget extends StatefulWidget {
  @override
  _AccountAuthLoginWidgetState createState() => _AccountAuthLoginWidgetState();
}

class _AccountAuthLoginWidgetState extends State<AccountAuthLoginWidget> {
  final FocusNode myFocusNodeEmailLogin = FocusNode();
  final FocusNode myFocusNodePasswordLogin = FocusNode();

  final FocusNode myFocusNodePassword = FocusNode();
  final FocusNode myFocusNodeEmail = FocusNode();
  final FocusNode myFocusNodeName = FocusNode();

  TextEditingController loginEmailController = new TextEditingController();
  TextEditingController loginPasswordController = new TextEditingController();

  bool _obscureTextLogin = true;
  bool _obscureTextSignup = true;
  bool _obscureTextSignupConfirm = true;
  AuthSequenceType authSequenceType = AuthSequenceType.socialAuth;
  String phoneNumber;
  String errorMessage;
  String verificationId;
  Timer codeTimer;

  bool isRefreshing = false;
  bool codeTimedOut = false;
  bool codeVerified = false;
  Duration timeout = Duration(minutes: 1);

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  GoogleSignInAccount googleUser;
  FirebaseUser firebaseUser;
  FlutterAccountKit akt = new FlutterAccountKit();
  bool _isInitialized = false;
  final database =
      FirebaseDatabase.instance.reference().child("dev/account/members");

  @override
  void initState() {
    super.initState();
    initAccountkit();
  }

  Future<void> initAccountkit() async {
    print('Init account kit called');
    bool initialized = false;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      final theme = AccountKitTheme(
          headerBackgroundColor: MainTheme.bgndColor,
          buttonBackgroundColor: MainTheme.enabledButtonColor,
          buttonBorderColor: Colors.transparent,
          buttonTextColor: Colors.white);
      await akt.configure(Config()
        ..responseType = ResponseType.token
        ..initialPhoneNumber = PhoneNumber(countryCode: "+82", number: "")
        ..facebookNotificationsEnabled = true
        ..receiveSMS = true
        ..readPhoneStateEnabled = true
        ..theme = theme);
      initialized = true;
    } on Exception {
      print('Failed to initialize account kit');
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
    setState(() {
      _isInitialized = initialized;
      print("isInitialied $_isInitialized");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 23.0),
      child: Column(
        children: <Widget>[
          Stack(
            alignment: Alignment.topCenter,
            overflow: Overflow.visible,
            children: <Widget>[
              Card(
                elevation: 2.0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Container(
                  width: 300.0,
                  height: 190.0,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                            top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                        child: TextField(
                          focusNode: myFocusNodeEmailLogin,
                          controller: loginEmailController,
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(fontSize: 16.0, color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              FontAwesomeIcons.envelope,
                              color: Colors.black,
                              size: 22.0,
                            ),
                            hintText: "Email Address",
                            hintStyle: TextStyle(fontSize: 17.0),
                          ),
                        ),
                      ),
                      Container(
                        width: 250.0,
                        height: 1.0,
                        color: Colors.grey[400],
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                        child: TextField(
                          focusNode: myFocusNodePasswordLogin,
                          controller: loginPasswordController,
                          obscureText: _obscureTextLogin,
                          style: TextStyle(fontSize: 16.0, color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              FontAwesomeIcons.lock,
                              size: 22.0,
                              color: Colors.black,
                            ),
                            hintText: "Password",
                            hintStyle: TextStyle(fontSize: 17.0),
                            suffixIcon: GestureDetector(
                              onTap: _toggleLogin,
                              child: Icon(
                                _obscureTextLogin
                                    ? FontAwesomeIcons.eye
                                    : FontAwesomeIcons.eyeSlash,
                                size: 15.0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 170.0),
                decoration: new BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: MainTheme.gradientStartColor,
                      offset: Offset(1.0, 6.0),
                      blurRadius: 20.0,
                    ),
                    BoxShadow(
                      color: MainTheme.gradientEndColor,
                      offset: Offset(1.0, 6.0),
                      blurRadius: 20.0,
                    ),
                  ],
                  gradient: MainTheme.buttonLinearGradient,
                ),
                child: MaterialButton(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.red,
                    //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 42.0),
                      child: Text(
                        "LOGIN",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                    onPressed: () async {
                      // showInSnackBar("Login button pressed");
                      if (await akt.isLoggedIn == true) {
                        final Account account = await akt.currentAccount;
                        if (account.phoneNumber != null) {
                          print(account.phoneNumber);
                          print("already logined!");
                          this.getAccountInfo(account.phoneNumber);
                          return;
                        }
                        return;
                      }

                      await akt.logOut();
                      LoginResult result = await akt.logInWithPhone();
                      switch (result.status) {
                        case LoginStatus.loggedIn:
                          final Account account = await akt.currentAccount;
                          print(result.accessToken.accountId);
                          // TODO : result.accessToken.accountId 저장 해야 함.
                          print(account.phoneNumber);
                          this.getAccountInfo(account.phoneNumber);
                          break;
                        case LoginStatus.cancelledByUser:
                          break;
                        case LoginStatus.error:
                          break;
                      }
                    }),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: FlatButton(
                onPressed: () {},
                child: Text(
                  "Forgot Password?",
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                )),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    gradient: new LinearGradient(
                        colors: [
                          Colors.white10,
                          Colors.white,
                        ],
                        begin: const FractionalOffset(0.0, 0.0),
                        end: const FractionalOffset(1.0, 1.0),
                        stops: [0.0, 1.0],
                        tileMode: TileMode.clamp),
                  ),
                  width: 100.0,
                  height: 1.0,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15.0, right: 15.0),
                  child: Text(
                    "Or",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: new LinearGradient(
                        colors: [
                          Colors.white,
                          Colors.white10,
                        ],
                        begin: const FractionalOffset(0.0, 0.0),
                        end: const FractionalOffset(1.0, 1.0),
                        stops: [0.0, 1.0],
                        tileMode: TileMode.clamp),
                  ),
                  width: 100.0,
                  height: 1.0,
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 10.0, right: 40.0),
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.all(15.0),
                    decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: new Icon(
                      FontAwesomeIcons.facebookF,
                      color: Color(0xFF0084ff),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.all(15.0),
                    decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: new Icon(
                      FontAwesomeIcons.google,
                      color: Color(0xFF0084ff),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future getAccountInfo(PhoneNumber phoneNumber) async {
    String key = phoneNumber.countryCode +
        (phoneNumber.countryCode == "82" && phoneNumber.number.length == 10
            ? "0" + phoneNumber.number
            : phoneNumber.number);

    FirestoreAccountApi().selectMemeber(key, (member) {
      if (member == null) {
        FirestoreAccountApi().insertMember(key, (documentReference) {
          // show profile
          getAccountInfo(phoneNumber);
          return;
        }, (error) {
          print(error);
        });

        return;
      }

      Member.signedInstance = member;
      String nickname = member.nickname;
      if (nickname == null || nickname.length <= 0) {
        Navigator.of(context, rootNavigator: true).pushReplacement(
            MaterialPageRoute(
                builder: (context) => AccountInitProfileWidget()));
        return;
      }

      Navigator.of(context, rootNavigator: true).pushReplacement(
          MaterialPageRoute(builder: (context) => MainWidget()));
    }, (error) {
      print(error);
    });
  }

  Future _toggleLogin() async {
    setState(() {
      _obscureTextLogin = !_obscureTextLogin;
    });
  }
}
