class GetEmail {
  String id,type,address;

  GetEmail({this.id,this.type,this.address});

  factory GetEmail.fromJson(Map<String, dynamic> parsedJson) {
    return GetEmail(
       id: parsedJson['id'],
       type: parsedJson['type'],
       address: parsedJson['address'],
    );
  }
}