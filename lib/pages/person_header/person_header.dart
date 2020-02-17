import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/api/auth.dart';
import 'package:flutter_app/api/model/get_single_person.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/constants/constant.dart';
import 'package:flutter_app/pages/appbar/AppBar.dart';
import 'package:flutter_app/pages/person_header/contact_information.dart';
import 'package:flutter_app/pages/person_header/notes.dart';
import 'package:flutter_app/pages/person_header/personal_setting.dart';
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


  pageTaped(page) {
    print(page);
    switch (page) {
      case 0:
        return Note(personId: personId,);
        break;
      case 1:
        return ContactInfo(personId: personId,);
        break;
      default:
        return PersonalSetting();
    }
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

                    child: pageTaped(Provider.of<Auth>(context).getHomePageTabFun(),

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
