
import 'package:flutter/material.dart';
import 'package:flutter_app/api/auth.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/constants/constant.dart';
import 'package:flutter_app/pages/widgets/circularProgressBar.dart';
import 'package:flutter_app/state/app_state.dart';
import 'package:flutter_app/utilities/round_letter_getter/get_round_letter.dart';
import 'package:provider/provider.dart';
import 'package:rounded_letter/rounded_letter.dart';
import 'package:rounded_letter/shape_type.dart';

class Contacts extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    final token =  Provider.of<Auth>(context, listen: false).getTokenFun();
    Provider.of<Auth>(context,listen: false).setLoadingStateFun(true);
    var allContact =  getAllContactApi(token: token);
    Provider.of<Auth>(context,listen: false).setLoadingStateFun(false);

    allContact.then((val) {
      Provider.of<Auth>(context, listen: false).setAllContactFun(val);
    });

    allContact.catchError((value) {
      Provider.of<Auth>(context, listen: false).setHasErrorFun(value.toString());
    });

    return Consumer<Auth>(
      builder: (BuildContext context, Auth value, Widget child) =>
      value.getIsLoadingFun()==true?circularIndicator(context: context):
      Scaffold(
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(left: 10,right: 10),
            child: Column(
              children: [
                SizedBox(height: 5,),
                Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: InkWell(
                      onTap: () =>
                      {Navigator.pushNamed(context, Constant.PERSON_HEADER)},
                      child: Container(
                        child: ListTile(
                            leading: RoundedLetter(
                              text: getRoundLetter("Anthony Doe"),
                              shapeType: ShapeType.circle,
                              shapeColor: PRIMARY_COLOR,
                              shapeSize: 40,
                              fontSize: 20,
                              borderWidth: 1,
                              borderColor: Color.fromARGB(255, 0, 0, 0),
                            ),
                            title:Text("Anthony Doe",style: TextStyle(
                              fontSize: 20,
                            ),),

                            subtitle: Text('Migrated From Phone Contacts',
                              style: TextStyle(fontSize: 15),
                            )),

                      ),
                    )),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Container(
                    child: ListTile(
                        leading: RoundedLetter(
                          text: getRoundLetter("Endalk Doe"),
                          shapeType: ShapeType.circle,
                          shapeColor: PRIMARY_COLOR,
                          shapeSize: 40,
                          fontSize: 20,
                          borderWidth: 1,
                          borderColor: Color.fromARGB(255, 0, 0, 0),
                        ),
                        title: Text('Endalk Doe',style: TextStyle(fontSize: 20)),
                        subtitle: Text('Migrated From Phone Contacts',style: TextStyle(fontSize: 15))),
                  ),
                ),

                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Container(
                    child: ListTile(
                        leading:  RoundedLetter(
                          text: getRoundLetter("Jhon Doe"),
                          shapeType: ShapeType.circle,
                          shapeColor: PRIMARY_COLOR,
                          shapeSize: 40,
                          fontSize: 20,
                          borderWidth: 1,
                          borderColor: Color.fromARGB(255, 0, 0, 0),
                        ),
                        title: Text('Bonkers Doe',style: TextStyle(fontSize: 20)),
                        subtitle: Text('Migrated From Phone Contacts',style: TextStyle(fontSize: 15))),
                  ),
                ),

                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Container(
                    child: ListTile(
                        leading:  RoundedLetter(
                          text: getRoundLetter("Caroline Doe"),
                          shapeType: ShapeType.circle,
                          shapeColor: PRIMARY_COLOR,
                          shapeSize: 40,
                          fontSize: 20,
                          borderWidth: 1,
                          borderColor: Color.fromARGB(255, 0, 0, 0),
                        ),
                        title: Text('Caroline Doe',style: TextStyle(fontSize: 20),),
                        subtitle: Text('Migrated From Phone Contacts',style: TextStyle(fontSize: 15))),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),

    );;
  }
}