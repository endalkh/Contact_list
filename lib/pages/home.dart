import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/constants/constant.dart';
import 'package:flutter_app/pages/appbar/AppBar.dart';
import 'package:flutter_app/pages/appbar/subAppBar.dart';
import 'package:flutter_app/pages/drawer/navigation_drawer.dart';
import 'package:flutter_app/pages/progress/circularProgressBar.dart';
import 'package:flutter_app/utilities/validation/get_size.dart';

class Home extends StatefulWidget {
  Dashboard createState() =>Dashboard();
}
class Dashboard extends State<Home>{
  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController birthdayController = TextEditingController();

  List<PhoneType> phoneType = PhoneType.getPhones();
  List<EmailType> emailType = EmailType.getEmails();

  List<DropdownMenuItem<PhoneType>> phoneDropdownMenuItems;
  List<DropdownMenuItem<EmailType>> emailDropdownMenuItems;
  PhoneType selectPhone;
  EmailType selectEmail;

  @override
  void initState() {
    phoneDropdownMenuItems = phoneBuildDropdownMenuItems(phoneType);
    emailDropdownMenuItems = emailBuildDropdownMenuItems(emailType);
    selectPhone = phoneDropdownMenuItems[0].value;
    selectEmail=emailDropdownMenuItems[0].value;
    super.initState();
  }

  List<DropdownMenuItem<PhoneType>> phoneBuildDropdownMenuItems(List phoneTypes) {
    List<DropdownMenuItem<PhoneType>> items = List();
    for (PhoneType phoneType in phoneTypes) {
      items.add(
        DropdownMenuItem(
          value: phoneType,
          child: Text(phoneType.name),
        ),
      );
    }
    return items;
  }

  List<DropdownMenuItem<EmailType>> emailBuildDropdownMenuItems(List emailTypes) {
    List<DropdownMenuItem<EmailType>> items = List();
    for (EmailType emailType in emailTypes) {
      items.add(
        DropdownMenuItem(
          value: emailType,
          child: Text(emailType.name),
        ),
      );
    }
    return items;
  }

  phoneOnChangeDropdownItem(PhoneType phone) {
    setState(() {
      selectPhone = phone;
    });
  }
  emailOnChangeDropdownItem(EmailType email) {
    setState(() {
      selectEmail = email;
    });
  }


  /*==== upcoming Birthdays   on the first tap=======*/
  upcomingBirthDays(){
  return Scaffold(
    appBar:  SubHeaderNav(title: Constant.UPCOMING_BIRTHDAYS),

    body:SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(14),
      child:Container(
            height: get_height(context),
            child: ListView.builder(
              itemCount: 4,
              itemBuilder: (context, index) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: <Widget>[
                    Expanded(
                      flex:1,
                      child:Text(
                        "Jhon Tomson $index",
                        style: TextStyle(
                            fontSize: 22.0,
                        color: COLOR_LINK
                        ),

                      ),
                    ),
                        Expanded(
                          flex:1,
                          child:Text(
                            "Jan 20", style: TextStyle(fontSize: 17.0),
//
                          ),
                        )
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


  /*==== last  Contact on the second tap=======*/
  lastContact(){
    return Scaffold(
      appBar: SubHeaderNav(title: Constant.LAST_CONTACT),

      body:SingleChildScrollView(

        child: Column(
          children: <Widget>[
        Padding(
        padding: EdgeInsets.only(
          top: 14,
          bottom: 14
        ),
            child:Container(
              height: get_height(context),
              child: ListView.builder(
                itemBuilder: (context, position) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
//                      child: Text(position.toString(), style: TextStyle(fontSize: 22.0),),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex:1,
                              child:Text(
                                "Old Contact Smith",
                                style: TextStyle(
                                    fontSize: 22.0,
                                    color: COLOR_LINK
                                ),
                              ),
                            ),
                            Expanded(
                              flex:1,
                              child:Text(
                                "1 months ago", style: TextStyle(fontSize: 17.0),
//
                              ),
                            )
                          ],
                        )
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

 /*==== Adding new Contact on the third tap=======*/
  addNewPerson(){
    return Scaffold(
      appBar: SubHeaderNav(title: Constant.ADD_NEW_PERSON),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 10,),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child:nameTextFormField(),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child:BirthDatePicker(),
                  ),
                  SizedBox(height: 10,),
                  contactInfo(),
                  SizedBox(height: 10,),
                  submitButton(),


                ],

              ),
            ),

          ],
        ),
      ),
    );
  }
  nameTextFormField() {

//    var checkEmail=validateEmail(usernameController.text);
    return Column(
      children: <Widget>[
        Material(
          borderRadius: BorderRadius.circular(10.0),
          elevation: 12,
          child: TextFormField(
            controller: nameController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.person, size: 20),
              hintText: "Name",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none
              ),
            ),

          ),

        ),

      ],
    );
  }
  BirthDatePicker() {
    return Column(
      children: <Widget>[
        Material(
          borderRadius: BorderRadius.circular(10.0),
          elevation: 12,
          child: TextFormField(
            controller: birthdayController,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.timer, size: 20),
              hintText: "Date of Birth",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none
              ),
            ),
            onTap: () async{
    DateTime date = DateTime(1900);
    FocusScope.of(context).requestFocus(new FocusNode());

    date = await showDatePicker(
    context: context,
    initialDate:DateTime.now(),
    firstDate:DateTime(1900),
    lastDate: DateTime(2100));
    birthdayController.text = date.toIso8601String();
    }

    ,
    ),
    ),
    ]
    );

  }

  contactInfo(){
    return Material(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15),
        child:Column(
          children: <Widget>[
            Text(Constant.CONTACT_INFO,
              style: TextStyle(
                color: PRIMARY_COLOR,
                  fontSize: Constant.fontSize(Constant.L),
                  fontWeight: FontWeight.w900
              ),

            ),

            SizedBox(height: 15,),
            phoneNumberButton(),
            SizedBox(height: 15,),
            EmailTypeButton(),

            SizedBox(height: 15,),
            enterNotes(),

          ],
        ),
        ),
      ),
    );
  }
  enterNotesTextFormField() {

//    var checkEmail=validateEmail(usernameController.text);
    return Column(
      children: <Widget>[
        Material(
          borderRadius: BorderRadius.circular(10.0),
          elevation: 12,
          child: TextFormField(
            controller: nameController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.note, size: 20),
              hintText: "Enter Notes",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none
              ),
            ),

          ),

        ),

      ],
    );
  }
  enterNotes(){
    return Material(
        child: Padding(
          padding: EdgeInsets.all(1.0),
          child:Column(
            children: <Widget>[
              Text(Constant.NOTES,
                style: TextStyle(
                    color: PRIMARY_COLOR,
                    fontSize: Constant.fontSize(Constant.L),
                  fontWeight: FontWeight.w900

                ),

              ),
              SizedBox(height: 15,),
              enterNotesTextFormField(),


            ],
          ),
        ),

    );
  }
  phoneNumberButton() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
            child:  Material(
              borderRadius: BorderRadius.circular(10.0),
              elevation: 12,
              child: Row(
                children: <Widget>[
           Expanded(
             flex: 2,
             child:Container(
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.center,
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: <Widget>[

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
                        hintText: "+251901959195",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: BorderSide.none
                        ),
                      ),

                    ),
                  )
                ],
              )

      ),
    );
  }
  EmailTypeButton() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child:  Material(
          borderRadius: BorderRadius.circular(10.0),
          elevation: 12,
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 2,
                child:Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[

                      DropdownButton(
                        value: selectEmail,
                        items: emailDropdownMenuItems,
                        onChanged: emailOnChangeDropdownItem,
                      ),

                    ],
                  ),

                ),
              ),
              Expanded(
                flex: 4,
                child: TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: "example@example.com",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none
                    ),
                  ),

                ),
              )
            ],
          )

      ),
    );
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
        width:  get_width(context),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          gradient: LinearGradient(
              colors: [PRIMARY_COLOR,SECONDARY_COLOR]
          ),
        ),
        padding: const EdgeInsets.all(15.0),
        child: Text(Constant.SUBMIT,style: TextStyle(fontSize: 12)),
      ),
    );
  }
 pageTaped(page){
 switch(page){
   case 0:
     return upcomingBirthDays();
     break;
   case 1:
     return lastContact();
     break;
   default:
     return addNewPerson();

 }
 }

@override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: headerNav(title: Constant.DASHBOARD,context: context),
        drawer: SideDrawer(),
        body: Container(
        child: Center(
         child:pageTaped(_page),
        ),
      ),
        bottomNavigationBar:  CurvedNavigationBar(
          backgroundColor: PRIMARY_COLOR,
          key: _bottomNavigationKey,
          index: 0,
          height: 50.0,
          items: <Widget>[
            Icon(Icons.event, size: 20),
            Icon(Icons.contact_mail, size: 20),
            Icon(Icons.add, size: 20),
          ],
          color: COLOR_CREAM,
          buttonBackgroundColor: Colors.white,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 600),
            onTap: (index) {
              setState(() {
                _page = index;
              });

          },
        ),
      ),
    );

  }



}
