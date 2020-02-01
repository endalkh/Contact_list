import 'package:flutter/material.dart';
import 'package:flutter_app/constants/constant.dart';
import 'package:flutter_app/pages/SharedPreference/shared_preference.dart';
import 'package:flutter_app/pages/home.dart';
import 'package:flutter_app/pages/login/signin.dart';
import 'package:flutter_app/pages/profile/Profile.dart';
import 'package:flutter_app/pages/register/signup.dart';
import 'package:flutter_app/pages/register/termsAndCondition.dart';
import 'package:flutter_app/pages/settings/settings.dart';
import 'package:flutter_app/pages/splash/splash_screen.dart';
import 'package:flutter_app/theme/theme.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
void main() => runApp(
  ChangeNotifierProvider<ThemeNotifier>(
    create: (_) => ThemeNotifier(Constant.darkTheme),
    child: MyApp(),
  ),
);







class MyApp extends StatefulWidget{
  _MyApp createState()=>_MyApp();
}

class _MyApp extends State<MyApp> {
  var themeNotifier;
  bool isDark=true;
  _MyApp(){
    getTheme();
  }

 getTheme() async {

   getSettingPref("dark").then((value)async{
     setState(()  {
        isDark= value;
     });

     print("results $isDark");
   });
}
  @override
  build(context) {

     themeNotifier = Provider.of<ThemeNotifier>(context);

    return MaterialApp(initialRoute:Constant.SIGN_IN,
        theme: themeNotifier.getTheme(),

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