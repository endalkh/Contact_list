import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/api/auth.dart';
import 'package:flutter_app/api/model/get_single_person.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/constants/constant.dart';
import 'package:flutter_app/pages/appbar/AppBar.dart';
import 'package:flutter_app/pages/person_header/contact_information.dart';
import 'package:flutter_app/pages/person_header/notes.dart';
import 'package:flutter_app/pages/widgets/circularProgressBar.dart';
import 'package:flutter_app/state/app_state.dart';
import 'package:flutter_app/utilities/date_formater.dart';
import 'package:flutter_app/utilities/validation/get_size.dart';
import 'package:provider/provider.dart';

class PersonHeaderScreen extends StatelessWidget {
final String personId;
 BuildContext context;
  // In the constructor, require a person Id
PersonHeaderScreen({Key key, @required this.personId}) : super(key: key);

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
    print(page);
    switch (page) {
      case 0:
        return Notes();
        break;
      case 1:
        return ContactInfo();
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
        width: getWidth(context),
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
        width: getWidth(context),
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

  getTitle(context) {
    switch(Provider.of<Auth>(context,listen: false).getHomePageTabFun()){
      case 0:
        return "Notes";
        break;
      case 1:
        return "Contact Information";
        break;
      case 2:
        return "Person Setting";
        break;
      default:{
        print("someting wrong");
      }

    }
  }





  personalSettings() {
    return Scaffold(

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
                  Expanded(
                    flex: 1,
                    child:Container(
                      width: 100,
                      child: deleteButton(),
                    ),
                  ),
                  SizedBox(width: 10,),
                  Expanded(
                    flex: 1,
                    child: Container(
                      width: 210,
                      child: submitButton(),
                    ),
                  )

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
    this.context=context;
    return Scaffold(
        appBar: headerNav(context: context, title:getTitle(context)),
        body: Column(

          children: [
            SizedBox(
              height: 10,
            ),
        FutureBuilder <GetSinglePerson> (
        future: getSinglePersonApi(
        token: Provider.of<Auth>(context).getTokenFun(),
            id: personId
    ),
    builder: (context, snapshot) {
    if (snapshot.hasData) {
      return Container(
        child: Column(
          children: <Widget>[


            RawMaterialButton(
              onPressed: () {},
              child: new Icon(
                Icons.person,
                color: TRIAL_COLOR,
                size: 35.0,
              ),
              shape: new CircleBorder(),
              elevation: 2.0,
              fillColor:PRIMARY_COLOR,
              padding: const EdgeInsets.all(15.0),
            ),

            ListTile(
              title: Center(
                child: Text(
                  snapshot.data.name,
                  style: TextStyle(fontSize: 30,),

                ),
              ),
              subtitle: Column(
                children: [
                  Text(
                    'Birthday : '+ dateFormatter(snapshot.data.birthDate),
                    style: TextStyle(fontSize: 15),
                  ),
                  Text(
                    'Last Contacted: '+dateFormatter(snapshot.data.lastContact),
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
    return circularIndicator(context:context);
    }
        ),

            // Divider(),
            Expanded(
              child: Center(
                child: Container(
                  child: Center(
                    child: pageTaped(Provider.of<Auth>(context).getHomePageTabFun(),
                  ),
                ),
              ),
            )
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: Provider.of<Auth>(context,listen: false).getHomePageTabFun(),
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
            Provider.of<Auth>(context,listen: false).setHomePageTabFun(index);
          },
        ),
      );
  }
}
