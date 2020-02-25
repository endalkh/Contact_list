import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/api/auth.dart';
import 'package:flutter_app/api/model/get_phone.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/constants/constant.dart';
import 'package:flutter_app/pages/dialog/delete_update_dialog.dart';
import 'package:flutter_app/pages/dialog/info_dialog.dart';
import 'package:flutter_app/pages/dialog/loading_dialog.dart';
import 'package:flutter_app/pages/person_header/add_phone.dart';
import 'package:flutter_app/pages/person_header/update_phone.dart';
import 'package:flutter_app/pages/widgets/circularProgressBar.dart';
import 'package:flutter_app/state/app_state.dart';
import 'package:flutter_app/utilities/abstract_classes/confirmation_abstract.dart';
import 'package:flutter_app/utilities/abstract_classes/note_del_and_edit.dart';
import 'package:flutter_app/utilities/get_icon_type.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class PhoneNumber extends StatelessWidget implements NoteDelAndEdit,ShouldImp{
  String personId;
  BuildContext context;
  PhoneNumber({@required this.personId});
  @override
  Widget build(BuildContext context) {
this.context=context;
    return Provider.of<Auth>(context).getEditPhone()==true?UpdatePhone(id:Provider.of<Auth>(context).getId()):
       Column(
          children: <Widget>[
            Text(
              'Phone Numbers',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
            ),
    Expanded(
           child: FutureBuilder <List<GetPhone>>(
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
                          return  Container(
                                  margin: EdgeInsets.only(
                                      left: 10, right: 10, bottom: 10),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: Container(
                                      margin: EdgeInsets.zero,
                                      child: snapshot.data[index].number.isEmpty==true?Container():Column(
                                          children: [
                                            ListTile(
                                              leading: IconButton(
                                      icon: Icon(getPhoneNumberTypeIcon(snapshot.data[index].type),color: PRIMARY_COLOR,),
                                                onPressed:(){
                                                  UrlLauncher.launch("tel://"+getPhoneNumberTypeIcon(snapshot.data[index].type).toString());
                                                },

                                    ),
//
                                              title: Text(snapshot.data[index].number,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 17),
                                              ),
                                              onLongPress: (){
                                                DeleteAndEditNotesDialog(context: context,callback:PhoneNumber(),id: snapshot.data[index].id );
                                              },
                                            ),
                                          ]
                                      ),
                                    ),
                                  ),
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

                AddPhone(personId: personId,):Container(),
            Divider(),
          ],
        );

  }



  @override
  editNote({id, context, contextDialog}) async{
    await Provider.of<Auth>(context,listen: false).setEditPhone(true);
    Provider.of<Auth>(context,listen: false).setId(id);
    Navigator.pop(context);
    return null;
  }

  @override
  void changer({context, id}) {
    Provider.of<Auth>(context, listen: false).setLoadingStateFun(true);
    var token = Provider.of<Auth>(context, listen: false).getTokenFun();
    var deletePhone =deletePhoneApi(
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
            callback: PhoneNumber(),
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
          callback: PhoneNumber(),
          title: Constant.error,
          type:Constant.error
      );
    });
  }
  }

