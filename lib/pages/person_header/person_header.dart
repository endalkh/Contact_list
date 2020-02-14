import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/constants/constant.dart';
import 'package:flutter_app/pages/appbar/AppBar.dart';
// import 'package:flutter_app/pages/appbar/subAppBar.dart';
import 'package:flutter_app/pages/drawer/navigation_drawer.dart';
import 'package:flutter_app/utilities/validation/get_size.dart';

class PersonHeaderFun extends StatefulWidget {
  _PersonHeaderFun createState() => _PersonHeaderFun();
}

class _PersonHeaderFun extends State<PersonHeaderFun> {
  int _page = 0;
  // GlobalKey _bottomNavigationKey = GlobalKey();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController birthdayController = TextEditingController();


  List<DropdownMenuItem<PhoneType>> phoneDropdownMenuItems;
  List<DropdownMenuItem<EmailType>> emailDropdownMenuItems;
  PhoneType selectPhone;
  EmailType selectEmail;

  get phoneOnChangeDropdownItem => null;

  pageTaped(page) {
    switch (page) {
      case 0:
        return notes();
        break;
      case 1:
        return contactInformation();
        break;
      default:
        return personalSettings();
    }
  }

  submitButton() {
    return RaisedButton(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      onPressed: () {
        Navigator.pushNamed(context, Constant.HOME);
      },
      textColor: Colors.white,
      padding: EdgeInsets.all(0.0),
      child: Container(
        alignment: Alignment.center,
        width: get_width(context),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          color: PRIMARY_COLOR,
          // gradient: LinearGradient(colors: [PRIMARY_COLOR, SECONDARY_COLOR]),
        ),
        padding: const EdgeInsets.all(15.0),
        child: Text(Constant.SUBMIT, style: TextStyle(fontSize: 12)),
      ),
    );
  }

  deleteButton() {
    return RaisedButton(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      onPressed: () {
        Navigator.pushNamed(context, Constant.HOME);
      },
      textColor: Colors.white,
      padding: EdgeInsets.all(0.0),
      child: Container(
        alignment: Alignment.center,
        width: get_width(context),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          color: Colors.red,
          // gradient: LinearGradient(colors: Colors.red),
        ),
        padding: const EdgeInsets.all(15.0),
        child: Text('Delete', style: TextStyle(fontSize: 12)),
      ),
    );
  }

  getTitle() {
    if (_page == 0)
      return "Notes";
    else if (_page == 1)
      return "Contact Information";
    else
      return "Person Setting";
  }

  notes() {
    return Scaffold(
      // backgroundColor: TRIAL_COLOR,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 15, right: 15),
          child: Column(
            children: [
              Text(
                'Notes',
                style: TextStyle(fontSize: 27, fontWeight: FontWeight.w300),
              ),
              Padding(
                padding: EdgeInsets.all(2.0),
                child: Container(
                  height: get_height(context),
                  child: ListView.builder(
                    itemCount: 10,
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
                                      title: Text(
                                        'Header Goes Here',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500),
                                      ),
                                      subtitle:
                                          Text(Constant.PASSWORDRESETDESC),
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
      ),
    );
  }

  contactInformation() {
    return Scaffold(
        // backgroundColor: TRIAL_COLOR,
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
                          height: get_height(context),
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

  personalSettings() {
    return Scaffold(
      // backgroundColor: TRIAL_COLOR,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(15),
          child: Column(
            children: [
              Text(
                'Settings',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
              ),
              Padding(padding: EdgeInsets.all(5)),
              Material(
                borderRadius: BorderRadius.circular(10.0),
                elevation: 12,
                child: TextFormField(
                  controller: nameController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person, size: 20),
                    hintText: "First Name",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none),
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.all(5)),
              Material(
                borderRadius: BorderRadius.circular(10.0),
                elevation: 12,
                child: TextFormField(
                  // controller: nameController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person, size: 20),
                    hintText: "Last Name",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none),
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.all(5)),
              Container(
                height: 55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Material(
                    borderRadius: BorderRadius.circular(10.0),
                    elevation: 12,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                DropdownButton(
                                  value: selectPhone,
                                  items: phoneDropdownMenuItems,
                                  onChanged: phoneOnChangeDropdownItem,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: TextFormField(
                            controller: phoneController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              hintText: "JohnDoe12345@gmail.com",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  borderSide: BorderSide.none),
                            ),
                          ),
                        )
                      ],
                    )),
              ),
              Padding(padding: EdgeInsets.only(top: 10)),
              Row(
                children: <Widget>[
                  Container(
                    width: 100,
                    child: deleteButton(),
                  ),
                  Padding(padding: EdgeInsets.all(37)),
                  Container(
                    width: 210,
                    child: submitButton(),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: headerNav(context: context, title: getTitle()),
        body: Column(
          children: [
            SizedBox(
              height: 10,
            ),
                       CircleAvatar(
                                  backgroundColor: Colors.black,
                                  radius: 40,
                                  backgroundImage: AssetImage("assets/j.jpg")
                                ),
            ListTile(
              title: Center(
                child: Text(
                  'John Doe',
                  style: TextStyle(fontSize: 30,),
                  
                ),
              ),
              subtitle: Column(
                children: [
                  Text(
                    'Birthday : Birthday here',
                    style: TextStyle(fontSize: 15),
                  ),
                  Text(
                    'Last Contacted: Last Contacted Here',
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
            ),
            // Divider(),
            Expanded(
              child: Center(
                child: Container(
                  child: Center(
                    child: pageTaped(_page),
                  ),
                ),
              ),
            )
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _page,
          selectedItemColor: PRIMARY_COLOR,
          items: [
            BottomNavigationBarItem(
              icon: new Icon(Icons.event_note),
              title: new Text('Notes'),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.person),
              title: new Text('Contact Info'),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.edit),
              title: new Text('Person Setting'),
            )
          ],
          onTap: (index) {
            setState(() {
              _page = index;
            });
          },
        ),
      );
  }
}
