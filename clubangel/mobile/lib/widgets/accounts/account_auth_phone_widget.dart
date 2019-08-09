import 'dart:async';

import 'package:clubangel/defines/define_enums.dart';
import 'package:clubangel/singletons/account_singleton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AccountAuthPhoneWidget extends StatefulWidget {
  @override
  _AccountAuthPhoneWidgetState createState() => _AccountAuthPhoneWidgetState();
}

class _AccountAuthPhoneWidgetState extends State<AccountAuthPhoneWidget> {
  @override
  Timer codeTimer;
  String verificationId;
  bool isRefreshing = false;
  bool codeTimedOut = false;
  Duration timeout = const Duration(minutes: 1);

  Widget build(BuildContext context) {
    return Container();
  }

  Future<Null> verifyPhoneNumber() async {
    await AccountSingleton().firebaseAuth.verifyPhoneNumber(
        phoneNumber: "+821098460071",
        timeout: timeout,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
        verificationCompleted: _linkWithPhoneNumber,
        verificationFailed: verificationFailed);
    return null;
  }

  codeAutoRetrievalTimeout(String verificationId) {
    // TODO :
    // _updateRefreshing(false);
    setState(() {
      this.verificationId = verificationId;
      this.codeTimedOut = true;
    });
  }

  codeSent(String verificationId, [int forceResendingToken]) async {
    codeTimer = Timer(timeout, () {
      setState(() {
        codeTimedOut = true;
      });
    });

    _updateRefreshing(false);
    setState(() {
      verificationId = verificationId;
      AccountSingleton().authSequenceType = AuthSequenceType.smsAuth;
    });
  }
}
