import 'package:flutter/material.dart';
import 'package:flutter_app/constants/constant.dart';
import 'package:flutter_app/pages/SharedPreference/shared_preference.dart';
import 'package:flutter_app/pages/home/home.dart';
import 'package:flutter_app/pages/login/signin.dart';
import 'package:flutter_app/pages/person_header/person_header.dart';
import 'package:flutter_app/pages/profile/Profile.dart';
import 'package:flutter_app/pages/recover_password/recover_password.dart';
import 'package:flutter_app/pages/register/signup.dart';
import 'package:flutter_app/pages/register/termsAndCondition.dart';
import 'package:flutter_app/pages/search/search_display.dart';
import 'package:flutter_app/pages/search/search_result.dart';
import 'package:flutter_app/pages/settings/settings.dart';
import 'package:flutter_app/pages/splash/splash_screen.dart';
import 'package:flutter_app/state/app_state.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool logged=false;
  if(prefs.getString("accessToken")!=null){
    logged=true;
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

class MyApp extends StatefulWidget{
   bool logged;
  MyApp(logged){
    this.logged=logged;
  }
  _MyApp createState()=>_MyApp(logged);
}

class _MyApp extends State<MyApp> {
  bool isDark=true;
  bool logged=false;
  _MyApp(logged){
    this.logged=logged;
  }



 getTheme() async {

   getSettingPref("dark").then((value)async{
     setState(()  {
        isDark= value;
     });

   });
}

  @override
  build(context) {
    AppState themeNotifier = Provider.of<AppState>(context);

    return MaterialApp(initialRoute:logged==true?Constant.HOME:Constant.SIGN_IN,
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
