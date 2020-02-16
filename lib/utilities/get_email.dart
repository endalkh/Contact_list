import 'package:flutter/foundation.dart';
import 'package:flutter_app/pages/SharedPreference/shared_preference.dart';
import 'package:flutter_app/state/app_state.dart';
import 'package:provider/provider.dart';

getEmail(@required context){
  getSettingPref("email").then((value) async {
    await Provider.of<Auth>(context,listen: false).setEmailFun("endalk");
  });

  return Provider.of<Auth>(context,listen: false).getEmailFun();
}