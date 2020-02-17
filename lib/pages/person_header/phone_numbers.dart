import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/api/auth.dart';
import 'package:flutter_app/api/model/get_phone.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/pages/dialog/delete_update_dialog.dart';
import 'package:flutter_app/pages/person_header/add_phone.dart';
import 'package:flutter_app/pages/widgets/circularProgressBar.dart';
import 'package:flutter_app/state/app_state.dart';
import 'package:flutter_app/utilities/abstract_classes/note_del_and_edit.dart';
import 'package:flutter_app/utilities/get_icon_type.dart';
import 'package:provider/provider.dart';

class PhoneNumber extends StatelessWidget implements NoteDelAndEdit{
  String personId;
  BuildContext context;
  PhoneNumber({@required this.personId});
  @override
  Widget build(BuildContext context) {
this.context=context;
    return Column(
      children: <Widget>[
        Text(
          'Phone Numbers',
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
        ),


        FutureBuilder <List<GetPhone>>(
            future: getPhoneListApi(
              token: Provider.of<Auth>(context).getTokenFun(),
              personId: personId,
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
                                          leading:
                                          Icon(getPhoneNumberTypeIcon(snapshot.data[index].type), size: 30,
                                            color: PRIMARY_COLOR,),
                                          title: Text(snapshot.data[index].number,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 17),
                                          ),
                                          onLongPress: (){
                                            DeleteAndEditNotesDialog(context: context,callback:PhoneNumber(),personId: personId );
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

        ListTile(
          leading: Icon(Icons.add,size: 30,color: PRIMARY_COLOR,),
          title: Text(
            'Add Phone number',
            style: TextStyle(
                fontWeight: FontWeight.w400, fontSize: 17),
          ),
          onTap: (){
            Provider.of<Auth>(context,listen: false).setAddPhone(!Provider.of<Auth>(context,listen: false).getAddPhone());
            Provider.of<Auth>(context,listen: false).setHasErrorFun("");
          },
        ),
        Provider.of<Auth>(context,listen: false).getAddPhone()==true?
        Container(
            height:150 ,
            child:AddPhone(personId: personId,)):Container(),
        Divider(),
      ],
    );
  }

  @override
  deleteNote({personId, context, contextDialog}) {
    // TODO: implement deleteNote
    return null;
  }

  @override
  editNote({personId, context, contextDialog}) {
    // TODO: implement editNote
    return null;
  }

}