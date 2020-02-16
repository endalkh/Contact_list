
class GetAllContact {
  String name,birthDate,id;
  GetAllContact({name,birthDate,id}) {
    this.name=name;
    this.id=id;
    this.birthDate=birthDate;

  }
  factory GetAllContact.fromJson(Map<String, dynamic> parsedJson) {
    return GetAllContact(
      name: parsedJson['name'],
      id:parsedJson["id"],
      birthDate: parsedJson['birthday'],
    );
  }


}