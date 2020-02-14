class JsonUser {
  String accessToken,refreshToken;

  JsonUser({accessToken, refreshToken}) {
    this.accessToken=accessToken;
    this.refreshToken=refreshToken;

  }

  factory JsonUser.fromJson(Map<String, dynamic> parsedJson) {
    return JsonUser(
      accessToken: parsedJson['accessToken'],
      refreshToken: parsedJson['refreshToken'],
    );
  }


}