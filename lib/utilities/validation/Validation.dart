validateEmail(value) {
  if (value.isEmpty||value==null) {
    // The form is empty
    return "E-mail address is required field!";
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
  return 'Please enter valid E-mail address';
}

validateName(String value) {
  if (value.isEmpty||value==null) {
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
  if (value.length < 8) {
    return 'Your password is too weak';
  }

  return '';
}

validateFirstNameForAddPerson(String value) {
  if (value.isEmpty) {
    // The form is empty
    return "first name field is required!";
  }
  // This is just a regular expression for email addresses
  String p = "[a-zA-Z]{3,256}";
  RegExp regExp = new RegExp(p);

  if (regExp.hasMatch(value)) {
    return "";
  }
  return 'Please enter valid name';
}
validateLastNameForAddPerson(String value) {
  if (value.isEmpty) {
    // The form is empty
    return "";
  }
  // This is just a regular expression for email addresses
  String p = "[a-zA-Z]{3,256}";
  RegExp regExp = new RegExp(p);

  if (regExp.hasMatch(value)) {
    return "";
  }
  return 'Please enter valid name';
}

validatePhoneForAddPerson(String value) {

    String patttern = r'(^(?:[+0]9)?[0-9]{10,13}$)';
    RegExp regExp = new RegExp(patttern);
    if (value.isEmpty||value==null) {
      return "";
    }
    if (!regExp.hasMatch(value)) {
      return 'Please enter valid mobile number';
    }

    return '';
}
validatePhone(String value) {
    String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(patttern);
    if(value.isEmpty){
      return "Phone number is required";
    }
    if (regExp.hasMatch(value)) {
      return '';
    }
    return 'Please enter valid mobile number';

}

validateEmailForAddPerson(value) {
  if (value.isEmpty||value==null) {
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
  return 'Please enter valid E-mail address';
}