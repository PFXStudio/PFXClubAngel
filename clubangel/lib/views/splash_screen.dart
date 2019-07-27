import 'dart:async';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), ()=> print("Done..."));
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
                        child: Icon(Icons.access_alarm,
                        size: 50.0),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top:20.0),
                        ),
                        Text(
                          "ClubAngel", style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold)
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                    ),
                    Text("Loading...", style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),)
                  ],
                ),)
              ],
            )
          ],
        ),
      );
  }
}