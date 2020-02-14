import 'package:flutter/material.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/utilities/confirmation_abstract/confirmation_abstract.dart';

class Constant{
  String appName = "Contact Managment";
 // routes constant
  static String SIGN_IN ='signIn';
  static String SIGN_UP ='signUp';
  static String SUBMIT ='Submit';
  static String SPLASH_SCREEN ='splashscreen';
  static String HOME ='home';
  static String SEARCH="search";
  static String SETTING="Settings";
  static String DIALOGE_PAGE="Dialogue Page";
  static String PROFILE="Profile";
  static String ABOUT_US="About Us";
  static String PICK_PROFILE_PICHTURE="Pick Profile Picture";
  static String TERMS_AND_CONDTION="Terms and Conditions";
  static String SUCCESS="Success";
  static String CONTACT_INFO="ContactInformation";
  static String NOTES="Notes";
  static String DASHBOARD="Dashboard";
  static String RECOVER_PASSWORD="Recover_password";
  static String PERSON_HEADER="person_header";
  static String SEARCH_DISPLAY="search_display";

// labels
  static String ADD_NEW_PERSON="Add new Person";
  static String LAST_CONTACT="Last Contact";
  static String UPCOMING_BIRTHDAYS="Upcoming Birthdays";
  static String RESETPASSWORD="Reset Your Password";
  static String RECOVERPASSWORD="Recover Password";
  static String SIGNIN="Sign in";
  static String SIGNUP ="Sign up";
  static String PASSWORDRESETDESC ="It's ok, we all forget out password sometimes. "
      "Fill out your email to get a reset link sent to your email. "
      "You also might consider getting a password manager like 1Password or Bitwarden";
  static const String XS="XS";
  static const String S="S";
  static const String M="M";
  static const String L="L";
  static const String XL="XL";
  static const String H1="H1";
  static const String H2="H1";
  static const String H3="H1";
  static const String H4="H1";
  static const String H5="H1";
  static const String H6="H1";
  static const String HX="HX";




  // classses
  static shouldImp callBack;





  static List<String> images = [
    'https://cdn.pixabay.com/photo/2015/07/17/22/43/student-849825_1280.jpg',
    'https://cdn.pixabay.com/photo/2014/05/02/21/50/home-office-336377_1280.jpg',
    'https://images.pexels.com/photos/801816/pexels-photo-801816.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=750&w=1260',
    'https://firebasestorage.googleapis.com/v0/b/dl-flutter-ui-challenges.appspot.com/o/img%2F4.jpg?alt=media',
    'https://firebasestorage.googleapis.com/v0/b/dl-flutter-ui-challenges.appspot.com/o/img%2F5.jpg?alt=media',
    'https://firebasestorage.googleapis.com/v0/b/dl-flutter-ui-challenges.appspot.com/o/img%2F6.jpg?alt=media',
    'https://firebasestorage.googleapis.com/v0/b/dl-flutter-ui-challenges.appspot.com/o/img%2F7.jpg?alt=media',
  ];
  // static final ThemeData darkTheme1 = ThemeData(
  //   scaffoldBackgroundColor: Colors.black,
  //   appBarTheme: AppBarTheme(
  //     color: Colors.black,
  //     iconTheme: IconThemeData(
  //       color: Colors.white,
  //     ),
  //   ),
  //   colorScheme: ColorScheme.light(
  //     primary: Colors.black,
  //     onPrimary: Colors.black,
  //     primaryVariant: Colors.black,
  //     secondary: Colors.red,
  //   ),
  //   cardTheme: CardTheme(
  //     color: Colors.black,
  //   ),
  //   iconTheme: IconThemeData(
  //     color: Colors.white54,
  //   ),
  //   textTheme: TextTheme(
  //     title: TextStyle(
  //       color: Colors.white,
  //       fontSize: 20.0,
  //     ),
  //     subtitle: TextStyle(
  //       color: Colors.white70,
  //       fontSize: 18.0,
  //     ),
  //   ),
  // );

  static ThemeData lightTheme = ThemeData(
    fontFamily: "TimesNewRoman",
    backgroundColor: TRIAL_COLOR,
    primaryColor: lightPrimary,
    accentColor:  lightAccent,
    cursorColor: lightAccent,
indicatorColor: PRIMARY_COLOR,
brightness: Brightness.light,

    iconTheme: IconThemeData(color: Colors.white),
bottomAppBarTheme: BottomAppBarTheme(

  color: Colors.red,
  elevation: 0,
),
   scaffoldBackgroundColor: TRIAL_COLOR,
    appBarTheme: AppBarTheme(
      color: PRIMARY_COLOR,
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
//    cardColor:COLOR_CREAM ,
    brightness: Brightness.dark,
    backgroundColor: darkBG,
    primaryColor: darkPrimary,
    accentColor: darkAccent,

//    scaffoldBackgroundColor: darkBG,
textTheme: TextTheme(
      title: TextStyle(
        color: Colors.white,
        fontSize: 20.0,
      ),
),
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

static  fontSize(type){
  switch(type){
    case XS:
      return 10.0;

    case S:
      return 12.0;
    case M:
      return 14.0;

    case L:
      return 18.0;
    case XL:
      return 22.0;

    case HX:
      return 40.0;
    case H1:
      return 38.0;
    case H2:
      return 36.0;

    case H3:
      return 34.0;

    case H4:
      return 30.0;
    case H5:
      return 26.0;
    case H6:
      return 24.0;

  }
}

}


class PhoneType {
  int id;
  String name;

  PhoneType(this.id, this.name);

  static List<PhoneType> getPhones() {
    return <PhoneType>[
      PhoneType(0, 'Type'),
      PhoneType(1, 'Home'),
      PhoneType(2, 'Work'),
      PhoneType(3, 'Fax'),
      PhoneType(4, 'Mobile'),
      PhoneType(5, 'Line'),
    ];
  }
}


class EmailType {
  int id;
  String name;

  EmailType(this.id, this.name);

  static List<EmailType> getEmails() {
    return <EmailType>[
      EmailType(0, 'Type'),
      EmailType(1, 'Gmail'),
      EmailType(2, 'Icloud'),
      EmailType(3, 'Yahoo'),
      EmailType(4, 'Hotbird'),
    ];
  }
}