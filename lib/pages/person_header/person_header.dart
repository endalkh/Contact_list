import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/constants/constant.dart';
import 'package:flutter_app/pages/appbar/AppBar.dart';
import 'package:flutter_app/pages/appbar/subAppBar.dart';
import 'package:flutter_app/pages/drawer/navigation_drawer.dart';
import 'package:flutter_app/utilities/validation/get_size.dart';

class PersonHeaderFun extends StatefulWidget {
  _PersonHeaderFun createState() =>_PersonHeaderFun();
}
class _PersonHeaderFun extends State<PersonHeaderFun>{
  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController birthdayController = TextEditingController();




  /*==== upcoming Birthdays   on the first tap=======*/
  notes(){
    return Scaffold(

      body:SingleChildScrollView(
        child: Column(
          children: <Widget>[

            Padding(
              padding: EdgeInsets.all(2.0),
              child:Container(
                height: get_height(context),
                child: ListView.builder(
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex:1,
                                child:ListTile(
                                  title:  ExpansionTile(
                                    title:  Text(Constant.PASSWORDRESETDESC.substring(1,36),),
                                    children: <Widget>[
                                      ListTile(
                                        leading: Icon(Icons.delete),
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.edit),
                                      ),
                                  ],
                                  ),
                                )
                              ),

                            ],
                          )
//
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
//        )
        ),

      ),
    );


  }


  pageTaped(page){
    switch(page){
      case 0:
        return Text("hello Notes");
        break;
      case 1:
        return Text("hello conact list");
        break;
      default:
        return Text("hello person setting");

    }
  }
getTitle(){
    if(_page==0)
      return "Notes";
    else if(_page==1)
      return "Contact Information";
      else
        return "Person Setting";

    }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: headerNav(context: context,title: getTitle()),
          body: Column(
            children: <Widget>[

              SizedBox(height: 10,),
            Material(
              child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  child:Column(
//                    crossAxisAlignment: CrossAxisAlignment.center,
//                    mainAxisAlignment: MainAxisAlignment.center,

                    children: <Widget>[
                      Row(
                        mainAxisSize: MainAxisSize.max,
//                        mainAxisAlignment: MainAxisAlignment.center,
//                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                        Expanded(
                          flex:6,
                          child: Text("Name",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w900
                            ),

                          ),
                        ),

                          Expanded(
                            flex:8,
                            child: Text("Endalk Belete"),
                          )
                        ],
                      ),
                      Divider(),
                      Row(
                        mainAxisSize: MainAxisSize.max,
//                        mainAxisAlignment: MainAxisAlignment.center,
//                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            flex:6,
                            child: Text("BirthDay",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900
                              ),

                            ),
                          ),
                          Expanded(
                            flex:8,
                            child: Text("1995-01-20"),
                          )
                        ],
                      ),
                      Divider(),
                Row(
                mainAxisSize: MainAxisSize.max,
//                        mainAxisAlignment: MainAxisAlignment.center,
//                        crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex:6,
                    child: Text("Last Contact",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900
                      ),

                    ),
                  ),
                  Expanded(
                    flex:8,
                    child: Text("1995-01-20"),
                  )
                ],
              ),
                    ],
                  )

              ),
            ),
              Divider(thickness: 3,),
              SizedBox(height: 10,),

              Expanded(
                child:  Center(
                  child:Container(
                    child: Center(
                      child:pageTaped(_page),
                    ),
                  ),

                ),
              )
            ],
          ),


          bottomNavigationBar:BottomNavigationBar(
            currentIndex: _page,
            selectedItemColor: PRIMARY_COLOR,
            items:[
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
          )


      ),
    );

  }



}
