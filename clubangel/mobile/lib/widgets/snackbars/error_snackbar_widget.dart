import 'package:clubangel/themes/main_theme.dart';
import 'package:flutter/material.dart';

class ErrorSnackbarWidget {
  @override
  ErrorSnackbarWidget();

  void show(
      GlobalKey<ScaffoldState> key, String message, void Function() callback) {
    if (key == null) {
      return;
    }

    final maxDuration = 3;
    key.currentState
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          duration: Duration(seconds: maxDuration),
          backgroundColor: Colors.black87,
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Text(message)),
              Icon(Icons.error_outline, color: Colors.red),
            ],
          ),
        ),
      );

    Future.delayed(Duration(seconds: maxDuration), () {
      // deleayed code here
      key.currentState..hideCurrentSnackBar();

      if (callback == null) {
        return;
      }

      callback();
    });
  }
}
