import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_app/api/api.dart';
import 'package:flutter_app/api/error%20response.dart';
import 'package:flutter_app/api/model/add_new_person.dart';
import 'package:flutter_app/api/model/contact_list.dart';
import 'package:flutter_app/api/model/get_email.dart';
import 'package:flutter_app/api/model/get_notes.dart';
import 'package:flutter_app/api/model/get_phone.dart';
import 'package:flutter_app/api/model/get_single_person.dart';
import 'package:flutter_app/api/model/last_contact.dart';
import 'package:flutter_app/api/model/login.dart';
import 'package:http/http.dart' as http;

/*================== All Get Api ===============================*/
Future<GetAllContact> getSingleContactApi({token, id}) async {
  String error;

  try {
    final response = await http.get(
      API.GET_SINGLE_PERSON_API + "?id=" + id,
      headers: {
        "Authorization": token,
      },
    );
    switch (response.statusCode) {
      case 200:
        {
          var responseJson = await json.decode(response.body);
          return GetAllContact.fromJson(responseJson);
        }
        break;

      case 201:
        {
          var responseJson = await json.decode(response.body);
          return GetAllContact.fromJson(responseJson);
        }

      default:
        return Future.error(errorMethod(response));
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

Future<List<GetAllContact>> searchApi({token, query, context}) async {
  String error;

  try {
    final response = await http.get(
      "https://relateapp.io/api/v1/search" + "?query=" + query,
      headers: {
        "Authorization": token,
      },
    );
    switch (response.statusCode) {
      case 200:
        var responseJson = await json.decode(response.body)["persons"] as List;
        return responseJson
            .map((data) => GetAllContact.fromJson(data))
            .toList();
        break;
      case 201:
        {
          var responseJson =
              await json.decode(response.body)["persons"] as List;
          return responseJson
              .map((data) => GetAllContact.fromJson(data))
              .toList();
        }
        break;

      default:
        return Future.error(errorMethod(response));
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
        {
          var responseJson = await json.decode(response.body) as List;
          return responseJson
              .map((data) => GetAllContact.fromJson(data))
              .toList();
        }
        break;
      case 201:
        {
          var responseJson = await json.decode(response.body);
          return responseJson
              .map((data) => GetAllContact.fromJson(data))
              .toList();
        }
        break;
      default:
        return Future.error(errorMethod(response));
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
  try {
    final response = await http.get(
      API.UPCOMING_BIRTHDAY_API,
      headers: {
        "Authorization": token,
      },
    );
    switch (response.statusCode) {
      case 200:
        {
          var responseJson = await json.decode(response.body) as List;
          return responseJson
              .map((data) => GetAllContact.fromJson(data))
              .toList();
        }
        break;
      case 201:
        {
          var responseJson = await json.decode(response.body) as List;
          return responseJson
              .map((data) => GetAllContact.fromJson(data))
              .toList();
        }
        break;
      default:
        return Future.error(errorMethod(response));
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

  try {
    final response = await http.get(
      API.LAST_CONTACT_API,
      headers: {
        "Authorization": token,
      },
    );

    switch (response.statusCode) {
      case 200:
        {
          var responseJson = await json.decode(response.body) as List;
          return responseJson
              .map((data) => GetLastContact.fromJson(data))
              .toList();
        }
        break;

      case 201:
        {
          var responseJson = await json.decode(response.body) as List;
          return responseJson
              .map((data) => GetLastContact.fromJson(data))
              .toList();
        }
        break;

      default:
        return Future.error(errorMethod(response));
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
  try {
    final response = await http.get(
      API.GET_SINGLE_PERSON_API + "?id=" + id,
      headers: {
        "Authorization": token,
      },
    );

    switch (response.statusCode) {
      case 200:
        {
          var responseJson = await json.decode(response.body);
          return GetSinglePerson.fromJson(responseJson);
        }
        break;

      case 201:
        {
          var responseJson = await json.decode(response.body);
          return GetSinglePerson.fromJson(responseJson);
        }

      default:
        return Future.error(errorMethod(response));
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

Future<List<GetNoteList>> getNoteListApi({
  @required token,
  @required personId,
}) async {
  String error;

  try {
    final response = await http.get(
      API.GET_LIST_NOTE_API + "?personId=" + personId,
      headers: {
        "Authorization": token,
      },
    );

    switch (response.statusCode) {
      case 200:
        var responseJson = await json.decode(response.body) as List;

        return responseJson.map((data) => GetNoteList.fromJson(data)).toList();
      case 201:
        var responseJson = await json.decode(response.body) as List;
        return responseJson.map((data) => GetNoteList.fromJson(data)).toList();

      default:
        return Future.error(errorMethod(response));
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

  try {
    final response = await http.get(
      API.GET_SINGLE_NOTE_API + "?id=" + id,
      headers: {
        "Authorization": token,
      },
    );

    switch (response.statusCode) {
      case 200:
        {
          var responseJson = await json.decode(response.body);

          return GetNoteList.fromJson(responseJson);
        }
        break;
      case 201:
        {
          var responseJson = await json.decode(response.body);
          return GetNoteList.fromJson(responseJson);
        }
        break;

      default:
        return Future.error(errorMethod(response));
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

  try {
    final response = await http.get(
      API.GET_EMAIL_API + "?personId=" + personId,
      headers: {
        "Authorization": token,
      },
    );
    switch (response.statusCode) {
      case 200:
        {
          var responseJson = await json.decode(response.body) as List;
          return responseJson.map((data) => GetEmail.fromJson(data)).toList();
        }
        break;
      case 201:
        {
          var responseJson = await json.decode(response.body) as List;
          return responseJson.map((data) => GetEmail.fromJson(data)).toList();
        }
        break;

      default:
        return Future.error(errorMethod(response));
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

  try {
    final response = await http.get(
      API.ADD_EMAIL_API + "?id=" + id,
      headers: {
        "Authorization": token,
      },
    );
    switch (response.statusCode) {
      case 200:
        {
          var responseJson = await json.decode(response.body);
          return GetEmail.fromJson(responseJson);
        }
        break;
      case 201:
        {
          var responseJson = await json.decode(response.body);
          return GetEmail.fromJson(responseJson);
        }
        break;

      default:
        return Future.error(errorMethod(response));
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

  try {
    final response = await http.get(
      API.GET_PHONE_API + "?personId=" + personId,
      headers: {
        "Authorization": token,
      },
    );
    switch (response.statusCode) {
      case 200:
        {
          var responseJson = await json.decode(response.body) as List;
          return responseJson.map((data) => GetPhone.fromJson(data)).toList();
        }
        break;
      case 201:
        {
          var responseJson = await json.decode(response.body) as List;
          return responseJson.map((data) => GetPhone.fromJson(data)).toList();
        }
        break;

      default:
        return Future.error(errorMethod(response));
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
  try {
    final response = await http.get(
      API.GET_SINGLE_API + "?id=" + personId,
      headers: {
        "Authorization": token,
      },
    );
    switch (response.statusCode) {
      case 200:
        {
          var responseJson = await json.decode(response.body);
          return GetPhone.fromJson(responseJson);
        }
        break;
      case 201:
        {
          var responseJson = await json.decode(response.body);
          return GetPhone.fromJson(responseJson);
        }
        break;

      default:
        return Future.error(errorMethod(response));
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
    final response = await http.post(API.LOGIN_API,
        body: json.encode(params));

    switch (response.statusCode) {
      case 200:
        return JsonUser.fromJson(json.decode(response.body));
        break;
      case 201:
        return JsonUser.fromJson(json.decode(response.body));
        break;

      default:
        return Future.error(errorMethod(response));
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

registerApi({userId, password, context}) async {
  var params = {
    "email": userId,
    "password": password,
    "accept_tos": true,
    "accept_privacy": true,
  };
  String error;
  try {
    final response = await http.post(API.REGISTER_API,
        headers: {
          "Content-Type": "application/json",
        },
        body: json.encode(params));
    switch (response.statusCode) {
      case 200:
        return true;
        break;
      case 201:
        return true;
        break;
      default:
        return Future.error(errorMethod(response));
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
      {"type": emailType, "address": email}
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
        {
          var responseJson = await json.decode(response.body)["person"];
          return AddNewPerson.fromJson(responseJson);
        }
        break;
      case 201:
        {
          var responseJson = await json.decode(response.body);
          return AddNewPerson.fromJson(responseJson);
        }
        break;

      default:
        return Future.error(errorMethod(response));
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
      API.ADD_PHONE_API + "?personId=" + personId,
      headers: {
        "Authorization": token,
      },
      body: json.encode(params),
    );
    switch (response.statusCode) {
      case 200:
        return true;
      case 201:
        return true;
      default:
        return Future.error(errorMethod(response));
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

  Map<String, String> params = {"type": type, "address": address};

  try {
    final response =
        await http.post(API.ADD_EMAIL_API + "?personId=" + personId,
            headers: {
              "Authorization": token,
            },
            body: json.encode(params));

    switch (response.statusCode) {
      case 200:
        return true;
      case 201:
        return true;

      default:
        return Future.error(errorMethod(response));
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
      API.ADD_NOTE_API + "?personId=" + personId,
      headers: {
        "Authorization": token,
      },
      body: json.encode(params),
    );
    switch (response.statusCode) {
      case 200:
        return true;
      case 201:
        return true;

      default:
        return Future.error(errorMethod(response));
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
      body: json.encode(params),
    );
    switch (response.statusCode) {
      case 200:
        return true;

      case 201:
        return true;

      default:
        return Future.error(errorMethod(response));
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
      body: json.encode(params),
    );
    switch (response.statusCode) {
      case 200:
        return true;

      case 201:
        return true;
      default:
        return Future.error(errorMethod(response));
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
      body: json.encode(params),
    );
    switch (response.statusCode) {
      case 200:
        return true;

      case 201:
        return true;

      default:
        return Future.error(errorMethod(response));
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
      body: json.encode(params),
    );
    switch (response.statusCode) {
      case 200:
        return true;
      case 201:
        return true;

      default:
        return Future.error(errorMethod(response));
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
deletePhoneApi({@required token, @required id}) async {
  String error;

  try {
    final response = await http.delete(
      API.DELETE_PHONE_API + "?id=" + id,
      headers: {
        "Authorization": token,
      },
    );
    switch (response.statusCode) {
      case 200:
        return true;

      case 201:
        return true;

      default:
        return errorMethod(response);
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

deleteEmailApi({@required token, @required id}) async {
  String error;

  try {
    final response = await http.delete(
      API.DELETE_EMAIL_API + "?id=" + id,
      headers: {
        "Authorization": token,
      },
    );
    switch (response.statusCode) {
      case 200:
        return true;

      case 201:
        return true;

      default:
        return Future.error(errorMethod(response));
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

deletePersonApi({@required token, @required id}) async {
  String error;
  final response = await http.delete(
    API.DELETE_PERSON_API + "?id=" + id,
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

      default:
        return Future.error(errorMethod(response));
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
      API.ADD_NOTE_API + "?id=" + id,
      headers: {
        "Authorization": token,
      },
    );
    switch (response.statusCode) {
      case 200:
        return true;
      case 201:
        return true;

      default:
        return Future.error(errorMethod(response));
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

resetPasswordApi({@required email}) async {
  String error;
  try {
    final response = await http.post(
      API.RESET_PASSWORD_API + "email=" + email,
    );
    switch (response.statusCode) {
      case 200:
        return true;
      case 201:
        return true;

      default:
        return Future.error(errorMethod(response));
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
