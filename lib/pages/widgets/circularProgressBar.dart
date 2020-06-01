import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/constants/constant.dart';
import 'package:flutter_app/state/app_state.dart';
import 'package:provider/provider.dart';

circularIndicator({context}) {
  return Container(
      child: Center(
          child: Opacity(
        opacity: 0.5,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(PRIMARY_COLOR),
          strokeWidth: 5.0,
          backgroundColor: Colors.red,
        ),
      )),
      decoration: BoxDecoration(
        color: Provider.of<AppState>(context).getTheme() == Constant.lightTheme
            ? TRIAL_COLOR
            : null,
      ));
}
