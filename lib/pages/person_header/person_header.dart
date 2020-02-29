import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/api/auth.dart';
import 'package:flutter_app/api/model/get_single_person.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/pages/appbar/AppBar.dart';
import 'package:flutter_app/pages/home/home.dart';
import 'package:flutter_app/pages/person_header/email_address.dart';
import 'package:flutter_app/pages/person_header/notes.dart';
import 'package:flutter_app/pages/person_header/phone_numbers.dart';
import 'package:flutter_app/pages/slider/slider.dart';
import 'package:flutter_app/pages/widgets/circularProgressBar.dart';
import 'package:flutter_app/state/app_state.dart';
import 'package:flutter_app/utilities/date_formater.dart';
import 'package:provider/provider.dart';


class PersonHeaderScreen extends StatefulWidget {
  final String personId;
  PersonHeaderScreen({Key key, @required this.personId}) : super(key: key);
  _PersonHeaderScreen createState()=>_PersonHeaderScreen(personId: personId,);
}

class _PersonHeaderScreen extends State<PersonHeaderScreen> {
final String personId;
_PersonHeaderScreen({Key key, @required this.personId});


@override
void initState() {
  Future.delayed(Duration.zero, () {
    Provider.of<Auth>(context,listen: false).setLoadingStateFun(false);
    Provider.of<Auth>(context,listen: false).setHasErrorFun("");
    Provider.of<Auth>(context,listen: false).setPersonHeaderTabFun(1);

  });
  super.initState();
}

pageTaped(page) {
    switch (page) {
      case 0:
        return Center(
          child: Note(personId: personId,)

        );
        break;
      case 1:
        return EmailAddress(personId: personId,);
        break;
      default:
        return PhoneNumber(personId: personId,);
    }
  }



  getTitle(context) {
    switch(Provider.of<Auth>(context,listen: false).getPersonHeaderTabFun()){
      case 0:
        return "Notes";
        break;
      case 1:
        return "Email Address";
        break;
      case 2:
        return "Phone Number";
        break;
      default:{
        print("someting wrong");
      }

    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        Navigator.push(context, SlideRightRoute(
            page: Home()
        ));
        return Future(()=>false);
      },
      child:Scaffold(
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
                  Text('Last Contacted: '+dateFormatter(snapshot.data.lastContact),
                    style: TextStyle(fontSize: 15),
                  ),
                  Divider(
                    
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
    else if (snapshot.hasError) {
      return Center(
        child: Text(
          snapshot.error.toString(), style: TextStyle(
            fontSize: 14, fontWeight: FontWeight.w400,
          color: Colors.red
        ),),
      );
    }
    return circularIndicator(context:context);
    }
        ),

            Expanded(
              child: Center(
                child: Container(
                    child: pageTaped(Provider.of<Auth>(context).getPersonHeaderTabFun(),
                ),
              ),
            )
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: Provider.of<Auth>(context,listen: false).getPersonHeaderTabFun(),
          selectedItemColor: PRIMARY_COLOR,
          items: [
            BottomNavigationBarItem(
              icon: new Icon(Icons.event_note),
              title: new Text('Notes'),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.mail),
              title: new Text('Email Address'),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.phone),
              title: new Text('Phone Number'),
            )
          ],
          onTap: (index) {
            Provider.of<Auth>(context,listen: false).setPersonHeaderTabFun(index);
          },
        ),
      ),
      );
  }
}
