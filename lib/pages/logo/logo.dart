import 'package:flutter/material.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/constants/constant.dart';
import 'package:flutter_app/state/app_state.dart';
import 'package:provider/provider.dart';


logo(context) {
  AppState themeNotifier = Provider.of<AppState>(context);
  return Container(
    height: 90,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      gradient: LinearGradient(colors: [PRIMARY_COLOR, SECONDARY_COLOR]),
      image: DecorationImage(
        image: themeNotifier.getTheme()==Constant.lightTheme? AssetImage("assets/logo_light.jpg"): AssetImage("assets/logo_dark.jpg"),
      ),
    ),
  );
}
