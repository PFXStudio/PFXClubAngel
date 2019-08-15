import 'package:clubangel/singletons/keyboard_singleton.dart';
import 'package:clubangel/themes/main_theme.dart';
import 'package:clubangel/widgets/accounts/account_auth.dart';
import 'package:clubangel/widgets/accounts/account_auth_widget.dart';
import 'package:clubangel/widgets/accounts/account_init_profile_widget.dart';
import 'package:clubangel/widgets/accounts/auth_page.dart';
import 'package:clubangel/widgets/mains/main_widget.dart';
import 'package:clubangel/widgets/snackbars/success_snackbar_widget.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:clubangel/delegates/localizable_delegate.dart';
import 'package:clubangel/widgets/splash/splash_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:core/src/blocs/import.dart';
import 'package:core/src/models/import.dart';

import 'managers/localizable_manager.dart';

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) => runApp(MainApp()));
}

class MainApp extends StatefulWidget {
  MainApp();

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
    KeyboardSingleton().initialize();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<AuthBloc>.value(value: AuthBloc.instance()),
          ChangeNotifierProvider<ProfileBloc>.value(
              value: ProfileBloc.instance()),
        ],
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
          home: DynamicInitialPage(),
          localizationsDelegates: [
            _localizableDelegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: localizableManager.supportedLocales(),
          routes: <String, WidgetBuilder>{
            '/home': (BuildContext context) => MainWidget()
          },
        ));
  }

  void onLocaleChange(Locale locale) {
    setState(() {
      _localizableDelegate = LocalizableDelegate(newLocale: locale);
    });
  }
}

class DynamicInitialPage extends StatefulWidget {
  @override
  _DynamicInitialPageState createState() => _DynamicInitialPageState();
}

class _DynamicInitialPageState extends State<DynamicInitialPage> {
  bool _hasProfile;

  Future<void> _getHasProfile(
      {@required AuthBloc authBloc, @required ProfileBloc profileBloc}) async {
    final bool hasProfile = await profileBloc.hasProfile;
    if (hasProfile != _hasProfile) {
      setState(() {
        _hasProfile = hasProfile;
        initialize(authBloc, profileBloc, hasProfile);
      });
    }
  }

  void initialize(@required AuthBloc authBloc,
      @required ProfileBloc profileBloc, bool hasProfile) async {
    if (hasProfile == true) {
      return;
    }

    Profile profile = Profile();
    profile.userID = await authBloc.getUser;
    profile.phoneNumber = await authBloc.getUserPhoneNumber;
    profile.created = DateTime.now().millisecondsSinceEpoch;

    bool result =
        await profileBloc.updateProfile(profile: profile, thumbnailImage: null);
    if (result == false) {
      // TODO : error
      return;
    }
  }

  Widget _displayedAuthenticatedPage({@required ProfileBloc profileBloc}) {
    return _hasProfile
        ? MainWidget()
        // : ProfileFormPage();
        : AccountInitProfileWidget();
  }

  @override
  Widget build(BuildContext context) {
    // final AuthBloc _authBloc = Provider.of<AuthBloc>(context);
    final ProfileBloc _profileBloc = Provider.of<ProfileBloc>(context);

    return Consumer<AuthBloc>(
      builder: (BuildContext context, AuthBloc authBloc, Widget child) {
        switch (authBloc.authState) {
          case AuthState.Uninitialized:
            return SplashWidget();
          case AuthState.Authenticating:
          case AuthState.Authenticated:
            _getHasProfile(authBloc: authBloc, profileBloc: _profileBloc);

            return _hasProfile != null
                ? _displayedAuthenticatedPage(profileBloc: _profileBloc)
                : Scaffold(
                    backgroundColor: Colors.transparent,
                    body: Center(child: CircularProgressIndicator()));

          case AuthState.Unauthenticated:
            return AuthPage();
        }
      },
    );
  }
}
