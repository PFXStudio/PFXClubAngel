import 'package:clubangel/defines/define_enums.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AccountSingleton {
  AccountSingleton._internal();
  static final AccountSingleton _instance = new AccountSingleton._internal();

  factory AccountSingleton() {
    return _instance;
  }

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  GoogleSignInAccount googleUser;
  FirebaseUser firebaseUser;

  AuthSequenceType authSequenceType = AuthSequenceType.socialAuth;
}
