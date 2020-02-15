
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/api/auth.dart';
import 'package:flutter_app/api/model/add_new_person.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/constants/constant.dart';
import 'package:flutter_app/pages/appbar/AppBar.dart';
import 'package:flutter_app/pages/drawer/navigation_drawer.dart';
import 'package:flutter_app/pages/home/add_new_person.dart';
import 'package:flutter_app/pages/home/contacts.dart';
import 'package:flutter_app/pages/home/last_contact.dart';
import 'package:flutter_app/pages/widgets/circularProgressBar.dart';
import 'package:flutter_app/state/app_state.dart';
import 'package:flutter_app/utilities/round_letter_getter/get_round_letter.dart';
import 'package:flutter_app/utilities/validation/get_size.dart';
import 'package:provider/provider.dart';
import 'package:rounded_letter/rounded_letter.dart';
import 'package:rounded_letter/shape_type.dart';

class Home extends StatefulWidget {
  Dashboard createState() => Dashboard();
}

class Dashboard extends State<Home> {
  BuildContext context;
  /*==== upcoming Birthdays   on the first tap=======*/
  upcomingBirthDays() {
    return Scaffold(
      // backgroundColor: TRIAL_COLOR,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.all(5)),
            Text(
              'Tomorrow',
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                  fontStyle: FontStyle.italic),
            ),
            Padding(
              padding: EdgeInsets.only(left: 14, right: 14, bottom: 14),
              child: Container(
                height: getHeight(context),
                decoration: BoxDecoration(),
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 1.0),
                        child: Column(
                          children: [
                            Container(
//                              height: 50,
                              child: ListTile(
                                onTap: () => {
                                  Navigator.pushNamed(
                                      context, Constant.PERSON_HEADER)
                                },
                                leading:RoundedLetter(
                                  text: getRoundLetter("John Doe").toUpperCase(),
                                  shapeType: ShapeType.circle,
                                  shapeColor: PRIMARY_COLOR,
                                  shapeSize: 40,
                                  fontSize: 20,
                                  borderWidth: 1,
                                  borderColor: Color.fromARGB(255, 0, 0, 0),

                                ),
                                title: Text(
                                  'John Doe',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,

                                      fontSize: 20,
                                      ),
                                ),
                                subtitle: Text(
                                  'Date of Birth',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontStyle: FontStyle.italic,
                                  fontSize: 15
                                  ),

                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  /*==== Adding new Contact on the third tap=======*/



  pageTaped(page) {
    switch (page) {
      case 0:
        return upcomingBirthDays();
        break;
      case 1:
       return LastContact();
        break;
      case 2:
          return Contacts();
        break;
      default:
        return upcomingBirthDays();
    }
  }

  getTitle(context) {
    return "home";
    if (Provider.of<Auth>(context,listen: false).getHomePageTabFun() == 0)
      return "Upcoming Birthdays";
    else if (Provider.of<Auth>(context,listen: false).getHomePageTabFun()  == 1)
      return "Last Contact";
    else
      return "Contacts";
  }

  @override
  Widget build(BuildContext context) {

    this.context=context;

    return  Scaffold(
      appBar: headerNav(title: getTitle(context), context: context),
      drawer: SideDrawer(),
      body: Container(
        child: Center(
          child: pageTaped(Provider.of<Auth>(context).getHomePageTabFun()),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: Provider.of<Auth>(context).getHomePageTabFun() ,
        // unselectedItemColor: Colors.black26,
        selectedItemColor: PRIMARY_COLOR,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.event),
            title: new Text('Birthdays'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.contact_mail),
            title: new Text('last contact'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.contacts),
            title: new Text('Contacts'),
          )
        ],
        onTap: (index) {
         Provider.of<Auth>(context,listen: false).setHomePageTabFun(index);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddNewPersonScreen()),
          )
        },
        backgroundColor: PRIMARY_COLOR,
        child: Icon(
          Icons.add,
          color: lightBG,
        ),
      ),
    );

  }
}
