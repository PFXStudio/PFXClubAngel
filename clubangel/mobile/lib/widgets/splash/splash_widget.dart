import 'dart:async';
import 'package:clubangel/defines/define_images.dart';
import 'package:clubangel/loaders/localizable_loader.dart';
import 'package:clubangel/managers/localizable_manager.dart';
import 'package:clubangel/themes/main_theme.dart';
import 'package:clubangel/widgets/accounts/account_auth_widget.dart';
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
    return new Timer(Duration(seconds: 1), onDoneLoading);
  }

  onDoneLoading() async {
    // localizableManager
    //     .onLocaleChanged(Locale(localizableManager.supportedLanguagesCodes[1]));
    Navigator.of(context, rootNavigator: true).pushReplacement(
        MaterialPageRoute(builder: (context) => AccountAuthWidget()));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: new BoxDecoration(
              gradient: MainTheme.primaryLinearGradient,
            ),
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
                      Padding(
                        padding: EdgeInsets.only(top: 75.0),
                        child: new Image(
                            width: 200.0,
                            height: 200.0,
                            fit: BoxFit.fill,
                            image: new AssetImage(
                                DefineImages.icon_main_256_path)),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20.0),
                      ),
                      Text(LocalizableLoader.of(context).text("app_title"),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold))
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
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
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
