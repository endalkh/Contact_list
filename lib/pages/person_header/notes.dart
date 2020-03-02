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

class Note extends StatefulWidget {
  final String personId;

  Note({@required this.personId});

  _Note createState() => _Note(
        personId: personId,
      );
}

class _Note extends State<Note> implements NoteDelAndEdit, ShouldImp {
  String personId;
  bool readMore = false;
  bool _isExpanded = false;
  String listId="" ;

  _Note({@required this.personId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Provider.of<Auth>(context).getAddNote() == true
          ? Container(
              child: AddNote(personId: personId),
            )
          : Provider.of<Auth>(context).getEditNote() == true
              ? UpdateNote(id: Provider.of<Auth>(context).getId())
              : Column(
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Notes',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: FutureBuilder<List<GetNoteList>>(
                          future: getNoteListApi(
                            token: Provider.of<Auth>(context).getTokenFun(),
                            personId: personId,
                          ),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: EdgeInsets.only(left: 10,right: 10),
                                      child:Container(
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        child: Container(
                                          child: snapshot.data[index].body
                                                      .isEmpty ==
                                                  true
                                              ? Container()
                                              : Column(children: [
                                                  ListTile(
                                                    onLongPress: () {
                                                      DeleteAndEditNotesDialog(
                                                          context: context,
                                                          callback: _Note(
                                                            personId: personId,
                                                          ),
                                                          id: snapshot
                                                              .data[index].id);
                                                    },
                                                    title: LayoutBuilder(
                                                        builder:
                                                            (context, size) {

                                                      final span = TextSpan(
                                                          text: snapshot
                                                              .data[index].body
                                                              .toString());

                                                      final tp = TextPainter(
                                                          text: span,
                                                          textDirection:
                                                              TextDirection.ltr,
                                                          maxLines: 1);
                                                      tp.layout(
                                                          maxWidth:
                                                              size.maxWidth);

                                                      if (tp.didExceedMaxLines) {
                                                        return Column(
                                                          children: <Widget>[
                                                              Row(
                                                                children: <Widget>[

                                                                  Expanded(
                                                                    flex:9,
                                                                    child: Text(
                                                                      snapshot
                                                                          .data[index]
                                                                          .body,
                                                                      maxLines: _isExpanded && listId==snapshot.data[index].id ? null : 1,
                                                                    ),
                                                                  ),
                                                            Expanded(
                                                              flex:1,
                                                              child:       Material(
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                      BorderRadius.circular(
                                                                          20)),
                                                                  elevation: 0.5,
                                                                  child: InkWell(
                                                                    onTap:() {
                                                                      _handleOnTap(snapshot.data[index].id);
                                                                    },
                                                                    child: Icon(
                                                                      _isExpanded && listId==snapshot.data[index].id
                                                                          ? Icons.expand_less
                                                                          : Icons.expand_more,
                                                                      color: Colors.blue,
                                                                    ),
                                                                  )),
                                                            )
                                                                ],
                                                              ),



                                                          ],
                                                        );
                                                      } else {
                                                        return Text(snapshot
                                                            .data[index].body);
                                                      }
                                                    }),
                                                  ),
                                                ]),
                                        ),
                                      ),
                                    ));
                                  });
                            } else if (snapshot.hasError) {
                              return Center(
                                child: Text(
                                  snapshot.error.toString(),
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w900),
                                ),
                              );
                            }
                            return circularIndicator(context: context);
                          }),
                    ),
                  ],
                ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => {
                Provider.of<Auth>(context, listen: false).setAddNote(
                    !Provider.of<Auth>(context, listen: false).getAddNote())
              },
          backgroundColor: PRIMARY_COLOR,
          child: Icon(
            Provider.of<Auth>(context, listen: false).getAddNote() == false
                ? Icons.add
                : Icons.list,
            color: TRIAL_COLOR,
          )),
    );
  }

  void _handleOnTap(listId) {
    setState(() {
      this.listId=listId;
      _isExpanded = !_isExpanded;
    });
  }

  @override
  editNote({id, context, contextDialog}) {
    Provider.of<Auth>(context, listen: false).setEditNote(true);
    Provider.of<Auth>(context, listen: false).setId(id);
    Navigator.pop(context);
    return null;
  }

  @override
  void changer({context, id}) {
    Provider.of<Auth>(context, listen: false).setLoadingStateFun(true);
    var token = Provider.of<Auth>(context, listen: false).getTokenFun();
    var deletePhone = deleteNoteApi(
      id: id,
      token: token,
    );
    LoadingDialog(context: context, title: "please wait.....");

    deletePhone.then((value) async {
      if (value == true) {
        Navigator.of(context).pop();
        Provider.of<Auth>(context, listen: false).setLoadingStateFun(false);
      }
    });

    deletePhone.catchError((value) async {
      Provider.of<Auth>(context, listen: false).setLoadingStateFun(false);
      Navigator.of(context).pop();
      InfoDialog(
          context: context,
          callback: _Note(
            personId: personId,
          ),
          title: Constant.error,
          type: Constant.error);
    });
  }
}
