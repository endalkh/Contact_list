
import 'package:flutter/material.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/constants/constant.dart';
import 'package:flutter_app/pages/search/search.dart';

AppBar headerNav({context,String title}){
  return AppBar(
    iconTheme: new IconThemeData(color: TRIAL_COLOR),
    title: Text(title,
      style: TextStyle(
        fontSize: Constant.fontSize(10),
        fontWeight: FontWeight.w500,
        color: Colors.white

      ),
    ),
          actions: <Widget>[
        new IconButton(
          onPressed: () {
         Search(context);
          },
          tooltip: 'Search',
          icon: new Icon(Icons.search,
          color: TRIAL_COLOR),
        )
      ],

   
  );
}


