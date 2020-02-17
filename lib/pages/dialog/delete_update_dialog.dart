import 'package:flutter/material.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/utilities/abstract_classes/note_del_and_edit.dart';
import 'package:flutter_app/utilities/validation/get_size.dart';

class DeleteAndEditNotesDialog {
  String title;
  NoteDelAndEdit callback;
  DeleteAndEditNotesDialog({@required context,@required title,@required callback}){
    this.title=title;
    this.callback=callback;
    _alertDialog(context);
  }
  _alertDialog(BuildContext context) {
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
                            callback.editNote("id");
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
                          callback.deleteNote("");
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


