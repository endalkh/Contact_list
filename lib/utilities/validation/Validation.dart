validateEmail(value) {
  if (value.isEmpty) {
    // The form is empty
    return "Enter email address";
  }
  // This is just a regular expression for email addresses
  String p = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
      "\\@" +
      "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
      "(" +
      "\\." +
      "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
      ")+";
  RegExp regExp = new RegExp(p);

  if (regExp.hasMatch(value)) {
    // So, the email is valid
    return "";
  }
  // The pattern of the email didn't match the regex above.
  return 'Email is not valid';
}

validateName(String value) {
  if (value.isEmpty) {
    // The form is empty
    return "The name field is required! ";
  }
  // This is just a regular expression for email addresses
  String p = "[a-zA-Z]{1,256}";
  RegExp regExp = new RegExp(p);

  if (regExp.hasMatch(value)) {
    return "";
  }
  return 'Name is not valid';
}

validatePassword(String value) {
  if (value.isEmpty) {
    return "Enter Password field";
  }
  if (value.length < 6) {
    return 'Your password is too weak';
  }

  return '';
}

validateNameForAddPerson(String value) {
  if (value.isEmpty) {
    // The form is empty
    return "";
  }
  // This is just a regular expression for email addresses
  String p = "[a-zA-Z]{1,256}";
  RegExp regExp = new RegExp(p);

  if (regExp.hasMatch(value)) {
    return "";
  }
  return 'Name is not valid';
}

validatePhoneForAddPerson(String value) {
  if (value.isEmpty) {
    // The form is empty
    return "";
  }
  // This is just a regular expression for email addresses
  String p = "[a-zA-Z]{1,256}";
  RegExp regExp = new RegExp(p);

  if (regExp.hasMatch(value)) {
    return "";
  }
  return 'Name is not valid';
}

validateEmailForAddPerson(value) {
  if (value.isEmpty) {
    // The form is empty
    return "";
  }
  // This is just a regular expression for email addresses
  String p = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
      "\\@" +
      "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
      "(" +
      "\\." +
      "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
      ")+";
  RegExp regExp = new RegExp(p);

  if (regExp.hasMatch(value)) {
    // So, the email is valid
    return "";
  }
  // The pattern of the email didn't match the regex above.
  return 'Email is not valid';
}