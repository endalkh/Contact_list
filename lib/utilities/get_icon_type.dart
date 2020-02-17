import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

getPhoneNumberTypeIcon(type){
  switch(type){
    case "Home":
      return Icons.home;
      break;
    case 'Mobile':
      return Icons.phone;
    case 'Work':
      return Icons.work;
    case 'Line':
      return Icons.phone;
    default:
      return Icons.mail;

  }
}

getEmailTypeIcon(type){
  switch(type){
    case "Gmail":
      return FontAwesomeIcons.google;
      break;
    case 'Yahoo':
      return FontAwesomeIcons.yahoo;
    case 'Icloud':
      return FontAwesomeIcons.cloud;
    case 'Hotbird':
      return FontAwesomeIcons.mailchimp;
    default:
      return null;

  }
}