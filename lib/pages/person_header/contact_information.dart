import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/pages/person_header/email_address.dart';
import 'package:flutter_app/pages/person_header/notes.dart';
import 'package:flutter_app/pages/person_header/phone_numbers.dart';
import 'package:flutter_app/pages/person_header/update_phone.dart';
import 'package:flutter_app/state/app_state.dart';
import 'package:flutter_app/utilities/validation/get_size.dart';
import 'package:provider/provider.dart';

class ContactInfo extends StatelessWidget{
  String personId;
  BuildContext contextClass;

  ContactInfo({@required this.personId});
  @override
  Widget build(BuildContext context) {
    this.contextClass=context;

    return Scaffold(
        body: Provider.of<Auth>(context).getEditPhone()==true?
        UpdatePhone(personId: personId,):

        SingleChildScrollView(
            child: Column(

              children: [
                SizedBox(height: 10,),
                PhoneNumber(personId:personId),

                EmailAddress(personId: personId,),

                Divider(),


                Note(personId: personId,),




              ],
            )
        ),


    );
  }


}
