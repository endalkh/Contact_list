
import 'package:flutter/material.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/constants/constant.dart';

AppBar SubHeaderNav({context,String title}){
  return AppBar(
    // backgroundColor: Colors.grey[400],
        backgroundColor: PRIMARY_COLOR,

   automaticallyImplyLeading: true,

    title: Text(title,
      style: TextStyle(
          fontSize: Constant.fontSize(Constant.L),
          fontWeight: FontWeight.w500,
          color: Colors.white
      ),
    ),
              actions:[
        new IconButton(
          onPressed: () {
//            Search(context);
          },
          tooltip: 'Search',
          icon: new Icon(Icons.search,
                    color: Colors.white,
),
        )
      ],
  );
}


