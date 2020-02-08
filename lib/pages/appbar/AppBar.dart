
import 'package:flutter/material.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/constants/constant.dart';
import 'package:flutter_app/pages/search/search.dart';

AppBar headerNav({context,String title}){
  return AppBar(
    title: Text(title,
      style: TextStyle(
          fontSize: Constant.fontSize(Constant.XL),
          fontWeight: FontWeight.w900
      ),
    ),
    actions: <Widget>[
      new IconButton(
        onPressed: () {
          Search(context);
        },
        tooltip: 'Search',
        icon: new Icon(Icons.search,color: PRIMARY_COLOR,),
      )
    ],
  );
}


