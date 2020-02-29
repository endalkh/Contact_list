import 'package:flutter/material.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:jiffy/jiffy.dart';

class Constant{
  String appName = "Contact Managment";
 // routes constant
  static const String SIGN_IN ='signIn';
  static const String SIGN_UP ='signUp';
  static const String SUBMIT ='Submit';
  static const String SPLASH_SCREEN ='splashscreen';
  static const String HOME ='home';
  static const String SEARCH="search";
  static const String SETTING="Settings";
  static const String DIALOG_PAGE="Dialogue Page";
  static const String PROFILE="Profile";
  static const String ABOUT_US="About Us";
  static const String PICK_PROFILE_PICHTURE="Pick Profile Picture";
  static const String TERMS_AND_CONDTION="Terms and Conditions";
  static const String SUCCESS="Success";
  static const String CONTACT_INFO="ContactInformation";
  static const String NOTES="Notes";
  static const String DASHBOARD="Dashboard";
  static const String RECOVER_PASSWORD="Recover_password";
  static const String PERSON_HEADER="person_header";
  static const String SEARCH_DISPLAY="search_display";
  static const String  CONTACT_SYNC="search_display";

// labels
  static const String ADD_NEW_PERSON="Add new Person";
  static const String LAST_CONTACT="Last Contact";
  static const String UPCOMING_BIRTHDAYS="Upcoming Birthdays";
  static const String RESETPASSWORD="Reset Your Password";
  static const String RECOVERPASSWORD="Recover Password";
  static const String SIGNIN="Sign in";
  static const String SIGNUP ="Sign up";
  static const String PASSWORDRESETDESC ="It's ok, we all forget out password sometimes. "
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


//alert Messages
  static const String success="Your request done successfuly";
  static const String error="Unable to perform the action!";

  // Icon type
  static const String successIcon="success";
  static const String errorIcon="error";
  static const String warningIcon="warning";
  static const String infoIcon="info";






  //Birthday Picker
  static  var initialDate=Jiffy()..subtract(years: 100);
  static  var finalDate=Jiffy()..subtract(years: 18);





  static ThemeData lightTheme = ThemeData(
    fontFamily: "TimesNewRoman",
    backgroundColor: TRIAL_COLOR,
    primaryColor: lightPrimary,

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


//    scaffoldBackgroundColor: darkBG,
textTheme: TextTheme(
      title: TextStyle(
        color: Colors.white,
        fontSize: 20.0,
      ),
),
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
      PhoneType(0, 'Mobile'),
      PhoneType(1, 'Home'),
      PhoneType(2, 'Work'),
      PhoneType(3, 'Fax'),
      PhoneType(4, 'Line'),
    ];
  }
}


class EmailType {
  int id;
  String name;

  EmailType(this.id, this.name);

  static List<EmailType> getEmails() {
    return <EmailType>[
      EmailType(0, 'Gmail'),
      EmailType(1, 'Icloud'),
      EmailType(2, 'Yahoo'),
      EmailType(3, 'Hotbird'),
    ];
  }
}