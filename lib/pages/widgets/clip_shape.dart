import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../utilities/validation/get_size.dart';
import 'custom_shape.dart';

clipShape(context) {
  return Stack(
    children: <Widget>[
      Opacity(
        opacity: 0.75,
        child: ClipPath(
          clipper: CustomShapeClipper(),
          child: Container(
            height: getHeight(context)*0.2,
            decoration: BoxDecoration(
              color: PRIMARY_COLOR,

            ),
          ),
        ),
      ),
      Opacity(
        opacity: 0.6,
        child: ClipPath(
          clipper: CustomShapeClipper2(),
          child: Container(
            height: getHeight(context)*0.2,
            decoration: BoxDecoration(
              color: PRIMARY_COLOR.withOpacity(0.5),

            ),
          ),
        ),
      ),

    ],
  );
}
