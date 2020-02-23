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

  noteInContactInfo({personId}){
   return Column(
        children: <Widget>[
          Text(
            'Notes',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 10,),

          Provider.of<Auth>(context).getEditNote()==true?UpdateNote(id:Provider.of<Auth>(context).getId()):FutureBuilder <List<GetNoteList>>(
              future: getNoteListApi(
                token: Provider.of<Auth>(context).getTokenFun(),
                after: "2010-01-16T23:17:50.258328Z",
                limit: 2,
                personId: "63376d59-2028-4b0d-94fa-0cc1ef3c6c25",
              ),
              builder: (context, snapshot) {
                if (snapshot.hasData) {

                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return SingleChildScrollView(
                            child: Container(
                              margin: EdgeInsets.only(left: 10,right: 10),
                              child:  Container(
                                margin: EdgeInsets.only(
                                    left: 10, right: 10, bottom: 10),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Container(
                                    margin: EdgeInsets.zero,
                                    child: Column(
                                        children: [
                                          ListTile(
                                            title: Text(snapshot.data[index].body,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 17),
                                            ),
                                            onLongPress:(){
                                              DeleteAndEditNotesDialog(context: context,callback:ContactInfo(),id: snapshot.data[index].id );

                                            },
                                          ),
                                        ]
                                    ),
                                  ),
                                ),
                              ),
                            )
                        );



                      }
                  );
                }
                else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      snapshot.error.toString(), style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w900
                    ),),
                  );
                }
                return circularIndicator(context: context);
              }
          ),

        ]
    );

  }
  @override
  Widget build(BuildContext context) {
    this.context=context;


    return Scaffold(
        body: SingleChildScrollView(
            child: Column(

              children: [

                SizedBox(height: 10,),
                PhoneNumber(personId:personId),

                EmailAddress(personId: personId,),

                Divider(),

                noteInContactInfo(personId: personId,) ,




              ],
            )
        ),


    );
  }




}
