import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/api/auth.dart';
import 'package:flutter_app/api/model/get_notes.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/pages/dialog/delete_update_dialog.dart';
import 'package:flutter_app/pages/person_header/add_notes.dart';
import 'package:flutter_app/pages/widgets/circularProgressBar.dart';
import 'package:flutter_app/state/app_state.dart';
import 'package:flutter_app/utilities/abstract_classes/note_del_and_edit.dart';
import 'package:flutter_app/utilities/get_icon_type.dart';
import 'package:flutter_app/utilities/validation/get_size.dart';
import 'package:provider/provider.dart';

//class Notes extends StatelessWidget implements NoteDelAndEdit{
//  String personId;
//  Notes({@required this.personId});
//
//  @override
//  Widget build(BuildContext context) {
//      return Column(
//        children: <Widget>[
////           floatingActionButton: FloatingActionButton(
////          onPressed: () => {
////            Provider.of<Auth>(context,listen: false).setAddNote(!Provider.of<Auth>(context,listen: false).getAddNote())
////          },
////          backgroundColor: PRIMARY_COLOR,
////          child: Icon(
////            Provider.of<Auth>(context,listen: false).getAddNote()==true? Icons.note_add:Icons.event_note,
////            color: lightBG,
////          ),
////        ),
////
////
////        );
//
//          Text(
//            'Notes',
//            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
//          ),
//
//          Provider.of<Auth>(context).getAddNote()==false?AddNote(personId: personId,):
//
//          FutureBuilder <List<GetNoteList>>(
//              future: getNoteListApi(
//                token: Provider.of<Auth>(context).getTokenFun(),
//                after: "2010-01-16T23:17:50.258328Z",
//                limit: 2,
//                personId: "63376d59-2028-4b0d-94fa-0cc1ef3c6c25",
//              ),
//              builder: (context, snapshot) {
//                if (snapshot.hasData) {
////                  return Column(
////                    children: <Widget>[
////
////                      Padding(
////                        padding: EdgeInsets.all(5.0),
////                        child: Container(
////                          height: getHeight(context),
////                          child: ListView.builder(
////                            shrinkWrap: true,
////                            itemCount: snapshot.data.length,
////                            itemBuilder: (context, index) {
////                              return Card(
////                                margin: EdgeInsets.only(top: 12),
////                                shape: RoundedRectangleBorder(
////                                  borderRadius: BorderRadius.circular(20.0),
////                                ),
////                                child: Padding(
////                                    padding: const EdgeInsets.all(6.0),
////                                    child: Row(
////                                      children: [
////                                        Expanded(
////                                          flex: 1,
////                                          child: ListTile(
////                                            title: Text(snapshot.data[index].body),
////                                            onLongPress: () {
////                                              DeleteAndEditNotesDialog(
////                                                context: context,
////                                                personId: personId,
////                                                callback: Notes(),
////
////                                              );
////                                            },
////
////                                          ),
////                                        ),
////
////                                      ],
////                                    )
////                                ),
////                              );
////                            },
////                          ),
////                        ),
////                      ),
////                    ],
////                  );
////                }
//                  return ListView.builder(
//                      shrinkWrap: true,
//                      itemCount: snapshot.data.length,
//                      itemBuilder: (context, index) {
//                        return SingleChildScrollView(
//                            child: Container(
//                              margin: EdgeInsets.only(left: 10, right: 10),
//                              child: Container(
//                                margin: EdgeInsets.only(
//                                    left: 10, right: 10, bottom: 10),
//                                child: Card(
//                                  shape: RoundedRectangleBorder(
//                                    borderRadius: BorderRadius.circular(20.0),
//                                  ),
//                                  child: Container(
//                                    margin: EdgeInsets.zero,
//                                    child: Column(
//                                        children: [
//                                          ListTile(
//                                            leading:
//                                            Icon(getPhoneNumberTypeIcon(
//                                                snapshot.data[index].id),
//                                              size: 30,
//                                              color: PRIMARY_COLOR,),
//                                            title: Text(
//                                              snapshot.data[index].body,
//                                              style: TextStyle(
//                                                  fontWeight: FontWeight.w400,
//                                                  fontSize: 17),
//                                            ),
//                                          ),
//                                        ]
//                                    ),
//                                  ),
//                                ),
//                              ),
//                            )
//                        );
//                      }
//                  );
//                }
//
//
//                else if (snapshot.hasError) {
//                  return Center(
//                    child: Text(snapshot.error.toString(),style: TextStyle(
//                        fontSize: 20,fontWeight: FontWeight.w900
//                    ),),
//                  );
//                }
//                return circularIndicator(context: context);
//              }
//
//
//
//          ),
//
//        ],
//      );
//
//
//  }
//
//  @override
//  deleteNote({personId,context,contextDialog}) {
//    // TODO: implement deleteNote
//    return null;
//  }
//
//  @override
//  editNote({personId,context,contextDialog}) {
//    return null;
//  }
//
//}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/api/auth.dart';
import 'package:flutter_app/api/model/get_email.dart';
import 'package:flutter_app/api/model/get_phone.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/pages/dialog/delete_update_dialog.dart';
import 'package:flutter_app/pages/person_header/add_email.dart';
import 'package:flutter_app/pages/person_header/add_phone.dart';
import 'package:flutter_app/pages/widgets/circularProgressBar.dart';
import 'package:flutter_app/state/app_state.dart';
import 'package:flutter_app/utilities/abstract_classes/note_del_and_edit.dart';
import 'package:flutter_app/utilities/get_icon_type.dart';
import 'package:provider/provider.dart';

class Note extends StatelessWidget implements NoteDelAndEdit {
  String personId;
  BuildContext contextClass;

  Note({@required this.personId});

  @override
  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[
          Text(
            'Notes',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 10,),

          FutureBuilder <List<GetNoteList>>(
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
  deleteNote({id, context, contextDialog}) {
    // TODO: implement deleteNote
    return null;
  }

  @override
  editNote({id, context, contextDialog}) {
    // TODO: implement editNote
    return null;
  }
}