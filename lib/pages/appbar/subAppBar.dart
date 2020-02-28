
import 'package:flutter/material.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/constants/constant.dart';

AppBar subHeaderNav({context,String title}){
  return AppBar(


    title: Text(title,
      style: TextStyle(
          fontSize: Constant.fontSize(Constant.L),
          fontWeight: FontWeight.w500,

      ),
    ),
    actions: <Widget>[
        new IconButton(
          onPressed: () {
//            CallbackSearchBarPage();
          },
          tooltip: 'Search',
          icon: new Icon(Icons.search,color: PRIMARY_COLOR,),
        )
      ],
    

  );
}


