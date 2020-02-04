
import 'package:flutter/material.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/pages/appbar/AppBar.dart';
class SearchDisplayScreen extends StatefulWidget{
  _SearchDisplayScreen createState()=>_SearchDisplayScreen();
}
class _SearchDisplayScreen extends State<SearchDisplayScreen> {
  bool isThemeOn=false;
  final TextStyle headerStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 20.0,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: headerNav(title: "Search Result", context: context),
      body: Center(
        child: Text("Search display",style: TextStyle(fontWeight: FontWeight.w900),),
      ),
    );
  }
}