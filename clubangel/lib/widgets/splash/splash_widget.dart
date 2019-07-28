import 'dart:async';
import 'package:clubangel/loaders/localizable_loader.dart';
import 'package:clubangel/managers/localizable_manager.dart';
import 'package:clubangel/widgets/mains/main_widget.dart';
import 'package:flutter/material.dart';

class SplashWidget extends StatefulWidget {
  @override
  _SplashWidgetState createState() => _SplashWidgetState();
}

class _SplashWidgetState extends State<SplashWidget> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<Timer> loadData() async {
    return new Timer(Duration(seconds: 3), onDoneLoading);
  }

  onDoneLoading() async {
    localizableManager.onLocaleChanged(Locale(localizableManager.supportedLanguagesCodes[1]));
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MainWidget()));
  }

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        radius: 50.0,
                        child: Icon(Icons.access_alarm, size: 50.0),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20.0),
                      ),
                      Text(LocalizableLoader.of(context).text("app_title"),
                          style: TextStyle(
                              fontSize: 24.0, fontWeight: FontWeight.bold))
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                    ),
                    Text(
                      LocalizableLoader.of(context)
                          .text("splash_screen_loading"),
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
