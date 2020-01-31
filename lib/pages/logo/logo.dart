import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/constants/constant.dart';

logo(){
  return Container(
    height: 90,
    alignment: Alignment.center,
    decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
            colors: [PRIMARY_COLOR, SECONDARY_COLOR])),
    child: CircleAvatar(
      radius: 50,
      backgroundImage: CachedNetworkImageProvider(Constant.images[0]),
    ),
  );
}