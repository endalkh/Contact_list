import 'package:flutter_app/api/model/get_email.dart';
import 'package:flutter_app/api/model/get_phone.dart';

class ContactSync {
  String id,name, birthday;
  List<GetPhone> phone;
  List<GetEmail> email;


  ContactSync({id,name,birthday,List<GetPhone>phone,List<GetEmail> email}) {
    this.id=id;
    this.name=name;
    this.birthday=birthday;

    this.phone=phone;
    this.email=email;





  }

  factory ContactSync.fromJson(Map<String, dynamic> parsedJson) {
    var phoneList=parsedJson['phone_numbers'] as List;
    var emailList=parsedJson['email']  as List;
    return ContactSync(
      id: parsedJson['id'],
      name: parsedJson['name'],
      birthday: parsedJson['birthday'],

      phone:phoneList .map((data) => GetPhone.fromJson(data)).toList(),
      email:emailList.map((data) => GetEmail.fromJson(data)).toList(),
    );
  }


}