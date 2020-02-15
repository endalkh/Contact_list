import 'package:flutter/material.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/pages/widgets/custom_shape.dart';

clipShape({ height,width}) {
  return Stack(
    children: <Widget>[
      Opacity(
        opacity: 0.5,
        child: ClipPath(
          clipper: CustomShapeClipper(),
          child: Container(
            height:170,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [PRIMARY_COLOR, SECONDARY_COLOR]
              ),
            ),
          ),
        ),
      ),
      Opacity(
        opacity: 0.5,
        child: ClipPath(
          clipper: CustomShapeClipper2(),
          child: Container(
            height: 120,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [PRIMARY_COLOR, SECONDARY_COLOR]
              ),
            ),
          ),
        ),
      ),
      Container(
        alignment: Alignment.bottomCenter,
        margin: EdgeInsets.only(top: 10),
        child: Image.asset(
          'assets/images/login.png',
          height: height/3.5,
          width: width/3.5,
        ),
      ),
    ],
  );
}