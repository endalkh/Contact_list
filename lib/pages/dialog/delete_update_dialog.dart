import 'package:flutter/material.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/utilities/abstract_classes/note_del_and_edit.dart';

class DeleteAndEditNotesDialog {
  String personId;
  NoteDelAndEdit callback;
  BuildContext contextDialog;
  BuildContext context;
  DeleteAndEditNotesDialog({@required context,@required personId,@required callback}){

    this.personId=personId;
    this.callback=callback;
    this.context=context;
    _alertDialog(context);
  }
  _alertDialog(BuildContext context) {
    this.contextDialog=context;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: Dialog(
              elevation: 0,
              child: Container(
                padding: EdgeInsets.only(right: 16.0),
                height: 140,

                child:Column(
                  children: <Widget>[
                    SizedBox(height: 10,),

                    Container(
                      width: 180,
                      child:   RaisedButton(
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Icon(Icons.edit,color: PRIMARY_COLOR,),
                          ),
                          title:  Text("Edit"),
                        ),
                        color: Colors.blue,
                        colorBrightness: Brightness.dark,
                        onPressed: (){
                            callback.editNote(
                                personId: personId,
                                context:this.context,
                              contextDialog: contextDialog

                            );
                        },
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                      ) ,
                    ),
                    SizedBox(height: 10,),

                    Container(
                      width: 180,
                      child:   RaisedButton(
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Icon(Icons.delete_forever,color: PRIMARY_COLOR),
                          ),
                          title:  Text("Delete"),
                        ),
                        color: Colors.red,
                        colorBrightness: Brightness.dark,
                        onPressed: (){

                          callback.deleteNote(
                            contextDialog: contextDialog,
                            context:this.context,
                            personId: personId
                          );
                        },
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                      ) ,
                    ),





                  ],
                )

              ),
            ),
          );
        }
    );
  }
}


