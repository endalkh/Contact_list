import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/api/auth.dart';
import 'package:flutter_app/api/model/get_notes.dart';
import 'package:flutter_app/pages/dialog/delete_update_dialog.dart';
import 'package:flutter_app/pages/widgets/circularProgressBar.dart';
import 'package:flutter_app/state/app_state.dart';
import 'package:flutter_app/utilities/abstract_classes/note_del_and_edit.dart';
import 'package:flutter_app/utilities/validation/get_size.dart';
import 'package:provider/provider.dart';

class Notes extends StatelessWidget implements NoteDelAndEdit{
  String personId;
  Notes({@required this.personId});

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        body: FutureBuilder <List<GetNoteList>>(
    future: getNoteListApi(
    token: Provider.of<Auth>(context).getTokenFun(),
    after: "2010-01-16T23:17:50.258328Z",
    limit: 2,
    personId: "63376d59-2028-4b0d-94fa-0cc1ef3c6c25",
    ),
    builder: (context, snapshot) {
    if (snapshot.hasData) {
      return Padding(
        padding: EdgeInsets.all(10),
        child: ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.all(5.0),
                child: Container(
                  height: getHeight(context),
                  child: ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {

                      return Card(
                        margin: EdgeInsets.only(top: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: ListTile(
                                    title:  Text(snapshot.data[index].body),
                                    onLongPress: (){
                                      print("hello");
                                      DeleteAndEditNotesDialog(
                                          context: context,
                                          title: "",
                                          callback: Notes(),

                                      );
                                    },

                                  ),
                                ),

                              ],
                            )
                        ),
                      );


                    },
                  ),
                ),
              );


            }
        ),
      );


      }

    else if (snapshot.hasError) {
      return Center(
        child: Text(snapshot.error.toString(),style: TextStyle(
            fontSize: 20,fontWeight: FontWeight.w900
        ),),
      );
    }
    return circularIndicator(context: context);
    }



            ),


        );

  }

  @override
  deleteNote(id) {
    // TODO: implement deleteNote
    return null;
  }

  @override
  editNote(id) {
    print(id);
    return null;
  }

}