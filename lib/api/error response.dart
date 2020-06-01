
import 'dart:convert';

errorMethod(response){
  switch (response.statusCode) {
    case 400:
      return json.decode(json.encode(response.body));
      break;
    case 401:
      return json.decode(json.encode(response.body));
      break;
    case 403:
      return json.decode(json.encode(response.body));
      break;
    case 404:
      return json.decode(json.encode(response.body));
      break;
    case 405:
      return json.decode(json.encode(response.body));
      break;
    case 500:
      return json.decode(json.encode(response.body));
      break;
    case 502:
      return "You have a network Problem";
      break;
    default:
      return json.decode(json.encode(response.body));
  }
}

