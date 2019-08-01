import 'package:clubangel/singletons/keyboard_singleton.dart';
import 'package:clubangel/themes/main_theme.dart';
import 'package:core/core.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:clubangel/delegates/localizable_delegate.dart';
import 'package:clubangel/widgets/splash/splash_widget.dart';
import 'package:flutter/material.dart';
import 'package:key_value_store_flutter/key_value_store_flutter.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:http/http.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'managers/localizable_manager.dart';

void main() async {
  final prefs = await SharedPreferences.getInstance();
  final keyValueStore = FlutterKeyValueStore(prefs);
  final store = createStore(Client(), keyValueStore);
  // debugPaintSizeEnabled = true;

  runApp(MainApp(store));
}

class MainApp extends StatefulWidget {
  MainApp(this.store);
  final Store<AppState> store;

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  LocalizableDelegate _localizableDelegate;

  @override
  void initState() {
    super.initState();
    widget.store.dispatch(InitAction());
    _localizableDelegate = LocalizableDelegate(newLocale: null);
    localizableManager.onLocaleChanged = onLocaleChange;
    KeyboardSingleton().initialize();
  }

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
        store: widget.store,
        child: MaterialApp(
          theme: ThemeData(
            primaryColor: MainTheme.bgndColor,
            // primaryColorLight: Colors.black, // ?
            // primaryColorDark: Colors.lightBlue[900], // 객체 배경색
            // canvasColor: Colors.white, // 배경색
            // indicatorColor: Colors.red, // ?
            // bottomAppBarColor: Colors.red, // ?
            // cardColor: Colors.red, // ?
            // dividerColor: Colors.red, // ?
            // focusColor: Colors.red, // ?
            // hoverColor: Colors.red, // ?
            // highlightColor: Colors.red, // ?
            // splashColor: Colors.red, // ?
            // selectedRowColor: Colors.red, // ?
            // unselectedWidgetColor: Colors.red, // ?
            // disabledColor: Colors.red, // ?
            // buttonColor: Colors.red, // ?
            // secondaryHeaderColor: Colors.red, // ?
            // textSelectionColor: Colors.red, // ?
            // cursorColor: Colors.red, // ?
            // textSelectionHandleColor: Colors.red, // ?
            // backgroundColor: Colors.red, // ?
            // dialogBackgroundColor: Colors.red, // ?
            // hintColor: Colors.red, // ?
            // errorColor: Colors.red, // ?
            // toggleableActiveColor: Colors.red,
            fontFamily: 'Roboto',
            textTheme: TextTheme(
              headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
              title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
              body1: TextStyle(fontSize: 14.0, fontFamily: 'Roboto'),
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
        ));
  }

  void onLocaleChange(Locale locale) {
    setState(() {
      _localizableDelegate = LocalizableDelegate(newLocale: locale);
    });
  }
}
