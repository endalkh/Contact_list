import 'package:flutter/material.dart';
import 'package:flutter_app/constants/colors.dart';

class Constant{

  String appName = "Contact Managment";

  static String SIGN_IN = 'sign in';
  static String SIGN_UP ='sign up';
  static String SUBMIT ='Submit';
  static String SPLASH_SCREEN ='splashscreen';
  static String HOME ='home';
  static String HOME_CATAGORY='Homecatagory';
  static String SEARCH="search";
  static String SETTING="SETTING";
  static String DIALOGE_PAGE="DIALOGEPAGE";
  static String PROFILE="Profile";
  static String ABOUT_US="ABOUT_US";
  static String PAYMENT="PAYMENT";
  static String PICK_PROFILE_PICHTURE="PICK_PROFILE_PICHTURE";
  static String TERMS_AND_CONDTION="TERMS_AND_CONDTION";
  static String FAIL_TO_UPLOAD_IMAGE="Failed to upload image";
  static String SUCCESS="Success";
  static String CONTACT_INFO="Contact Information";
  static String NOTES="Notes";
  static String DASHBOARD="Dashboard";
  static String ADD_NEW_PERSON="Add new Person";
  static String LAST_CONTACT="Last Contact";
  static String UPCOMING_BIRTHDAYS="Upcoming Birthdays";

  //font
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



  static List<String> images = [
    'https://cdn.pixabay.com/photo/2015/07/17/22/43/student-849825_1280.jpg',
    'https://cdn.pixabay.com/photo/2014/05/02/21/50/home-office-336377_1280.jpg',
    'https://images.pexels.com/photos/801816/pexels-photo-801816.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=750&w=1260',
    'https://firebasestorage.googleapis.com/v0/b/dl-flutter-ui-challenges.appspot.com/o/img%2F4.jpg?alt=media',
    'https://firebasestorage.googleapis.com/v0/b/dl-flutter-ui-challenges.appspot.com/o/img%2F5.jpg?alt=media',
    'https://firebasestorage.googleapis.com/v0/b/dl-flutter-ui-challenges.appspot.com/o/img%2F6.jpg?alt=media',
    'https://firebasestorage.googleapis.com/v0/b/dl-flutter-ui-challenges.appspot.com/o/img%2F7.jpg?alt=media',
  ];
  static final ThemeData darkTheme1 = ThemeData(
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: AppBarTheme(
      color: Colors.black,
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    colorScheme: ColorScheme.light(
      primary: Colors.black,
      onPrimary: Colors.black,
      primaryVariant: Colors.black,
      secondary: Colors.red,
    ),
    cardTheme: CardTheme(
      color: Colors.black,
    ),
    iconTheme: IconThemeData(
      color: Colors.white54,
    ),
    textTheme: TextTheme(
      title: TextStyle(
        color: Colors.white,
        fontSize: 20.0,
      ),
      subtitle: TextStyle(
        color: Colors.white70,
        fontSize: 18.0,
      ),
    ),
  );

  static ThemeData lightTheme = ThemeData(
    fontFamily: "TimesNewRoman",
    backgroundColor: lightBG,
    primaryColor: lightPrimary,
    accentColor:  lightAccent,
    cursorColor: lightAccent,
brightness: Brightness.light,
bottomAppBarTheme: BottomAppBarTheme(
  elevation: 0,
),
//    scaffoldBackgroundColor: lightBG,
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
//    cardColor:COLOR_CREAM ,
    brightness: Brightness.dark,
    backgroundColor: darkBG,
    primaryColor: darkPrimary,
    accentColor: darkAccent,

//    scaffoldBackgroundColor: darkBG,
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
      PhoneType(1, 'Apple'),
      PhoneType(2, 'Google'),
      PhoneType(3, 'Samsung'),
      PhoneType(4, 'Sony'),
      PhoneType(5, 'LG'),
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
      EmailType(1, 'Apple'),
      EmailType(2, 'Google'),
      EmailType(3, 'Samsung'),
      EmailType(4, 'Sony'),
      EmailType(5, 'LG'),
    ];
  }
}