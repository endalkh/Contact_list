import 'package:flutter_app/api/api.dart';
import 'package:http/http.dart' as http;

Future<String> loginApi({userId,password, context}) async {
  String errorMessage;
  try {
    final response = await http.get(API());
  }
  catch (error) {
    errorMessage=response(error);
    if (errorMessage != null) {
      return Future.error(errorMessage);
    }
  }
//
//  savePref(
//      id: result.user.uid,
//      name: result.user.displayName,
//      email: result.user.email,
//      photo: result.user.photoUrl
//
//  );
}

response(response){
  String errorMessage;
  switch (response.code) {
    case 400:
      errorMessage = "Bad request Exception";
      break;
    case 401:
      errorMessage = "You are unautherized";
      break;
    case 403:
      errorMessage = "Forbidden";
      break;
    case 404:
      errorMessage = "Request not Found";
      break;
    case 405:
      errorMessage = "Method not allowed";
      break;

    default:
      errorMessage = "An undefined Error happened.";
  }
  if (errorMessage != null) {
    return Future.error(errorMessage);
  }
}