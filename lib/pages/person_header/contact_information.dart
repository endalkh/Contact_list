import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/pages/person_header/email_address.dart';
import 'package:flutter_app/pages/person_header/phone_numbers.dart';

class ContactInfo extends StatelessWidget{
  final String personId;
  BuildContext context;

  ContactInfo({@required this.personId});

  @override
  Widget build(BuildContext context) {


    return Scaffold(
        body: SingleChildScrollView(
            child: Column(

              children: [

                SizedBox(height: 10,),
                PhoneNumber(personId:personId),

                EmailAddress(personId: personId,),

                Divider(),


              ],
            )
        ),


    );
  }




}
