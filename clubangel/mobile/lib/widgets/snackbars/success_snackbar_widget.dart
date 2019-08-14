import 'package:flutter/material.dart';

class SuccessSnackbarWidget {
  @override
  SuccessSnackbarWidget();

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
              Icon(Icons.check, color: Colors.green),
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
