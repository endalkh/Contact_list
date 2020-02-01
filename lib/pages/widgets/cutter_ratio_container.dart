import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/pages/widgets/custom_cliper.dart';


class CutterRatioContainer extends StatelessWidget {
  const CutterRatioContainer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Transform.rotate(
          angle: -pi / 3.5,
          child: ClipPath(
            clipper: ClipPainter(),
            child: Container(
              height: MediaQuery.of(context).size.height *.5,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(

              ),
            ),
          ),
        )
    );
  }
}