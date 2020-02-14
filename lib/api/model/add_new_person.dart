
class AddNewPerson {
  String name,id;
  AddNewPerson({name,id}) {
    this.name=name;
    this.id=id;

  }
  factory AddNewPerson.fromJson(Map<String, dynamic> parsedJson) {
    return AddNewPerson(
      name: parsedJson['name'],
      id: parsedJson['id'],
    );
  }


}