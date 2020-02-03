//import 'package:flutter/material.dart';
//import 'package:flutter_app/constants/constant.dart';
//import 'package:shared_preferences/shared_preferences.dart';
//
//class ThemeNotifier with ChangeNotifier {
//  ThemeData _themeData;
////ThemeNotifier() {
////  getSettingPref();
////}
//  Future<bool> getSettingPref() async {
//    SharedPreferences preferences = await SharedPreferences.getInstance();
//    try{
//       if(preferences.getBool("dark")) {
//         _themeData=Constant.darkTheme;
//       }
//       else{
//         _themeData=Constant.lightTheme;
//       }
//    }
//    catch(ex){
//      return false;
//    }
//  }
//  ThemeNotifier() {
//    findTheme();
//  }
//
//  Future findTheme() async {
//    final pref = await SharedPreferences.getInstance();
//    final dark = pref.getBool("dark")?? false;
////    final tokenP = pref.getString('token') ?? "";
////    if (tokenP != "") _token = tokenP;
//    if (dark)
//      setDark();
//    else
//      setLight();
//  }
//
//  getTheme() {
//   return _themeData;
//  }
//
//  setTheme(ThemeData themeData) async {
//    _themeData = themeData;
//    notifyListeners();
//  }
//  void setDark() {
//    _themeData = Constant.darkTheme;
//    notifyListeners();
//  }
//
//  void setLight() {
//    _themeData =Constant.lightTheme;
//    notifyListeners();
//  }
//}
//
