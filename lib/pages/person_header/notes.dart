import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/api/auth.dart';
import 'package:flutter_app/api/model/get_notes.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/constants/constant.dart';
import 'package:flutter_app/pages/dialog/delete_update_dialog.dart';
import 'package:flutter_app/pages/dialog/info_dialog.dart';
import 'package:flutter_app/pages/dialog/loading_dialog.dart';
import 'package:flutter_app/pages/person_header/add_notes.dart';
import 'package:flutter_app/pages/person_header/update_note.dart';
import 'package:flutter_app/pages/widgets/circularProgressBar.dart';
import 'package:flutter_app/state/app_state.dart';
import 'package:flutter_app/utilities/abstract_classes/confirmation_abstract.dart';
import 'package:flutter_app/utilities/abstract_classes/note_del_and_edit.dart';
import 'package:provider/provider.dart';




class Note extends StatelessWidget implements NoteDelAndEdit ,ShouldImp{
  String personId;
  BuildContext contextClass;

  Note({@required this.personId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:

      Column(
          children: <Widget>[

            SizedBox(height: 10,),

            Provider.of<Auth>(context,listen: false).getAddNote()==true?
            Flexible(
              child: AddNote(personId:personId),
            )
                :Column(
              children: <Widget>[
                Text(
                  'Notes',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
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
                                                    DeleteAndEditNotesDialog(context: context,callback:Note(),id: snapshot.data[index].id );

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

              ],
            )

          ]
      ),

      floatingActionButton: FloatingActionButton(
          onPressed: () => {
            Provider.of<Auth>(context,listen: false).setAddNote(!Provider.of<Auth>(context,listen: false).getAddNote())
          },
          backgroundColor: PRIMARY_COLOR,
          child: Icon(

            Provider.of<Auth>(context,listen: false).getAddNote()==false?Icons.add:Icons.list,color: TRIAL_COLOR,
          )
      ),
    );

  }


  @override
  editNote({id, context, contextDialog})async {
    await Provider.of<Auth>(context,listen: false).setEditNote(true);
    Provider.of<Auth>(context,listen: false).setId(id);
    Navigator.pop(context);
    return null;
  }

  @override
  void changer({context, id}) {
    Provider.of<Auth>(context, listen: false).setLoadingStateFun(true);
    var token = Provider.of<Auth>(context, listen: false).getTokenFun();
    var deletePhone = deletePhoneApi(
      id: id,
      token: token,
    );
    LoadingDialog(context: context,title: "please wait.....");

    deletePhone.then((value) async {
      if(value==true) {
        Navigator.of(context).pop();
        Provider.of<Auth>(context, listen: false).setLoadingStateFun(false);
        InfoDialog(
            context: context,
            callback: Note(),
            title: Constant.success,
            type:Constant.success
        );
      }
    });

    deletePhone.catchError((value) async {
      Provider.of<Auth>(context, listen: false).setLoadingStateFun(false);
      Navigator.of(context).pop();

      InfoDialog(
          context: context,
          callback: Note(),
          title: Constant.error,
          type:Constant.error
      );
    });
  }
  }
