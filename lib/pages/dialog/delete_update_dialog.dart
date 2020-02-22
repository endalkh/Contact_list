import 'package:flutter/material.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/constants/constant.dart';
import 'package:flutter_app/pages/dialog/confirmationDialog.dart';
import 'package:flutter_app/utilities/abstract_classes/note_del_and_edit.dart';

class DeleteAndEditNotesDialog {
  String id;
  NoteDelAndEdit callback;
  BuildContext contextDialog;
  BuildContext context;
  DeleteAndEditNotesDialog({@required context,@required id,@required callback}){

    this.id=id;
    this.callback=callback;
    this.context=context;
    _alertDialog(context);
  }
  _alertDialog(BuildContext cxt) {
    this.contextDialog=context;
    showDialog(
        context: context,
        builder: (BuildContext cxt) {
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
                                id: id,
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
                          Navigator.of(context).pop();
                          ConfirmationDialog(
                              context: context,
                              title:"Are you sure for this action?",
                              callback: callback,
                              type: Constant.warningIcon,
                            id: id
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


