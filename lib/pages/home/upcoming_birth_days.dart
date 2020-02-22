import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/api/auth.dart';
import 'package:flutter_app/api/model/contact_list.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/constants/constant.dart';
import 'package:flutter_app/pages/dialog/confirmationDialog.dart';
import 'package:flutter_app/pages/dialog/delete_update_dialog.dart';
import 'package:flutter_app/pages/dialog/info_dialog.dart';
import 'package:flutter_app/pages/home/update_contacts.dart';
import 'package:flutter_app/pages/person_header/person_header.dart';
import 'package:flutter_app/pages/widgets/circularProgressBar.dart';
import 'package:flutter_app/state/app_state.dart';
import 'package:flutter_app/utilities/abstract_classes/confirmation_abstract.dart';
import 'package:flutter_app/utilities/abstract_classes/note_del_and_edit.dart';
import 'package:flutter_app/utilities/date_formater.dart';
import 'package:flutter_app/utilities/round_letter_getter/get_round_letter.dart';
import 'package:provider/provider.dart';
import 'package:rounded_letter/rounded_letter.dart';
import 'package:rounded_letter/shape_type.dart';

class UpcomingBirthDaysScreen extends StatefulWidget{
  _UpcomingBirthDaysScreen createState()=>_UpcomingBirthDaysScreen();
}
class _UpcomingBirthDaysScreen extends State<UpcomingBirthDaysScreen> implements NoteDelAndEdit,ShouldImp{
 bool isApiLoaded;
  @override
  void initState() {
    isApiLoaded=false;
    super.initState();
  }
  @override
  void didChangeDependencies() {
   if(!isApiLoaded) {
     isApiLoaded=true;
     Provider.of<Auth>(context, listen: false).setLoadingStateFun(false);
     Provider.of<Auth>(context).setHasErrorFun("");
   }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
      return  Provider.of<Auth>(context).getEditContact()==true?
      UpdateContact(id:Provider.of<Auth>(context).getId())
          : Scaffold(
        body:  Padding(
      padding: EdgeInsets.only(top: 10),
        child:FutureBuilder <List<GetAllContact>> (
          future: getUpComingBirthdayApi(
              token: Provider.of<Auth>(context).getTokenFun()
          ),
          builder: (context, snapshot) {
            if (snapshot.hasData) {

              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return  SingleChildScrollView(
                      child: Container(
                        margin: EdgeInsets.only(left: 10,right: 10),
                        child: Column(
                          children: [
                            SizedBox(height: 3,),
                            Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: InkWell(


//                                  {Navigator.pushNamed(context, Constant.PERSON_HEADER)},
                                  child: Container(
                                    child: ListTile(
                                        leading: RoundedLetter(
                                          text: getRoundLetter(snapshot.data[index].name.toString().toUpperCase()),
                                          shapeType: ShapeType.circle,
                                          shapeColor: PRIMARY_COLOR,
                                          shapeSize: 40,
                                          fontSize: 20,
                                          borderWidth: 1,
                                          borderColor: Color.fromARGB(255, 0, 0, 0),
                                        ),
                                        title:Text(snapshot.data[index].name,style: TextStyle(
                                          fontSize: 20,
                                        ),),

                                        subtitle: Text(dateFormatter(snapshot.data[index].birthDate),
//
                                          style: TextStyle(fontSize: 15),

                                        ),
                                      onLongPress: (){
                                        DeleteAndEditNotesDialog(context: context,callback:_UpcomingBirthDaysScreen(),id: snapshot.data[index].id );
                                      },
                                      onTap: (){
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => PersonHeaderScreen(personId:snapshot.data[index].id,),
                                          ),
                                        );
                                      },

                                    ),

                                  ),
                                )),

                          ],
                        ),
                      ),
                    );
                  }
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

          },

        ),
        ),
      );



    }

  @override
  deleteNote({id, context, contextDialog}) {
    InfoDialog(
        context:context,
//        id:id,
        title:"Are you sure for this action?",
        callback:_UpcomingBirthDaysScreen(),
      type: Constant.warningIcon,
    );

    Navigator.pop(context);
    return null;
  }

  @override
  editNote({id, context, contextDialog}) {
    Provider.of<Auth>(context,listen: false).setLoadingStateFun(true);
    Provider.of<Auth>(context,listen: false).setEditContact(true);
    Provider.of<Auth>(context,listen: false).setId(id);
    Navigator.pop(context);
    return null;
  }

  @override
  void changer({context,id}) {
    Provider.of<Auth>(context, listen: false).setLoadingStateFun(true);
    var token = Provider.of<Auth>(context, listen: false).getTokenFun();
    var deleteNote = deletePersonApi(
      id: id,
      token: token,
    );
    deleteNote.then((value) async {
      if(value==true) {
        Provider.of<Auth>(context, listen: false).setSuccessfullyRegisteredFun(true);
        Provider.of<Auth>(context, listen: false).setLoadingStateFun(false);
        InfoDialog(
            context: context,
            callback: _UpcomingBirthDaysScreen(),
            title: Constant.success,
            type:Constant.success
        );
      }
    });

    deleteNote.catchError((value) async {
      Provider.of<Auth>(context, listen: false).setLoadingStateFun(false);
      InfoDialog(
          context: context,
          callback: _UpcomingBirthDaysScreen(),
          title: Constant.error,
          type:Constant.error
      );
    });
    Navigator.pop(context);
  }
  }
