class GetPhone {
  String id,type,number;
  GetPhone({this.id,this.type,this.number});

  factory GetPhone.fromJson(Map<String, dynamic> parsedJson) {
    return GetPhone(
      id: parsedJson['id'],
      type:parsedJson['type'],
      number:parsedJson['number'],
    );
  }


}