import 'package:flutter/material.dart';
import 'package:flutter_app/constants/constant.dart';
import 'package:flutter_app/pages/home.dart';
import 'package:flutter_app/pages/login/signin.dart';
import 'package:flutter_app/pages/profile/Profile.dart';
import 'package:flutter_app/pages/register/signup.dart';
import 'package:flutter_app/pages/register/termsAndCondition.dart';
import 'package:flutter_app/pages/settings/settings.dart';
import 'package:flutter_app/pages/splash/splash_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  build(context) {
    return MaterialApp(initialRoute:Constant.SIGN_IN,
        theme: Constant.lightTheme,
        routes: {
      Constant.SPLASH_SCREEN: (context) => SplashScreen(),
      Constant.SIGN_IN: (context) => SignInPage(title: "hello",),
      Constant.SIGN_UP: (context) => SignUpScreen(),
      Constant.HOME: (context) => Home(),
      Constant.SETTING:(context)=>SettingScreen(),
      Constant.PROFILE:(context)=>ProfileOnePage(),
      Constant.TERMS_AND_CONDTION:(context)=>TermsAndConditions(),

    });
  }
}