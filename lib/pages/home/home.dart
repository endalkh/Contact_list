
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
import 'package:flutter_app/pages/home/upcoming_birth_days.dart';
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
  var page;
  @override
  void initState() {
    page=0;
    super.initState();
  }



  pageTaped(page) {
    switch (page) {
      case 0:
        return UpcomingBirthDaysScreen();
        break;
      case 1:
       return LastContact();
        break;
      default:
        return Contacts();
    }
  }

  getTitle(context) {
    if (Provider.of<Auth>(context,listen: false).getHomePageTabFun() == 0)
      return "Upcoming Birthdays";
    else if (Provider.of<Auth>(context,listen: false).getHomePageTabFun()  == 1)
      return "Last Contact";
    else
      return "Contacts";
  }

  void onTabTapped(int index) {
    Provider.of<Auth>(context,listen: false).setHomePageTabFun(index);
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
        onTap: onTabTapped,
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
