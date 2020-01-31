
import 'package:flutter/material.dart';

AppBar headerNav({context,String title}){
  return AppBar(
    title: Text(title),
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


