class ContactSync {
  String name,email,phoneType,number;
  ContactSync({name,email,phoneTpe,number}) {
    this.name=name;
    this.email=email;
    this.phoneType=phoneType;
    this.name=number;


  }
  factory ContactSync.fromJson(Map<String, dynamic> parsedJson) {
    return ContactSync(
      name: parsedJson['name'],
      email: parsedJson['email']==null?"":parsedJson['email'],
      phoneTpe: parsedJson['phoneType']==null?"":parsedJson['phoneType'],
      number: parsedJson['number']==null?"":parsedJson['number'],
    );
  }


}