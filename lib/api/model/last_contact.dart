
class GetLastContact {
  String name,lastContact,id;
  GetLastContact({name,lastContact,id}) {
    this.name=name;
    this.id=id;
    this.lastContact=lastContact;

  }
  factory GetLastContact.fromJson(Map<String, dynamic> parsedJson) {
    return GetLastContact(
      name: parsedJson['name'],
      id:parsedJson["id"],
      lastContact: parsedJson['last_contact'],
    );
  }


}