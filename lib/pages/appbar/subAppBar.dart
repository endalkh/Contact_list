
import 'package:flutter/material.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/constants/constant.dart';

AppBar SubHeaderNav({context,String title}){
  return AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: PRIMARY_COLOR.withOpacity(0.5),

    title: Text(title,
      style: TextStyle(
          fontSize: Constant.fontSize(Constant.L),
          fontWeight: FontWeight.w900,

      ),

    ),

  );
}


