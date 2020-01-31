import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

Future<String>  getSharedPreference(key) async {
     final sharedPreferences =  await SharedPreferences.getInstance();

     return sharedPreferences.getString(key);
   }

savePref( {id,name,  email,photo})  async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  try{
      preferences.setString("id", id);
      preferences.setString("name", name);
      preferences.setString("email", email);
      preferences.setString("photo", photo);
      print(name);
      return true;


  }
  catch(ex){

    return false;
  }
}
signOut() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setString("name", null);
  preferences.setString("email", null);
  preferences.setString("photo", null);

//      _loginStatus = LoginStatus.notSignIn;

}