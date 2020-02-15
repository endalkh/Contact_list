
class JsonUserRegister {
  String success;
  JsonUserRegister({success}) {
    this.success=success;

  }
  factory JsonUserRegister.fromJson(Map<String, dynamic> parsedJson) {
    return JsonUserRegister(
      success: parsedJson['success'],
    );
  }


}