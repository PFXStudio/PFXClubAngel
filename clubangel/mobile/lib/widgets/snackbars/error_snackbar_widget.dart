import 'package:flutter/material.dart';

class ErrorSnackbarWidget {
  @override
  ErrorSnackbarWidget();

  void show(BuildContext context, String message, void Function() callback) {
    final maxDuration = 3;
    Scaffold.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          duration: Duration(seconds: maxDuration),
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
      Scaffold.of(context)..hideCurrentSnackBar();

      if (callback == null) {
        return;
      }

      callback();
    });
  }
}
