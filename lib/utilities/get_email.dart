import 'package:flutter/foundation.dart';
import 'package:flutter_app/pages/SharedPreference/shared_preference.dart';
import 'package:flutter_app/state/app_state.dart';
import 'package:provider/provider.dart';

getEmail(context){
  getSharedPreference("email").then((value) async {
     Provider.of<Auth>(context,listen: false).setEmailFun(value.toString());
  });
  return Provider.of<Auth>(context,listen: false).getEmailFun();
}