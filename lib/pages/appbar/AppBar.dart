
import 'package:flutter/material.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/constants/constant.dart';

AppBar headerNav({context,String title}){
  return AppBar(
    backgroundColor: PRIMARY_COLOR,
    title: Text(title,
      style: TextStyle(
        fontSize: Constant.fontSize(Constant.XL),
        fontWeight: FontWeight.w900
      ),
    ),
          actions: <Widget>[
        new IconButton(
          onPressed: () {
//            Search(context);
          },
          tooltip: 'Search',
          icon: new Icon(Icons.search),
        )
      ],
  );
}


