import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/api/auth.dart';
import 'package:flutter_app/api/model/get_email.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/constants/constant.dart';
import 'package:flutter_app/pages/dialog/delete_update_dialog.dart';
import 'package:flutter_app/pages/dialog/info_dialog.dart';
import 'package:flutter_app/pages/dialog/loading_dialog.dart';
import 'package:flutter_app/pages/person_header/add_email.dart';
import 'package:flutter_app/pages/person_header/update_email.dart';
import 'package:flutter_app/pages/widgets/circularProgressBar.dart';
import 'package:flutter_app/state/app_state.dart';
import 'package:flutter_app/utilities/abstract_classes/confirmation_abstract.dart';
import 'package:flutter_app/utilities/abstract_classes/note_del_and_edit.dart';
import 'package:flutter_app/utilities/get_icon_type.dart';
import 'package:provider/provider.dart';

class EmailAddress extends StatefulWidget {
  final String personId;
  EmailAddress({@required this.personId});

  _EmailAddress createState()=>_EmailAddress( personId: personId);
}

class _EmailAddress extends State<EmailAddress> implements NoteDelAndEdit,ShouldImp {
  String personId;

  _EmailAddress({@required this.personId});


  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      Provider.of<Auth>(context,listen: false).setLoadingStateFun(false);
      Provider.of<Auth>(context,listen: false).setHasErrorFun("");
      Provider.of<Auth>(context, listen: false).setEditEmail(false);
    }
    );
    super.initState();
    }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Provider.of<Auth>(context).getAddEmail()==true?  Container(
        child:  AddEmail(personId: personId),
      ):
      Provider.of<Auth>(context).getEditEmail()==true?UpdateEmail(id:Provider.of<Auth>(context).getId()):
    Padding(
      padding: EdgeInsets.only(bottom: 15),
    child:Column(
        children: <Widget>[
          Text(
            'Email Information',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
          ),
          SizedBox(
            height: 10,
          ),

   FutureBuilder <List<GetEmail>>(
              future: getEmailListApi(
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
                              margin: EdgeInsets.only(left: 10,right: 10),
                              child:  Container(
                                margin: EdgeInsets.only(
                                    left: 10, right: 10),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Container(
                                    margin: EdgeInsets.zero,
                                    child:snapshot.data[index].address.isEmpty==true?Container(): Column(
                                        children: [
                                          ListTile(
                                            leading:
                                            Icon(getPhoneNumberTypeIcon(snapshot.data[index].type), size: 30,
                                              color: PRIMARY_COLOR,),
                                            title: Text(snapshot.data[index].address,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 17),
                                            ),
                                            subtitle: Text(snapshot.data[index].type),
                                            onLongPress:(){
                                              DeleteAndEditNotesDialog(context: this.context,callback:_EmailAddress(),id: snapshot.data[index].id );

                                            },
                                          ),
                                        ]
                                    ),
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

        ]
    ),
    ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => {
            Provider.of<Auth>(context,listen: false).setAddEmail(!Provider.of<Auth>(context,listen: false).getAddEmail())
          },
          backgroundColor: PRIMARY_COLOR,
          child: Icon(
            Provider.of<Auth>(context,listen: false).getAddEmail()==false?Icons.add:Icons.list,color: TRIAL_COLOR,
          )
      ),
    );
  }


  @override
  editNote({id, context, contextDialog}) async{
    await Provider.of<Auth>(context,listen: false).setEditEmail(true);
    Provider.of<Auth>(context,listen: false).setId(id);
    Navigator.pop(context);
    return null;
  }
  @override
  void changer({context, id}) {
    Provider.of<Auth>(context, listen: false).setLoadingStateFun(true);
    var token = Provider.of<Auth>(context, listen: false).getTokenFun();
    var deleteEmail = deleteEmailApi(
      id: id,
      token: token,
    );
    LoadingDialog(context: context,title: "please wait.....");

    deleteEmail.then((value) async {
      if(value==true) {
        Navigator.of(context).pop();
        Provider.of<Auth>(context, listen: false).setLoadingStateFun(false);
        InfoDialog(
            context: context,
            callback: _EmailAddress(),
            title: Constant.success,
            type:Constant.success
        );
      }
    });

    deleteEmail.catchError((value) async {
      Provider.of<Auth>(context, listen: false).setLoadingStateFun(false);
      Navigator.of(context).pop();
      InfoDialog(
          context: context,
          callback: _EmailAddress(),
          title: Constant.error,
          type:Constant.error
      );
    });
  }
}