 import 'package:delalaw/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

CircularIndicator (){
  return Container(
    child:Center(
      child:Opacity(
        opacity: 0.5,
        child:  CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Colors.blue),
            strokeWidth: 5.0,
        backgroundColor: COLOR_SECONDARY,
        ),

      )
    ),
        decoration: BoxDecoration(
          color: Colors.white,
        )


  );

 }