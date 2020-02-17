import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/pages/person_header/notes.dart';
import 'package:flutter_app/utilities/validation/get_size.dart';

class ContactInfo extends StatelessWidget{
  String personId;
  ContactInfo({@required this.personId});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
              children: [
            SizedBox(height: 10,),
                Text(
                  'Phone Numbers',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Container(
                        margin: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            ListTile(
                              leading: Icon(Icons.phone, size: 30,color: PRIMARY_COLOR,),
                              title: Text(
                                '+1(424) 341-3346',
                                style: TextStyle(
                                    fontWeight: FontWeight.w400, fontSize: 17),
                              ),
                            ),
                            Divider(),
                            ListTile(
                              leading: Icon(Icons.add,size: 30,color: PRIMARY_COLOR,),
                              title: Text(
                                'Add Phone',
                                style: TextStyle(
                                    fontWeight: FontWeight.w400, fontSize: 17),
                              ),
                              onTap: (){

                              },
                            ),

                          ],
                        ),
                      )),
                ),
                Text(
                  'Email Information',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  // height: 200,
                  child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Container(
                        margin: EdgeInsets.all(10),
                        child: Column(children: [
                          ListTile(
                            leading: Icon(Icons.email,size: 30,color: PRIMARY_COLOR,),
                            title: Text(
                              'JohnDoe12345@gmail.com',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 17),
                            ),
                          ),
                          Divider(),
                          ListTile(
                            leading: Icon(Icons.add,size: 30,color: PRIMARY_COLOR,),
                            title: Text(
                              'Add Email',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 17),
                            ),
                            onTap: (){

                            },
                          ),



                        ]),
                      )),
                ),
                Text(
                  'Notes',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                ),
                Container(
                  height: getHeight(context)*0.5,
                  child:  Notes(personId: personId,),
                ),



              ],
            ),

        ));
  }

}