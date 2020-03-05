import 'package:flutter/material.dart';
import 'package:flutter_app/constants/constant.dart';
import 'package:flutter_app/pages/contact_sync/contact_sync.dart';
import 'package:flutter_app/pages/home/home.dart';
import 'package:flutter_app/pages/login/signin.dart';
import 'package:flutter_app/pages/recover_password/recover_password.dart';
import 'package:flutter_app/pages/register/signup.dart';
import 'package:flutter_app/pages/splash/splash_screen.dart';
import 'package:flutter_app/state/app_state.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool logged = false;
  if (prefs.getString("accessToken") != null ||
      prefs.getString("accessToken").toString().isEmpty == true) {
    logged = true;
  }
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppState()),
        ChangeNotifierProvider(create: (_) => LoginAuth()),
        ChangeNotifierProvider(create: (_) => Auth()),
      ],
      child: MyApp(logged),
    ),
  );
}

// ignore: must_be_immutable
class MyApp extends StatefulWidget {
  bool logged;
  MyApp(logged) {
    this.logged = logged;
  }
  _MyApp createState() => _MyApp(logged);
}

class _MyApp extends State<MyApp> {
  bool isDark = true;
  bool logged = false;

  _MyApp(logged) {
    this.logged = logged;
  }

  @override
  build(context) {
    AppState themeNotifier = Provider.of<AppState>(context);
    return MaterialApp(
      showSemanticsDebugger: false,
        debugShowCheckedModeBanner: false,
        initialRoute: logged == true ? Constant.HOME : Constant.SPLASH_SCREEN,
        theme: themeNotifier.getTheme(),
        routes: {
          Constant.SPLASH_SCREEN: (context) => SPlashBackground(),
          Constant.SIGN_IN: (context) => SignInPage(),
          Constant.SIGN_UP: (context) => SignUpScreen(),
          Constant.HOME: (context) => Home(),
          Constant.RECOVER_PASSWORD: (context) => RecoverPassword(),
          Constant.CONTACT_SYNC: (context) => ContactListPage(),
        });
  }
}
