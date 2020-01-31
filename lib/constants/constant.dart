import 'package:flutter/material.dart';
import 'package:flutter_app/constants/colors.dart';

class Constant{

  String appName = "Contact Managment";

  static String SIGN_IN = 'signin';
  static String SIGN_UP ='signup';
  static String SPLASH_SCREEN ='splashscreen';
  static String HOME ='home';
  static String HOME_CATAGORY='Homecatagory';
  static String SEARCH="search";
  static String SETTING="SETTING";
  static String MESSAGE="MESSAGE";
  static String CHAT="CHAT";
  static String CHAT_LIST="CHAT_LIST";
  static String POST="POST";
  static String NOTIFIACTION_SCREEN="NOTIFIACTION_SCREEN";
  static String DIALOGE_PAGE="DIALOGEPAGE";
  static String PROFILE="Profile";
  static String ABOUT_US="ABOUT_US";
  static String PAYMENT="PAYMENT";
  static String PICK_PROFILE_PICHTURE="PICK_PROFILE_PICHTURE";
  static String TERMS_AND_CONDTION="TERMS_AND_CONDTION";
  static String FAIL_TO_UPLOAD_IMAGE="Failed to upload image";
  static String SUCCESS="Success";

  static List<String> images = [
    'https://cdn.pixabay.com/photo/2015/07/17/22/43/student-849825_1280.jpg',
    'https://cdn.pixabay.com/photo/2014/05/02/21/50/home-office-336377_1280.jpg',
    'https://images.pexels.com/photos/801816/pexels-photo-801816.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=750&w=1260',
    'https://firebasestorage.googleapis.com/v0/b/dl-flutter-ui-challenges.appspot.com/o/img%2F4.jpg?alt=media',
    'https://firebasestorage.googleapis.com/v0/b/dl-flutter-ui-challenges.appspot.com/o/img%2F5.jpg?alt=media',
    'https://firebasestorage.googleapis.com/v0/b/dl-flutter-ui-challenges.appspot.com/o/img%2F6.jpg?alt=media',
    'https://firebasestorage.googleapis.com/v0/b/dl-flutter-ui-challenges.appspot.com/o/img%2F7.jpg?alt=media',
  ];

  static ThemeData lightTheme = ThemeData(
    fontFamily: "TimesNewRoman",
    backgroundColor: lightBG,
    primaryColor: lightPrimary,
    accentColor:  lightAccent,
    cursorColor: lightAccent,
    scaffoldBackgroundColor: lightBG,
    appBarTheme: AppBarTheme(
      elevation: 0,
      textTheme: TextTheme(
        title: TextStyle(
          fontFamily: "TimesNewRoman",
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.w800,
        ),
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    fontFamily: "TimesNewRoman",
    brightness: Brightness.dark,
    backgroundColor: darkBG,
    primaryColor: darkPrimary,
    accentColor: darkAccent,
    scaffoldBackgroundColor: darkBG,
    cursorColor: darkAccent,
    appBarTheme: AppBarTheme(
      elevation: 0,
      textTheme: TextTheme(
        title: TextStyle(
          fontFamily: "TimesNewRoman",
          color: lightBG,
          fontSize: 20,
          fontWeight: FontWeight.w800,
        ),
      ),
    ),
  );

}