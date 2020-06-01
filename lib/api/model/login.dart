class JsonUser {
  String accessToken,refreshToken,email;

  JsonUser({accessToken, refreshToken,email}) {
    this.accessToken=accessToken;
    this.refreshToken=refreshToken;
    this.email=email;

  }

  factory JsonUser.fromJson(Map<String, dynamic> parsedJson) {
    return JsonUser(
      accessToken: parsedJson['accessToken'],
      refreshToken: parsedJson['refreshToken'],
      email: parsedJson['email'],
    );
  }


}