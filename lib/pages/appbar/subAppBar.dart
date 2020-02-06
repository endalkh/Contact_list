import 'package:flutter/material.dart';
import 'package:flutter_app/constants/constant.dart';

AppBar SubHeaderNav({context,String title}){
  return AppBar(
//    automaticallyImplyLeading: false,

    title: Text(title,
      style: TextStyle(
          fontSize: Constant.fontSize(Constant.L),
          fontWeight: FontWeight.w900,

      ),

    ),

  );
}


