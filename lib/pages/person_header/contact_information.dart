import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/constants/constant.dart';
import 'package:flutter_app/utilities/validation/get_size.dart';

class ContactInfo extends StatefulWidget{
  _ContactInfo createState()=>_ContactInfo();
}
class _ContactInfo extends State<ContactInfo>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(

        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(10),
            child: Column(
              children: [
                Text(
                  'Phone Numbers',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w300),
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
                              leading: Icon(Icons.home, size: 30),
                              title: Text(
                                '+1(424) 341-3346',
                                style: TextStyle(
                                    fontWeight: FontWeight.w400, fontSize: 17),
                              ),
                            ),
                            Divider(),
                            ListTile(
                              leading: Icon(Icons.phone, size: 25),
                              title: Text(
                                "+1(424) 341-3346",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400, fontSize: 17),
                              ),
                            ),
                            Divider(),
                            Row(
                              children: [
                                Padding(padding: EdgeInsets.only(left: 15)),
                                Align(
                                  alignment: Alignment(-0.9, -1),
                                  child: Container(
                                    // padding: EdgeInsets.only(right: 10),
                                    height: 30.0,
                                    width: 30.0,
                                    margin: EdgeInsets.only(bottom: 5),
                                    child: FloatingActionButton(
                                      onPressed: () => {},
                                      backgroundColor: PRIMARY_COLOR,
                                      child: Icon(
                                        Icons.add,
                                        color: lightBG,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(padding: EdgeInsets.only(left: 265)),
                                Align(
                                  alignment: Alignment(0, 0),
                                  child: Container(
                                    height: 30.0,
                                    width: 30.0,
                                    margin: EdgeInsets.only(bottom: 5),
                                    child: FloatingActionButton(
                                      onPressed: () => {},
                                      backgroundColor: PRIMARY_COLOR,
                                      child: Icon(
                                        Icons.edit,
                                        color: lightBG,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      )),
                ),
                Text(
                  'Email Information',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w300),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  // height: 200,
                  width: 500,
                  child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Container(
                        margin: EdgeInsets.all(10),
                        child: Column(children: [
                          ListTile(
                            leading: Image.asset('assets/images/gmail.png',
                                height: 30, width: 30),
                            title: Text(
                              'JohnDoe12345@gmail.com',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 17),
                            ),
                          ),
                          Divider(),
                          ListTile(
                            leading: Image.asset('assets/images/icloud.png',
                                height: 30, width: 30),
                            title: Text(
                              'JohnDoe12345@icloud.com',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 17),
                            ),
                          ),
                          Divider(),
                          ListTile(
                            leading: Image.asset(
                              'assets/images/yahoo.png',
                              height: 30,
                              width: 30,
                            ),
                            title: Text(
                              'JohnDoe12345@Yahoo.org',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 17),
                            ),
                          ),
                          Divider(),
                          Row(
                            children: [
                              Padding(padding: EdgeInsets.only(left: 10)),
                              Align(
                                alignment: Alignment(-0.9, -1),
                                child: Container(
                                  // padding: EdgeInsets.only(right: 10),
                                  height: 30.0,
                                  width: 30.0,
                                  margin: EdgeInsets.only(bottom: 5),
                                  child: FloatingActionButton(
                                    onPressed: () => {},
                                    backgroundColor: PRIMARY_COLOR,
                                    child: Icon(
                                      Icons.add,
                                      color: lightBG,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(padding: EdgeInsets.only(left: 265)),
                              Align(
                                alignment: Alignment(0, 0),
                                child: Container(
                                  height: 30.0,
                                  width: 30.0,
                                  margin: EdgeInsets.only(bottom: 5),
                                  child: FloatingActionButton(
                                    onPressed: () => {},
                                    backgroundColor: PRIMARY_COLOR,
                                    child: Icon(
                                      Icons.edit,
                                      color: lightBG,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),

                          // FloatingActionButton(
                          //   onPressed: () => {},
                          //   backgroundColor: PRIMARY_COLOR,
                          //   child: Icon(

                          //     Icons.add,
                          //     color: lightBG,
                          //   ),
                          // ),
                        ]),
                      )),
                ),
                Container(
                  margin: EdgeInsets.only(left: 15, right: 15),
                  child: Column(
                    children: [
                      Text(
                        'Notes',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 27, fontWeight: FontWeight.w300),
                      ),
                      Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Container(
                          height: getHeight(context),
                          child: ListView.builder(
                            itemCount: 4,
                            itemBuilder: (context, index) {
                              return Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Padding(
                                    padding: const EdgeInsets.all(1.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: ListTile(
                                            title: ExpansionTile(
                                              title: Text('Header Goes Here'),
                                              subtitle: Text(
                                                  Constant.PASSWORDRESETDESC),
                                              children: [
                                                ListTile(
                                                  leading: Icon(Icons.delete),
                                                ),
                                                ListTile(
                                                  leading: Icon(Icons.edit),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

}