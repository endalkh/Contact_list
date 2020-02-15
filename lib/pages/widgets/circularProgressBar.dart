import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constants/colors.dart';

circularIndicator (){
  return Container(
    child:Center(
      child:Opacity(
        opacity: 0.5,
        child:  CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(PRIMARY_COLOR),
            strokeWidth: 5.0,
        backgroundColor: Colors.red,
        ),

      )
    ),
        decoration: BoxDecoration(
          color: SECONDARY_COLOR,
        )


  );

 }