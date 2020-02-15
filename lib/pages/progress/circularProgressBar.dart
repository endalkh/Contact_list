import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constants/colors.dart';

circularIndicator (){
  return Container(
    child:Center(
      child:Opacity(
        opacity: 0.5,
        child:  CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(SECONDARY_COLOR),
            strokeWidth: 5.0,
        backgroundColor: PRIMARY_COLOR,
        ),

      )
    ),



  );

 }