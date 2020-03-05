import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/api/model/contact_list.dart';
import 'package:flutter_app/api/model/contact_sync.dart';
import 'package:flutter_app/api/model/get_notes.dart';
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

    if (dark == true)
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
    _themeData = Constant.lightTheme;
    notifyListeners();
  }
}

class LoginAuth with ChangeNotifier {
  JsonUser loginModel;

  getLoginData() {
    print(loginModel);
    return loginModel;
  }

  void setLoginData(loginModel) {
    this.loginModel = loginModel;
    notifyListeners();
  }
}

class Auth with ChangeNotifier {
  bool isLoading = false;
  bool isLogged = false;
  String hasError = "";
  String email = "";
  bool isSuccessfullyRegistered = false;
  String token;
  int page = 0;
  int pageHeader = 0;
  List<GetAllContact> allContactList;
  bool addEmail = false, addPhone = false;
  bool addNote = false;
  bool editPhone = false;
  bool editEmail = false;
  bool editNote = false;
  bool editContact = false;
  String id = "";
  bool isPersonForSearch = true;
  List<GetAllContact> personList = [];
  List<GetNoteList> noteList = [];
  List<ContactSync> contactSync = [];

  getIsLogged() async {
    final pref = await SharedPreferences.getInstance();
    final token = pref.getBool("accessToken");
    if (token.toString().isEmpty == true || token == null) {
      this.isLogged = false;
      notifyListeners();
    } else {
      this.isLogged = true;
      notifyListeners();
    }
  }

  getIsLoadingFun() {
    return isLoading;
  }

  void setLoadingStateFun(loading) async {
    this.isLoading = loading;
    notifyListeners();
  }

  getHasErrorFun() {
    return hasError;
  }

  void setHasErrorFun(hasError) {
    this.hasError = hasError;
    notifyListeners();
  }

  getRegisterErrorFun() {
    return hasError;
  }

  void setRegisterErrorFun(hasEror) {
    this.hasError = hasEror;
    notifyListeners();
  }

  getEmailFun() {
    return email;
  }

  setEmailFun(email) async {
    this.email = email;
    notifyListeners();
  }

  getSuccessfullyRegisteredFun() {
    return isSuccessfullyRegistered;
  }

  setSuccessfullyRegisteredFun(yes) async {
    this.isSuccessfullyRegistered = yes;
    notifyListeners();
  }

  getTokenFun() {
    getSharedPreference("accessToken").then((token) async {
      this.token = token;
    });
    return token;
  }

  setAllContactFun(allContactList) async {
    this.allContactList = allContactList;
    notifyListeners();
  }

  getAllContactFun() {
    return allContactList;
  }

  setHomePageTabFun(index) async {
    this.page = index;
    notifyListeners();
  }

  getHomePageTabFun() {
    return page;
  }

  setPersonHeaderTabFun(index) async {
    this.pageHeader = index;
    notifyListeners();
  }

  getPersonHeaderTabFun() {
    return pageHeader;
  }

  setAddEmail(val) {
    this.addEmail = val;
    notifyListeners();
  }

  getAddEmail() {
    return this.addEmail;
  }

  setAddPhone(val) {
    this.addPhone = val;
    notifyListeners();
  }

  getAddPhone() {
    return this.addPhone;
  }

  setAddNote(val) {
    this.addNote = val;
    notifyListeners();
  }

  getAddNote() {
    return this.addNote;
  }

  setEditPhone(val) {
    this.editPhone = val;
    notifyListeners();
  }

  getEditPhone() {
    return this.editPhone;
  }

  setEditEmail(val) {
    this.editEmail = val;
    notifyListeners();
  }

  getEditEmail() {
    return this.editEmail;
  }

  setEditNote(val) {
    this.editNote = val;
    notifyListeners();
  }

  getEditNote() {
    return this.editNote;
  }

  setEditContact(val) {
    this.editContact = val;
    notifyListeners();
  }

  getEditContact() {
    return this.editContact;
  }

  setId(val) {
    this.id = val;
    notifyListeners();
  }

  getId() {
    return this.id;
  }

  clearPersonList() {
    this.personList.removeWhere((item) => item != null);
    notifyListeners();
  }

  removePersonList(id) {
    this.personList.removeWhere((item) => item !=null );
    notifyListeners();
  }

  setPersonList(List<GetAllContact> val) {
   personList=val;
    notifyListeners();
  }

  getPersonList() {
    return personList;
  }

  setContactSync(ContactSync val) {
    contactSync.add(val);

    notifyListeners();
  }

  clearContactSync() {
    this.contactSync.removeWhere((item) => item != null);
    notifyListeners();
  }

  notifier() {
    notifyListeners();
  }

  List<ContactSync> getContactSync() {
    return this.contactSync;
  }
}
