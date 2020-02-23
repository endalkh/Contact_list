import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_app/api/api.dart';
import 'package:flutter_app/api/model/add_new_person.dart';
import 'package:flutter_app/api/model/contact_list.dart';
import 'package:flutter_app/api/model/get_email.dart';
import 'package:flutter_app/api/model/get_notes.dart';
import 'package:flutter_app/api/model/get_phone.dart';
import 'package:flutter_app/api/model/get_single_person.dart';
import 'package:flutter_app/api/model/last_contact.dart';
import 'package:flutter_app/api/model/login.dart';
import 'package:flutter_app/api/model/register.dart';
import 'package:http/http.dart' as http;

/*================== All Get Api ===============================*/
Future<GetAllContact> getSingleContactApi({token, id}) async {
  String error;
  Map<String, String> test = {
    "id": "74b6b078-2df9-4ae2-a90d-e3e808b31fdc",
    "name": "Leah Solo",
    "birthday": "2011-11-11T00:00:00Z"
  };
  try {
    final response = await http.get(
      API.GET_SINGLE_PERSON_API + "?id=" + id,
      headers: {
        "Authorization": token,
      },
    );
    switch (response.statusCode) {
      case 200:
        var responseJson = await json.decode(response.body);
        return GetAllContact.fromJson(test);

      case 201:
        var responseJson = await json.decode(response.body);
        return GetAllContact.fromJson(test);

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
    error = 'No Internet connection 😑';
    throw error;
  } on HttpException {
    error = "Couldn't find the request 😱";
    throw error;
  } on FormatException {
    error = "Bad response format 👎";
    throw error;
  } on Exception {
    error = "We have not idea what happend!";
    throw error;
  }
}

Future<List<GetAllContact>> getAllContactApi({token}) async {
  String error;

  try {
    final response = await http.get(
      API.CONTACT_LIST_API,
      headers: {
        "Authorization": token,
      },
    );
    switch (response.statusCode) {
      case 200:
        var responseJson = await json.decode(response.body) as List;
        return responseJson.map((data) => GetAllContact.fromJson(data)).toList();
      case 201:
        var responseJson = await json.decode(response.body);
        return responseJson.map((data) => GetAllContact.fromJson(data)).toList();

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
    error = 'No Internet connection 😑';
    throw error;
  } on HttpException {
    error = "Couldn't find the request 😱";
    throw error;
  } on FormatException {
    error = "Bad response format 👎";
    throw error;
  } on Exception {
    error = "We have not idea what happend!";
    throw error;
  }
}

Future<List<GetAllContact>> getUpComingBirthdayApi({token}) async {
  String error;

  List<Map<String, String>> test = [

      {
        "id": "9e5d9119-afd9-458e-b840-576f47426777",
        "name": "Luke Skywalker",
        "birthday": "2011-11-11T00:00:00Z"
      },
      {
        "id": "5213202c-9c4b-47d7-93b7-7c500f97fbc6",
        "name": "Luke Skywalker",
        "birthday": "2011-11-11T00:00:00Z"
      },
      {
        "id": "7690e44a-a67a-45d2-9cb2-e25517fc5994",
        "name": "Luke Skywalker",
        "birthday": "2011-11-11T00:00:00Z"
      },
      {
        "id": "8a24b74e-4536-4661-b731-8be95c148c9d",
        "name": "stefan belete",
        "birthday": "2011-11-11T00:00:00Z"
      },
      {
        "id": "92a3ef20-4986-4313-bf13-8ea7e5aed2e5",
        "name": "Luke Skywalker",
        "birthday": "2011-11-11T00:00:00Z"
      },
      {
        "id": "0948c9fb-90a7-473a-ab22-962049a33613",
        "name": "Luke Skywalker",
        "birthday": "2011-11-11T00:00:00Z"
      },
      {
        "id": "d4c6725e-723e-4e50-9be8-e9cbed8198d2",
        "name": "stefan belete",
        "birthday": "2011-11-11T00:00:00Z"
      },
      {
        "id": "e4f18449-e9fa-47d2-884d-3c7abd9bdb41",
        "name": "Luke Skywalker",
        "birthday": "2011-11-11T00:00:00Z"
      },
      {
        "id": "a5d90473-14de-41ce-b020-f1fc8f06953b",
        "name": "stefan belete",
        "birthday": "2020-11-11T00:00:00Z"
      },
      {
        "id": "aed812fa-9479-48bd-b53e-d4f8c3ee0537",
        "name": "endalk dasdasd",
        "birthday": "2020-11-11T00:00:00Z"
      },
      {
        "id": "ca9c5986-b9a2-4977-b48b-7964be1d1bf5",
        "name": "endalk dasdasd",
        "birthday": "2020-11-11T00:00:00Z"
      },
      {
        "id": "07f8ca74-26e1-4716-aaf7-84fa077eea00",
        "name": "endalk dasdasd",
        "birthday": "2020-11-11T00:00:00Z"
      },
      {
        "id": "087fb74c-0d6c-420b-be9a-1030d7f47c0f",
        "name": "endalk dasdasd",
        "birthday": "2020-11-11T00:00:00Z"
      },
      {
        "id": "cedff2ad-c0a6-47ad-bd2c-d570938e76cb",
        "name": "endalk dasdasd",
        "birthday": "2020-02-16T00:00:00Z"
      },
      {
        "id": "a0fe01d6-3df6-4d35-b402-f14f3858d418",
        "name": "elsabet damon",
        "birthday": "1920-02-16T00:00:00Z"
      }

  ];

  try {
    final response = await http.get(
      API.UPCOMING_BIRTHDAY_API,
      headers: {
        "Authorization": token,
      },
    );
    switch (response.statusCode) {
      case 200:
//        var responseJson = await json.decode(response.body)  as List;
        return test.map((data) => GetAllContact.fromJson(data)).toList();
      case 201:
        var responseJson = await json.decode(response.body);
        return responseJson.map((data) => GetAllContact.fromJson(data)).toList();

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
    error = 'No Internet connection 😑';
    throw error;
  } on HttpException {
    error = "Couldn't find the request 😱";
    throw error;
  } on FormatException {
    error = "Bad response format 👎";
    throw error;
  } on Exception {
    error = "We have not idea what happend!";
    throw error;
  }
}

Future<List<GetLastContact>> getLastContactApi({@required token}) async {
  String error;

  List<Map<String, String>> test = [
    {
      "id": "74b6b078-2df9-4ae2-a90d-e3e808b31fdc",
      "name": "Leah Solo",
      "last_contact": "2011-11-11T00:00:00Z"
    },
    {
      "id": "25fcf38c-4084-4544-98ce-d057986fc3ee",
      "name": "endalk",
      "last_contact": "2011-11-11T00:00:00Z"
    },
    {
      "id": "5aefbbc2-18b6-4d45-b4a4-89c5c2dcf39e",
      "name": "Luke Skywalker",
      "last_contact": "2011-11-11T00:00:00Z"
    },
    {
      "id": "4ae8548d-ec2b-432d-88c0-ee5184e96640",
      "name": "samuel kassa",
      "last_contact": "2011-11-11T00:00:00Z"
    },
    {
      "id": "9e5d9119-afd9-458e-b840-576f47426777",
      "name": "stefan james",
      "last_contact": "2011-11-11T00:00:00Z"
    },
    {
      "id": "20975e7b-094f-41ce-b21b-3a82ab9d3e07",
      "name": "mark tomas",
      "last_contact": "2011-11-11T00:00:00Z"
    }
  ];
  try {
    final response = await http.get(
      API.LAST_CONTACT_API,
      headers: {
        "Authorization": token,
      },
    );

    switch (response.statusCode) {
      case 200:
        var responseJson = await json.decode(response.body) as List;
        return test.map((data) => GetLastContact.fromJson(data)).toList();
      case 201:
        var responseJson = await json.decode(response.body) as List;
        return responseJson.map((data) => GetLastContact.fromJson(data)).toList();

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
    error = 'No Internet connection 😑';
    throw error;
  } on HttpException {
    error = "Couldn't find the request 😱";
    throw error;
  } on FormatException {
    error = "Bad response format 👎";
    throw error;
  } on Exception {
    error = "We have not idea what happend!";
    throw error;
  }
}

Future<GetSinglePerson> getSinglePersonApi(
    {@required token, @required id}) async {
  String error;
  Map<String, String> test = {
    "id": "ca9c5986-b9a2-4977-b48b-7964be1d1bf5",
    "name": "endalk dasdasd",
    "birthday": "2020-11-11T00:00:00Z",
    "last_contact": "2020-02-16T10:12:53.105593Z"
  };
  try {
    final response = await http.get(
      API.GET_SINGLE_PERSON_API + "?id=" + id,
      headers: {
        "Authorization": token,
      },
    );

    switch (response.statusCode) {
      case 200:
        var responseJson = await json.decode(response.body);
        return GetSinglePerson.fromJson(responseJson);
      case 201:
        var responseJson = await json.decode(response.body);
        return GetSinglePerson.fromJson(responseJson);

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
    error = 'No Internet connection 😑';
    throw error;
  } on HttpException {
    error = "Couldn't find the request 😱";
    throw error;
  } on FormatException {
    error = "Bad response format 👎";
    throw error;
  } on Exception {
    error = "We have not idea what happend!";
    throw error;
  }
}

Future<List<GetNoteList>> getNoteListApi(
    {@required token,
    @required personId,
    @required after,
    @required limit}) async {
  String error;

  List<Map<String, String>> test = [
    {
      "id": "63376d59-2028-4b0d-94fa-0cc1ef3c6c25",
      "body":
          "I talked to him at the store today and he mentioned that his son Andrew is sick. Should follow up soon.",
      "created_at": "2020-02-12T09:45:43.480263Z",
      "updated_at": "0001-01-01T00:00:00Z"
    },
    {
      "id": "63376d59-2028-4b0d-94fa-0cc1ef3c6c25",
      "body":
          "I talked to him at the store today and he mentioned that his son Andrew is sick. Should follow up soon.",
      "created_at": "2020-02-12T09:45:43.480263Z",
      "updated_at": "0001-01-01T00:00:00Z"
    }
  ];

  try {
    final response = await http.get(
      API.GET_LIST_NOTE_API +
          "?personId=" +
          personId +
          "&after=" +
          after +
          "&limit=$limit",
      headers: {
        "Authorization": token,
      },
    );

    switch (response.statusCode) {
      case 200:
        var responseJson = await json.decode(response.body);

        return test.map((data) => GetNoteList.fromJson(data)).toList();
      case 201:
        var responseJson = await json.decode(response.body);
        return test.map((data) => GetNoteList.fromJson(data)).toList();

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
    error = 'No Internet connection 😑';
    throw error;
  } on HttpException {
    error = "Couldn't find the request 😱";
    throw error;
  } on FormatException {
    error = "Bad response format 👎";
    throw error;
  } on Exception {
    error = "We have not idea what happend!";
    throw error;
  }
}

Future<GetNoteList> getNoteSingleApi({@required token, @required id}) async {
  String error;

  Map<String, String> test = {
    "id": "63376d59-2028-4b0d-94fa-0cc1ef3c6c25",
    "body":
        "I talked to him at the store today and he mentioned that his son Andrew is sick. Should follow up soon.",
  };

  try {
    final response = await http.get(
      API.GET_LIST_NOTE_API + "?personId=" + id,
      headers: {
        "Authorization": token,
      },
    );

    switch (response.statusCode) {
      case 200:
        var responseJson = await json.decode(response.body);

        return GetNoteList.fromJson(test);
      case 201:
        var responseJson = await json.decode(response.body);
        return GetNoteList.fromJson(test);

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
    error = 'No Internet connection 😑';
    throw error;
  } on HttpException {
    error = "Couldn't find the request 😱";
    throw error;
  } on FormatException {
    error = "Bad response format 👎";
    throw error;
  } on Exception {
    error = "We have not idea what happend!";
    throw error;
  }
}

Future<List<GetEmail>> getEmailListApi(
    {@required token, @required personId}) async {
  String error;

  List<Map<String, String>> test = [
    {
      "id": "ed8f6c10-3d51-4258-8778-afdea61ca2e9",
      "type": "Gmail",
      "address": "john@example.com"
    },
    {
      "id": "033b60e3-67fb-484f-99fd-71557d8b566b",
      "type": "Yahoo",
      "address": "johnd@example.com"
    },
    {
      "id": "6e8d298b-5bef-485c-8136-2e6db5f6916b",
      "type": "Iclould",
      "address": "john1@example.com"
    }
  ];

  try {
    final response = await http.get(
      API.GET_EMAIL_API + "?personId=" + personId,
      headers: {
        "Authorization": token,
      },
    );
    print(response.statusCode);
    switch (response.statusCode) {
      case 200:
        var responseJson = await json.decode(response.body);

        return test.map((data) => GetEmail.fromJson(data)).toList();
      case 201:
        var responseJson = await json.decode(response.body);
        return test.map((data) => GetEmail.fromJson(data)).toList();

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
    error = 'No Internet connection 😑';
    throw error;
  } on HttpException {
    error = "Couldn't find the request 😱";
    throw error;
  } on FormatException {
    error = "Bad response format 👎";
    throw error;
  } on Exception {
    error = "We have not idea what happend!";
    throw error;
  }
}

Future<GetEmail> getSingleEmailApi({@required token, @required id}) async {
  String error;
  Map<String, String> test = {
    "id": "ed8f6c10-3d51-4258-8778-afdea61ca2e9",
    "type": "Gmail",
    "address": "john@example.com"
  };

  try {
    final response = await http.get(
      API.ADD_EMAIL_API + "?id=" + id,
      headers: {
        "Authorization": token,
      },
    );
    switch (response.statusCode) {
      case 200:
        var responseJson = await json.decode(response.body);

        return GetEmail.fromJson(test);
      case 201:
        var responseJson = await json.decode(response.body);
        return GetEmail.fromJson(test);

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
    error = 'No Internet connection 😑';
    throw error;
  } on HttpException {
    error = "Couldn't find the request 😱";
    throw error;
  } on FormatException {
    error = "Bad response format 👎";
    throw error;
  } on Exception {
    error = "We have not idea what happend!";
    throw error;
  }
}

Future<List<GetPhone>> getPhoneListApi(
    {@required token, @required personId}) async {
  String error;

  List<Map<String, String>> test = [
    {
      "id": "77f678ad-f481-48e1-8d35-2e88efd4d40a",
      "type": "Mobile",
      "number": "5551234567"
    },
    {
      "id": "77f678ad-f481-48e1-8d35-2e88efd4d40a",
      "type": "Home",
      "number": "5551234567"
    }
  ];

  try {
    final response = await http.get(
      API.GET_PHONE_API + "?personId=" + personId,
      headers: {
        "Authorization": token,
      },
    );
    switch (response.statusCode) {
      case 200:
        var responseJson = await json.decode(response.body);

        return test.map((data) => GetPhone.fromJson(data)).toList();
      case 201:
        var responseJson = await json.decode(response.body);
        return test.map((data) => GetPhone.fromJson(data)).toList();

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
    error = 'No Internet connection 😑';
    throw error;
  } on HttpException {
    error = "Couldn't find the request 😱";
    throw error;
  } on FormatException {
    error = "Bad response format 👎";
    throw error;
  } on Exception {
    error = "We have not idea what happend!";
    throw error;
  }
}

Future<GetPhone> getSinglePhoneApi(
    {@required token, @required personId}) async {
  String error;
  Map<String, String> test = {
    "id": "77f678ad-f481-48e1-8d35-2e88efd4d40a",
    "type": "Mobile",
    "number": "5551234567"
  };
  try {
    final response = await http.get(
      API.GET_PHONE_API + "?personId=" + personId,
      headers: {
        "Authorization": token,
      },
    );
    print(response.statusCode);
    switch (response.statusCode) {
      case 200:
        var responseJson = await json.decode(response.body);

        return GetPhone.fromJson(test);
      case 201:
        var responseJson = await json.decode(response.body);
        return GetPhone.fromJson(test);

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
    error = 'No Internet connection 😑';
    throw error;
  } on HttpException {
    error = "Couldn't find the request 😱";
    throw error;
  } on FormatException {
    error = "Bad response format 👎";
    throw error;
  } on Exception {
    error = "We have not idea what happend!";
    throw error;
  }
}

/*================== Register and Login Api ===============================*/
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
  } on SocketException {
    error = 'No Internet connection 😑';
    throw error;
  } on HttpException {
    error = "Couldn't find the post 😱";
    throw error;
  } on FormatException {
    error = "Bad response format 👎";
    throw error;
  } on Exception {
    error = "We have not idea what happend!";
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
    final response =
        await http.post(API.REGISTER_API, body: json.encode(params));

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
  } on SocketException {
    error = 'No Internet connection 😑';
    throw error;
  } on HttpException {
    error = "Couldn't find the post 😱";
    throw error;
  } on FormatException {
    error = "Bad response format 👎";
    throw error;
  } on Exception {
    error = "We have not idea what happend!";
    throw error;
  }
}

/*================== All Add Api ===============================*/

Future<AddNewPerson> addNewPersonApi(
    {fName,
    lName,
    birthday,
    phoneType,
    phone,
    emailType,
    email,
    notes,
    token}) async {
  var params = {
    "person": {"name": fName + " " + lName, "birthday": birthday},
    "phone_numbers": [
      {"type": phoneType, "number": phone}
    ],
    "emails": [
      {"type": emailType, "address": emailType}
    ],
    "note": {"body": notes}
  };
  String error;

  try {
    final response = await http.post(API.ADD_NEW_PERSON_API,
        headers: {
          "Accept": "application/json; charset=UTF-8",
          "Authorization": token,
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
    error = 'No Internet connection 😑';
    throw error;
  } on HttpException {
    error = "Couldn't find the request 😱";
    throw error;
  } on FormatException {
    error = "Bad response format 👎";
    throw error;
  } on Exception {
    error = "We have not idea what happend!";
    throw error;
  }
}

addPhoneApi(
    {@required token,
    @required personId,
    @required type,
    @required number}) async {
  String error;
  var params = {
    "type": type,
    "number": number,
  };

  try {
    final response = await http.post(
      API.ADD_PHONE_API + "personId=" + personId,
      headers: {
        "Authorization": token,
      },
      body: params,
    );
    switch (response.statusCode) {
      case 200:
        return true;
      case 201:
        return true;

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
    error = 'No Internet connection 😑';
    throw error;
  } on HttpException {
    error = "Couldn't find the request 😱";
    throw error;
  } on FormatException {
    error = "Bad response format 👎";
    throw error;
  } on Exception {
    error = "We have not idea what happend!";
    throw error;
  }
}

addEmailApi(
    {@required token,
    @required personId,
    @required type,
    @required address}) async {
  String error;

  var params = {
    "type": type,
    "address": address,
  };

  try {
    final response = await http.post(
      API.ADD_EMAIL_API + "personId=" + personId,
      headers: {
        "Authorization": token,
      },
      body: params,
    );

    switch (response.statusCode) {
      case 200:
        var responseJson = await json.decode(response.body);

        return true;
      case 201:
        return true;

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
    error = 'No Internet connection 😑';
    throw error;
  } on HttpException {
    error = "Couldn't find the request 😱";
    throw error;
  } on FormatException {
    error = "Bad response format 👎";
    throw error;
  } on Exception {
    error = "We have not idea what happend!";
    throw error;
  }
}

addNoteApi({@required token, @required personId, @required body}) async {
  String error;

  var params = {
    "body": body,
  };

  try {
    final response = await http.post(
      API.ADD_NOTE_API + "personId=" + personId,
      headers: {
        "Authorization": token,
      },
      body: params,
    );
    print(response.statusCode);
    switch (response.statusCode) {
      case 200:
        var responseJson = await json.decode(response.body);

        return true;
      case 201:
        return true;

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
    error = 'No Internet connection 😑';
    throw error;
  } on HttpException {
    error = "Couldn't find the request 😱";
    throw error;
  } on FormatException {
    error = "Bad response format 👎";
    throw error;
  } on Exception {
    error = "We have not idea what happend!";
    throw error;
  }
}



/*================== All Update Api ===============================*/
updatePhoneApi(
    {@required token, @required id, @required type, @required number}) async {
  String error;

  var params = {
    "id": id,
    "type": type,
    "number": number,
  };

  try {
    final response = await http.put(
      API.ADD_PHONE_API,
      headers: {
        "Authorization": token,
      },
      body: params,
    );
    switch (response.statusCode) {
      case 200:
        return true;

      case 201:
        return true;

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
    error = 'No Internet connection 😑';
    throw error;
  } on HttpException {
    error = "Couldn't find the request 😱";
    throw error;
  } on FormatException {
    error = "Bad response format 👎";
    throw error;
  } on Exception {
    error = "We have not idea what happend!";
    throw error;
  }
}

updateEmailApi(
    {@required token, @required id, @required type, @required address}) async {
  String error;

  var params = {
    "id": id,
    "type": type,
    "address": address,
  };

  try {
    final response = await http.put(
      API.ADD_EMAIL_API,
      headers: {
        "Authorization": token,
      },
      body: params,
    );
    switch (response.statusCode) {
      case 200:
        return true;

      case 201:
        return true;

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
    error = 'No Internet connection 😑';
    throw error;
  } on HttpException {
    error = "Couldn't find the request 😱";
    throw error;
  } on FormatException {
    error = "Bad response format 👎";
    throw error;
  } on Exception {
    error = "We have not idea what happend!";
    throw error;
  }
}

updatePersonApi(
    {@required token,
    @required id,
    @required name,
    @required birthDate}) async {
  String error;

  var params = {
    "id": id,
    "name": name,
    "birthday": birthDate,
  };

  try {
    final response = await http.put(
      API.ADD_NEW_PERSON_API,
      headers: {
        "Authorization": token,
      },
      body: params,
    );
    switch (response.statusCode) {
      case 200:
        return true;

      case 201:
        return true;

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
    error = 'No Internet connection 😑';
    throw error;
  } on HttpException {
    error = "Couldn't find the request 😱";
    throw error;
  } on FormatException {
    error = "Bad response format 👎";
    throw error;
  } on Exception {
    error = "We have not idea what happend!";
    throw error;
  }
}

updateNoteApi({@required token, @required id, @required body}) async {
  String error;
  var params = {
    "id": id,
    "body": body,
  };

  try {
    final response = await http.put(
      API.ADD_NOTE_API,
      headers: {
        "Authorization": token,
      },
      body: params,
    );
    print(response.statusCode);
    switch (response.statusCode) {
      case 200:
        var responseJson = await json.decode(response.body);

        return true;
      case 201:
        return true;

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
    error = 'No Internet connection 😑';
    throw error;
  } on HttpException {
    error = "Couldn't find the request 😱";
    throw error;
  } on FormatException {
    error = "Bad response format 👎";
    throw error;
  } on Exception {
    error = "We have not idea what happend!";
    throw error;
  }
}



/*================== All Delete Api ===============================*/
deletePhoneApi(
    {@required token, @required id}) async {
  String error;


  try {
    final response = await http.delete(
      API.DELETE_PHONE_API+"?id="+id,
      headers: {
        "Authorization": token,
      },
    );
    switch (response.statusCode) {
      case 200:
        return true;

      case 201:
        return true;

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
    error = 'No Internet connection 😑';
    throw error;
  } on HttpException {
    error = "Couldn't find the request 😱";
    throw error;
  } on FormatException {
    error = "Bad response format 👎";
    throw error;
  } on Exception {
    error = "We have not idea what happend!";
    throw error;
  }
}

deleteEmailApi(
    {@required token, @required id}) async {
  String error;


  try {
    final response = await http.delete(
      API.DELETE_EMAIL_API,
      headers: {
        "Authorization": token,
      },
    );
    switch (response.statusCode) {
      case 200:
        return true;

      case 201:
        return true;

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
    error = 'No Internet connection 😑';
    throw error;
  } on HttpException {
    error = "Couldn't find the request 😱";
    throw error;
  } on FormatException {
    error = "Bad response format 👎";
    throw error;
  } on Exception {
    error = "We have not idea what happend!";
    throw error;
  }
}

deletePersonApi(
    {@required token,
      @required id}) async {
  String error;
  final response = await http.delete(
    API.DELETE_PERSON_API+"?id="+id,
    headers: {
      "Authorization": token,
    },
  );

  try {

    switch (response.statusCode) {
      case 200:
        return true;

      case 201:
        return true;

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
    error = 'No Internet connection 😑';
    throw error;
  } on HttpException {
    error = "Couldn't find the request 😱";
    throw error;
  } on FormatException {
    error = "Bad response format 👎";
    throw error;
  } on Exception {
    error = "We have not idea what happend!";
    throw error;
  }
}

deleteNoteApi({@required token, @required id}) async {
  String error;


  try {
    final response = await http.delete(
      API.ADD_NOTE_API,
      headers: {
        "Authorization": token,
      },
    );
    print(response.statusCode);
    switch (response.statusCode) {
      case 200:
        var responseJson = await json.decode(response.body);

        return true;
      case 201:
        return true;

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
    error = 'No Internet connection 😑';
    throw error;
  } on HttpException {
    error = "Couldn't find the request 😱";
    throw error;
  } on FormatException {
    error = "Bad response format 👎";
    throw error;
  } on Exception {
    error = "We have not idea what happend!";
    throw error;
  }
}