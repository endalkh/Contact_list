import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/api/auth.dart';
import 'package:flutter_app/api/model/get_notes.dart';
import 'package:flutter_app/pages/dialog/delete_update_dialog.dart';
import 'package:flutter_app/pages/person_header/email_address.dart';
import 'package:flutter_app/pages/person_header/phone_numbers.dart';
import 'package:flutter_app/pages/person_header/update_note.dart';
import 'package:flutter_app/pages/widgets/circularProgressBar.dart';
import 'package:flutter_app/state/app_state.dart';
import 'package:provider/provider.dart';

class ContactInfo extends StatelessWidget{
  String personId;
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
