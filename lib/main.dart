import 'package:flutter/material.dart';
import 'package:flutter_app/constants/constant.dart';
import 'package:flutter_app/pages/SharedPreference/shared_preference.dart';
import 'package:flutter_app/pages/home.dart';
import 'package:flutter_app/pages/login/signin.dart';
import 'package:flutter_app/pages/person_header/person_header.dart';
import 'package:flutter_app/pages/profile/Profile.dart';
import 'package:flutter_app/pages/recover_password/recover_password.dart';
import 'package:flutter_app/pages/register/signup.dart';
import 'package:flutter_app/pages/register/termsAndCondition.dart';
import 'package:flutter_app/pages/search/search.dart';
import 'package:flutter_app/pages/search/search_display.dart';
import 'package:flutter_app/pages/search/search_result.dart';
import 'package:flutter_app/pages/settings/settings.dart';
import 'package:flutter_app/pages/splash/splash_screen.dart';
import 'package:flutter_app/state/app_state.dart';
import 'package:flutter_app/theme/theme.dart';
import 'package:provider/provider.dart';

void main() async {
    runApp(
      ChangeNotifierProvider<AppState>(
        create: (_) => AppState(),
        child: MyApp(),
      ),
    );
}

class MyApp extends StatefulWidget{
  _MyApp createState()=>_MyApp();
}

class _MyApp extends State<MyApp> {

  bool isDark=true;


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

    AppState themeNotifier = Provider.of<AppState>(context);
    return MaterialApp(initialRoute:Constant.SPLASH_SCREEN,
        theme:  themeNotifier.getTheme(),
        routes: {
          Constant.SPLASH_SCREEN: (context) => SPlashBackground(),
          Constant.SIGN_IN: (context) => SignInPage(title: "hello",),
          Constant.SIGN_UP: (context) => SignUpScreen(),
          Constant.HOME: (context) => Home(),
          Constant.SETTING:(context)=>SettingScreen(),
          Constant.PROFILE:(context)=>ProfileOnePage(),
          Constant.TERMS_AND_CONDTION:(context)=>TermsAndConditions(),
          Constant.RECOVER_PASSWORD:(context)=>RecoverPassword(),
          Constant.PERSON_HEADER:(context)=>PersonHeaderFun(),
          Constant.SEARCH:(context)=>MaterialSearchResult(),
          Constant.SEARCH_DISPLAY:(context)=>SearchDisplayScreen(),

        });




  }



  }
