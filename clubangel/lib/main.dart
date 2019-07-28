import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:clubangel/delegates/localizable_delegate.dart';
import 'package:clubangel/widgets/splash/splash_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'managers/localizable_manager.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  LocalizableDelegate _localizableDelegate;

  @override
  void initState() { 
    super.initState();
    _localizableDelegate = LocalizableDelegate(newLocale: null);
    localizableManager.onLocaleChanged = onLocaleChange;
  }

    void onLocaleChange(Locale locale) {
    setState(() {
      _localizableDelegate = LocalizableDelegate(newLocale: locale);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    theme:
      ThemeData(
        primaryColor: Colors.lightBlue[800], // 툴바 색
        accentColor: Colors.lightBlue[800], // 인디케이터 색
        // primaryColorLight: Colors.black, //?
        primaryColorDark: Colors.lightBlue[900], // 객체 배경색
        canvasColor: Colors.white, // 배경색
        //scaffoldBackgroundColor: Colors.red, // fold 배경색
        indicatorColor: Colors.red,
        bottomAppBarColor: Colors.red,
        cardColor: Colors.red,
        dividerColor: Colors.red,
        focusColor: Colors.red,
        hoverColor: Colors.red,
        highlightColor: Colors.red,
        splashColor: Colors.red,
        selectedRowColor: Colors.red,
        unselectedWidgetColor: Colors.red,
        disabledColor: Colors.red,
        buttonColor: Colors.red,
        secondaryHeaderColor: Colors.red,
        textSelectionColor: Colors.red,
        cursorColor: Colors.red,
        textSelectionHandleColor: Colors.red,
        backgroundColor: Colors.red,
        dialogBackgroundColor: Colors.red,
        hintColor: Colors.red,
        errorColor: Colors.red,
        toggleableActiveColor: Colors.red,
        fontFamily: 'Roboto',
          textTheme: TextTheme(
            headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
            title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
            body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
          ), 
        ),
      debugShowCheckedModeBanner: false,
      home: SplashWidget(),
      localizationsDelegates: [
        _localizableDelegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        ],
      supportedLocales: localizableManager.supportedLocales(),
    );
  }
}