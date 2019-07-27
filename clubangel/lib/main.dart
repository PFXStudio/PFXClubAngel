import 'package:clubangel/views/splash_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() => runApp(new MaterialApp(
  theme:
    ThemeData(
      primaryColor: Colors.red, 
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
    home: SplashScreen(),
));

