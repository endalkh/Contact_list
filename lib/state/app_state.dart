import 'package:flutter/material.dart';
import 'package:flutter_app/constants/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppState with ChangeNotifier {
  ThemeData _themeData;

  AppState() {
    findTheme();
  }
//  Future<bool> getSettingPref() async {
//    SharedPreferences preferences = await SharedPreferences.getInstance();
//    try{
//      if(preferences.getBool("dark")) {
//        _themeData=Constant.darkTheme;
//      }
//      else{
//        _themeData=Constant.lightTheme;
//      }
//    }
//    catch(ex){
//      return false;
//    }
//  }


  Future findTheme() async {
    final pref = await SharedPreferences.getInstance();
    final dark = pref.getBool("dark");
//    final tokenP = pref.getString('token') ?? "";
//    if (tokenP != "") _token = tokenP;
    if (dark)
      setDark();
    else
      setLight();
  }

  getTheme() {
    return _themeData;
  }


  void setDark() {
    _themeData = Constant.darkTheme;
    notifyListeners();
  }

  void setLight() {
    _themeData =Constant.lightTheme;
    notifyListeners();
  }
}
