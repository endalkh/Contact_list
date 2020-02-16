
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/api/auth.dart';
import 'package:flutter_app/api/model/contact_list.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/constants/constant.dart';
import 'package:flutter_app/pages/widgets/circularProgressBar.dart';
import 'package:flutter_app/state/app_state.dart';
import 'package:flutter_app/utilities/round_letter_getter/get_round_letter.dart';
import 'package:provider/provider.dart';
import 'package:rounded_letter/rounded_letter.dart';
import 'package:rounded_letter/shape_type.dart';

class Contacts extends StatefulWidget{
  _Contacts createState()=>_Contacts();
}
class _Contacts extends State<Contacts>{
  List<GetAllContact> allContact;
  @override
  void initState() {
//    Provider.of<Auth>(context,listen: false).setHomePageTabFun(2);
//    final token =  Provider.of<Auth>(context, listen: false).getTokenFun();
//    Provider.of<Auth>(context,listen: false).setLoadingStateFun(true);
//    var allContact =  getAllContactApi(token: token);
//    Provider.of<Auth>(context,listen: false).setLoadingStateFun(false);
//    allContact.then((val) {
//      Provider.of<Auth>(context, listen: false).setAllContactFun(val);
////      allContact=List<GetAllContact>.from(val).map((x) => GetAllContact.fromJson(val));
//
//
//    });
//
//    allContact.catchError((value) {
//      Provider.of<Auth>(context, listen: false).setHasErrorFun(value.toString());
//    });

    super.initState();
  }
  Container makeCard(GetAllContact post) {
    return Container(
      margin: EdgeInsets.all(20.0),
      child: Text(post.name),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Padding(
    padding: EdgeInsets.only(top: 10),

      child:FutureBuilder <List<GetAllContact>> (
        future: getAllContactApi(
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

                            subtitle: Text(snapshot.data[index].birthDate,
                              style: TextStyle(fontSize: 15),
                            )),

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
            print(snapshot.error);
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


//      Consumer<Auth>(
//      builder: (BuildContext context, Auth value, Widget child) =>
//      value.getIsLoadingFun()==true?circularIndicator(context: context):
//      Scaffold(
//        body: SingleChildScrollView(
//          child: Container(
//            margin: EdgeInsets.only(left: 10,right: 10),
//            child: Column(
//              children: [
//                SizedBox(height: 5,),
//                Card(
//                    shape: RoundedRectangleBorder(
//                      borderRadius: BorderRadius.circular(15.0),
//                    ),
//                    child: InkWell(
//                      onTap: () =>
//                      {Navigator.pushNamed(context, Constant.PERSON_HEADER)},
//                      child: Container(
//                        child: ListTile(
//                            leading: RoundedLetter(
//                              text: getRoundLetter("Anthony Doe"),
//                              shapeType: ShapeType.circle,
//                              shapeColor: PRIMARY_COLOR,
//                              shapeSize: 40,
//                              fontSize: 20,
//                              borderWidth: 1,
//                              borderColor: Color.fromARGB(255, 0, 0, 0),
//                            ),
//                            title:Text("Anthony Doe",style: TextStyle(
//                              fontSize: 20,
//                            ),),
//
//                            subtitle: Text('Migrated From Phone Contacts',
//                              style: TextStyle(fontSize: 15),
//                            )),
//
//                      ),
//                    )),
//                Card(
//                  shape: RoundedRectangleBorder(
//                    borderRadius: BorderRadius.circular(15.0),
//                  ),
//                  child: Container(
//                    child: ListTile(
//                        leading: RoundedLetter(
//                          text: getRoundLetter("Endalk Doe"),
//                          shapeType: ShapeType.circle,
//                          shapeColor: PRIMARY_COLOR,
//                          shapeSize: 40,
//                          fontSize: 20,
//                          borderWidth: 1,
//                          borderColor: Color.fromARGB(255, 0, 0, 0),
//                        ),
//                        title: Text('Endalk Doe',style: TextStyle(fontSize: 20)),
//                        subtitle: Text('Migrated From Phone Contacts',style: TextStyle(fontSize: 15))),
//                  ),
//                ),
//
//                Card(
//                  shape: RoundedRectangleBorder(
//                    borderRadius: BorderRadius.circular(15.0),
//                  ),
//                  child: Container(
//                    child: ListTile(
//                        leading:  RoundedLetter(
//                          text: getRoundLetter("Jhon Doe"),
//                          shapeType: ShapeType.circle,
//                          shapeColor: PRIMARY_COLOR,
//                          shapeSize: 40,
//                          fontSize: 20,
//                          borderWidth: 1,
//                          borderColor: Color.fromARGB(255, 0, 0, 0),
//                        ),
//                        title: Text('Bonkers Doe',style: TextStyle(fontSize: 20)),
//                        subtitle: Text('Migrated From Phone Contacts',style: TextStyle(fontSize: 15))),
//                  ),
//                ),
//
//                Card(
//                  shape: RoundedRectangleBorder(
//                    borderRadius: BorderRadius.circular(15.0),
//                  ),
//                  child: Container(
//                    child: ListTile(
//                        leading:  RoundedLetter(
//                          text: getRoundLetter("Caroline Doe"),
//                          shapeType: ShapeType.circle,
//                          shapeColor: PRIMARY_COLOR,
//                          shapeSize: 40,
//                          fontSize: 20,
//                          borderWidth: 1,
//                          borderColor: Color.fromARGB(255, 0, 0, 0),
//                        ),
//                        title: Text('Caroline Doe',style: TextStyle(fontSize: 20),),
//                        subtitle: Text('Migrated From Phone Contacts',style: TextStyle(fontSize: 15))),
//                  ),
//                ),
//
//              ],
//            ),
//          ),
//        ),
//      ),
//
//    );
  }
//}