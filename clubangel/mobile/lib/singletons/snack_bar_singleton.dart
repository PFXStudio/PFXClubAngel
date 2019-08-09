import 'package:flutter/material.dart';

class SnackBarSingleton {
  SnackBarSingleton._internal();
  static final SnackBarSingleton _instance = new SnackBarSingleton._internal();
  GlobalKey<ScaffoldState> scaffoldKey;

  factory SnackBarSingleton() {
    return _instance;
  }

  void initialize(GlobalKey<ScaffoldState> scaffoldKey) {
    this.scaffoldKey = scaffoldKey;
  }

  void showError(String message) {
    if (scaffoldKey == null) {
      return;
    }

    scaffoldKey.currentState.showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
