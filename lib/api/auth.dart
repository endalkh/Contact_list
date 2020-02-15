import 'dart:convert';
import 'dart:io';

import 'package:flutter_app/api/api.dart';
import 'package:flutter_app/api/model/add_new_person.dart';
import 'package:flutter_app/api/model/login.dart';
import 'package:flutter_app/api/model/register.dart';
import 'package:http/http.dart' as http;

Future<JsonUser> loginApi({userId, password, context}) async {
  var params = {
    "email": userId,
    "password": password,
    "accept_tos": true,
    "accept_privacy": true,
  };
  String error;
  try {
    final response = await http.post(API.LOGIN_API, body: json.encode(params));

    switch (response.statusCode) {
      case 200:
        var responseJson = await json.decode(response.body);
        return JsonUser.fromJson(responseJson);

      case 201:
        var responseJson = await json.decode(response.body);
        return JsonUser.fromJson(responseJson);
      case 400:
        return Future.error("Sorry It was Bad Request! ");
      case 401:
        error = json.decode(response.body)["error"];
        return Future.error(error);
      case 403:
        error = json.decode(response.body)["error"];
        return Future.error(error);
      case 404:
        error = json.decode(response.body)["error"];
        return Future.error(error);
      case 405:
        error = json.decode(response.body)["error"];
        return Future.error(error);
      case 500:
        return Future.error("Ohhh No! There is a problem in our end");
      default:
        {
          error = "An undefined Error happened.";
          return Future.error(error);
        }
    }
  }
  on SocketException {
    error= 'No Internet connection 😑';
    throw error;
  } on HttpException {
    error= "Couldn't find the post 😱";
    throw error;
  }
  on FormatException {
    error= "Bad response format 👎";
    throw error;
  }
  on Exception{
    error= "We have not idea what happend!";
    throw error;
  }
}


Future<JsonUserRegister> registerApi({userId, password, context}) async {
  var params = {
    "email": userId,
    "password": password,
    "accept_tos": true,
    "accept_privacy": true,
  };
  String error;
  try {
    final response = await http.post(
        API.REGISTER_API, body: json.encode(params));

    switch (response.statusCode) {
      case 200:
        var responseJson = await json.decode(response.body);
        return JsonUserRegister.fromJson(responseJson);

      case 201:
        var responseJson = await json.decode(response.body);
        return JsonUserRegister.fromJson(responseJson);
      case 400:
        return Future.error("Sorry It was Bad Request! ");
      case 401:
        error = json.decode(response.body)["error"];
        return Future.error(error);
      case 403:
        error = json.decode(response.body)["error"];
        return Future.error(error);
      case 404:
        error = json.decode(response.body)["error"];
        return Future.error(error);
      case 405:
        error = json.decode(response.body)["error"];
        return Future.error(error);
      case 500:
        return Future.error("Ohhh No! There is a problem in our end");
      default:
        {
          error = "An undefined Error happened.";
          return Future.error(error);
        }
    }
  }
  on SocketException {
    error= 'No Internet connection 😑';
    throw error;
  } on HttpException {
    error= "Couldn't find the post 😱";
    throw error;
  }
  on FormatException {
    error= "Bad response format 👎";
    throw error;
  }
  on Exception{
    error= "We have not idea what happend!";
    throw error;
  }
}


Future<AddNewPerson> addNewPersonApi(
    {fName, lName, birthday, phoneType, phone, emailType, email, notes,token}) async {
//  var params = {
//    "name": "Luke Skywalker",
//    "birthday": "2011-11-11T00:00:00Z",
//    "accept_tos": true,
//    "accept_privacy": true,
//  };
  var params = {
    "person": {
  "name": "Luke Skywalker",
  "birthday": "2011-11-11T00:00:00Z"
  },
  "phone_numbers": [
  {
  "type": "home",
  "number": "5551234567"
  }
  ],
  "emails": [
  {
  "type": "family",
  "address": "luke@rebellion.al"
  }
  ],
  "note": {
  "body": "This is the body of a note"
  }
  };

  String error;
  try {

    final response = await http.post(
        API.ADD_NEW_PERSON_API,
        headers: {
          "Accept": "application/json; charset=UTF-8",
         "Authorization" : token,
         },
        body: json.encode(params));
    switch (response.statusCode) {
      case 200:
        var responseJson = await json.decode(response.body);
        return AddNewPerson.fromJson(responseJson);
      case 201:
        var responseJson = await json.decode(response.body);
        return AddNewPerson.fromJson(responseJson);

      case 400:
        return Future.error("Sorry It was Bad Request! ");
        break;

      case 401:
        {
          error = json.decode(response.body);
          return Future.error(error);
        }
        break;

      case 403:
        error = json.decode(response.body).toString();
        return Future.error(error);
      case 404:
        error = json.decode(response.body)["error"];
        return Future.error(error);
      case 405:
        error = json.decode(response.body)["error"];
        return Future.error(error);
      case 500:
        return Future.error("Ohhh No! There is a problem in our end");
      default:
        {
          error = "An undefined Error happened.";
          return Future.error(error);
        }
    }
} on SocketException {
   error= 'No Internet connection 😑';
   throw error;
  } on HttpException {
    error= "Couldn't find the request 😱";
    throw error;
  }
  on FormatException {
    error= "Bad response format 👎";
    throw error;
  }
  on Exception{
    error= "We have not idea what happend!";
    throw error;
  }
}




