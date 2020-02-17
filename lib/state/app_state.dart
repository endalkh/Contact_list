import 'package:flutter/material.dart';
import 'package:flutter_app/api/model/contact_list.dart';
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
  bool isLogged=false;
  String hasError="";
  String email="";
  bool isSuccessfullyRegistered=false;
  String token;
  int page=0;
  List<GetAllContact> allContactList;
  bool addEmail=false,addPhone=false;
  bool addNote=false;
  bool editPhone=false;
  String id="";


  getIsLoadingFun(){
    return isLoading;
  }

  void setLoadingStateFun(loading) async{
    this.isLoading = loading;
    notifyListeners();
  }

  getHasErrorFun(){
    return hasError;
  }

  void setHasErrorFun(hasError){
    this.hasError = hasError;
    notifyListeners();
  }

  getRegisterErrorFun(){
    return hasError;
  }

  void setRegisterErrorFun(hasEror){
    this.hasError = hasEror;
    notifyListeners();
  }

  isLoggedFun(){
    getSharedPreference("accessToken").then((token) async{
     print(token);
     if(token.isNotEmpty){
       print("say something");
       isLogged=true;
     }
    });
   return isLogged;
  }

 getEmailFun() {
    return email;
  }

   setEmailFun(email) async{
    this.email = email;
    notifyListeners();
  }

  getSuccessfullyRegisteredFun() {
    return isSuccessfullyRegistered;
  }

  setSuccessfullyRegisteredFun(yes) async{
    this.isSuccessfullyRegistered = yes;
    notifyListeners();
  }

  getTokenFun(){
    getSharedPreference("accessToken").then((token) async{
     this.token=token;
    });
    return token;
  }

  setAllContactFun(allContactList) async{
    this.allContactList=allContactList;
    notifyListeners();
  }

  getAllContactFun(){
   return allContactList;
  }

  setHomePageTabFun(index) async{
    this.page=index;
    notifyListeners();
  }

  getHomePageTabFun(){
   return page;
  }

  setAddEmail(val){
    this.addEmail=val;
    notifyListeners();
  }
  getAddEmail(){
    return this.addEmail;
  }

  setAddPhone(val){
    this.addPhone=val;
    notifyListeners();
  }
  getAddPhone(){
    return this.addPhone;
  }

  setAddNote(val){
    this.addNote=val;
    notifyListeners();
  }
  getAddNote(){
    return this.addNote;
  }

  setEditPhone(val){
    this.editPhone=val;
    notifyListeners();
  }
  getEditPhone(){
    return this.editPhone;
  }

  setId(val){
    this.id=val;
    notifyListeners();
  }
  getId(){
    return this.id;
  }


}

