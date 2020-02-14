import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/api/model/login.dart';
import 'package:flutter_app/constants/constant.dart';
import 'package:flutter_app/pages/SharedPreference/shared_preference.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppState with ChangeNotifier {
  ThemeData _themeData;

  AppState() {
    findTheme();
  }

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


class LoginAuth with ChangeNotifier {
  JsonUser loginModel;

  getLoginData() {
    print(loginModel);
   return loginModel;
  }

  void setLoginData(loginModel){
    this.loginModel = loginModel;
    notifyListeners();

  }

}

class Auth with ChangeNotifier {
  bool isLoading=false;
  bool isLoged=false;
  String hasError="";
  String email;
  bool isSuccessfullyRegistered=false;
  String token;

  get_IsLoading(){
    return isLoading;
  }

  void setLoadingState(loading) async{
    this.isLoading = loading;
    notifyListeners();
  }

  get_hasError(){
    return hasError;
  }

  void set_hasError(hasEror){
    this.hasError = hasEror;
    notifyListeners();
  }

  get_registerError(){
    return hasError;
  }

  void set_registerError(hasEror){
    this.hasError = hasEror;
    notifyListeners();
  }

  is_logged(){
    getSharedPreference("accessToken").then((token) async{
     print(token);
     if(token.isNotEmpty){
       print("say something");
       isLoged=true;
     }
    });
   return isLoged;
  }

 get_email() {
    return email;
  }

   set_email(email) async{
    this.email = email;
    notifyListeners();
  }

  get_successfullyResgistered() {
    return isSuccessfullyRegistered;
  }

  set_successfullyResgistered(yes) async{
    this.isSuccessfullyRegistered = yes;
    notifyListeners();
  }

  get_token(){
    getSharedPreference("accessToken").then((token) async{
     this.token=token;
    });
    return token;
  }



}

