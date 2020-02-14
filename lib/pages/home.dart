
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/api/auth.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/constants/constant.dart';
import 'package:flutter_app/pages/appbar/AppBar.dart';
import 'package:flutter_app/pages/drawer/navigation_drawer.dart';
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
  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();
  TextEditingController fNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
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
    selectEmail = emailDropdownMenuItems[0].value;
    super.initState();
  }
  @override
  void dispose() {
    Provider.of<Auth>(context,listen: false).set_hasError("");

  }
  submitForm(){
    Provider.of<Auth>(context,listen: false).setLoadingState(true);
    var token=Provider.of<Auth>(context,listen: false).get_token();
    var addNewPerson =  addNewPersonApi(
      fName: fNameController.text,
      lName: lNameController.text,
      birthday: birthdayController.text,
      token:token ,

    );
    addNewPerson.then((value) async{
  Provider.of<Auth>(context,listen: false).set_successfullyResgistered(true);

  Provider.of<Auth>(context,listen: false).setLoadingState(false);
    });

    addNewPerson.catchError((value) async{
      Provider.of<Auth>(context,listen: false).setLoadingState(false);
      Provider.of<Auth>(context,listen: false).set_successfullyResgistered(false);

      Provider.of<Auth>(context,listen: false).set_hasError(value.toString());




    });

  }

  List<DropdownMenuItem<PhoneType>> phoneBuildDropdownMenuItems(
      List phoneTypes) {
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

  List<DropdownMenuItem<EmailType>> emailBuildDropdownMenuItems(
      List emailTypes) {
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
                height: get_height(context),
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

  /*==== last  Contact on the second tap=======*/
  lastContact() {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(15),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(0),

                child: Container(
                  height: get_height(context),
                  child: ListView.builder(
                    itemBuilder: (context, position) {
                      return Container(
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Column(
                            children: [

                              Container(
                                height: 70,
                                child: ListTile(
                                  onTap: () => {
                                    Navigator.pushNamed(
                                        context, Constant.PERSON_HEADER)
                                  },
                                  leading: RoundedLetter(
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
                                        fontSize: 20),
                                  ),
                                  subtitle: Text(
                                    'Date(time) of last Contact',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 15,
                                        fontStyle: FontStyle.italic),
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
      ),
    );
  }

  /*==== Adding new Contact on the third tap=======*/
  addNewPerson() {
    return Consumer<Auth>(
        builder: (BuildContext context, Auth value, Widget child) =>
        value.get_IsLoading()==true?CircularIndicator():
        Scaffold(
          appBar: headerNav(title: Constant.ADD_NEW_PERSON),
       body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 10,
                    ),

                    Padding(
                      padding: EdgeInsets.all(10),
                      child: personalInformation(),
                    ),

                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10, right: 10),
                      child: contactInfo(),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10, right: 10, bottom: 5),
                      child: enterNotesTextFormField(),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: 150,
                      child: submitButton(),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              ),
            ],
          ),

        ),
      ),


    );
  }

  personalInformation() {
    return Column(
      children: [
        // Padding(padding: EdgeInsets.all(5)),
        CircleAvatar(
            radius: 40,
            backgroundImage: CachedNetworkImageProvider(Constant.images[0]),
            child: Container(
              margin: EdgeInsets.only(left: 50, top: 50),
              width: 25,
              height: 25,
              child: FloatingActionButton(
                onPressed: () => {},
                backgroundColor: PRIMARY_COLOR,
                child: Icon(
                  Icons.edit,
                  color: lightBG,
                ),
              ),
            )),

        Padding(padding: EdgeInsets.all(5)),
        Text(
          'Personal Information',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 10,),
        Consumer<Auth>(
          builder: (BuildContext context, Auth value, Widget child) =>
          value.get_successfullyResgistered()==true?Text("Your data successfully registered!",
              style: TextStyle(color: Colors.green)):value.hasError.isNotEmpty==true?
          Text(value.get_hasError(),
              style: TextStyle(color: Colors.red)):Container(),
        ),
        SizedBox(height: 10,),

        Material(
          borderRadius: BorderRadius.circular(10.0),
          elevation: 12,
          child: TextFormField(
            controller: fNameController,
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

             controller: lNameController,

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
                        borderSide: BorderSide.none),
                  ),

                  onTap: () async {
                    DateTime date = DateTime(1900);
                    FocusScope.of(context).requestFocus(new FocusNode());

                    date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100));
                    birthdayController.text = date.toIso8601String();
                  },
                ),

            ),
            Padding(padding: EdgeInsets.all(5)),



      ],
    );
  }

  contactInfo() {
    return Column(
      children: [
        Text(
          'Contact Information',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
        Padding(padding: EdgeInsets.all(5)),
        phoneNumberButton(),
        Padding(padding: EdgeInsets.all(5)),
        emailTypeButton(),
        Padding(padding: EdgeInsets.all(5)),
      ],
    );
  }

  contacts() {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 10,right: 10),
          child: Column(
            children: [
              SizedBox(height: 5,),
              Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: InkWell(
                    onTap: () =>
                        {Navigator.pushNamed(context, Constant.PERSON_HEADER)},
                    child: Container(
                      child: ListTile(
                          leading: RoundedLetter(
                            text: getRoundLetter("Anthony Doe"),
                            shapeType: ShapeType.circle,
                            shapeColor: PRIMARY_COLOR,
                            shapeSize: 40,
                            fontSize: 20,
                            borderWidth: 1,
                            borderColor: Color.fromARGB(255, 0, 0, 0),
                          ),
                          title:Text("Anthony Doe",style: TextStyle(
                            fontSize: 20,
                          ),),

                          subtitle: Text('Migrated From Phone Contacts',
                          style: TextStyle(fontSize: 15),
                          )),

                    ),
                  )),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Container(
                  child: ListTile(
                      leading: RoundedLetter(
                        text: getRoundLetter("Endalk Doe"),
                        shapeType: ShapeType.circle,
                        shapeColor: PRIMARY_COLOR,
                        shapeSize: 40,
                        fontSize: 20,
                        borderWidth: 1,
                        borderColor: Color.fromARGB(255, 0, 0, 0),
                      ),
                      title: Text('Endalk Doe',style: TextStyle(fontSize: 20)),
                      subtitle: Text('Migrated From Phone Contacts',style: TextStyle(fontSize: 15))),
                ),
              ),

              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Container(
                  child: ListTile(
                      leading:  RoundedLetter(
                        text: getRoundLetter("Jhon Doe"),
                        shapeType: ShapeType.circle,
                        shapeColor: PRIMARY_COLOR,
                        shapeSize: 40,
                        fontSize: 20,
                        borderWidth: 1,
                        borderColor: Color.fromARGB(255, 0, 0, 0),
                      ),
                      title: Text('Bonkers Doe',style: TextStyle(fontSize: 20)),
                      subtitle: Text('Migrated From Phone Contacts',style: TextStyle(fontSize: 15))),
                ),
              ),

              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Container(
                  child: ListTile(
                      leading:  RoundedLetter(
                        text: getRoundLetter("Caroline Doe"),
                        shapeType: ShapeType.circle,
                        shapeColor: PRIMARY_COLOR,
                        shapeSize: 40,
                        fontSize: 20,
                        borderWidth: 1,
                        borderColor: Color.fromARGB(255, 0, 0, 0),
                      ),
                      title: Text('Caroline Doe',style: TextStyle(fontSize: 20),),
                      subtitle: Text('Migrated From Phone Contacts',style: TextStyle(fontSize: 15))),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  enterNotesTextFormField() {
    return Column(
      children: [
        Text(
          'Additional Notes',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
        Padding(padding: EdgeInsets.all(5)),
        Container(
          height: 150,
          child: Material(
            borderRadius: BorderRadius.circular(10.0),
            elevation: 12,
            child: TextFormField(
              // controller: nameController,
              keyboardType: TextInputType.text,
              maxLines: 10,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.note, size: 20),
                hintText: "Enter Notes",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide.none),
              ),
            ),
          ),
        ),
      ],
    );
  }

  phoneNumberButton() {
    return Container(
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

                    hintText: "+1(424) 341-3346",

                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none),
                  ),
                ),
              )
            ],
          )),
    );
  }

  emailTypeButton() {
    return Container(
      height: 55,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Material(
          borderRadius: BorderRadius.circular(10.0),
          elevation: 12,
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
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
                        borderSide: BorderSide.none),
                  ),
                ),
              )
            ],
          )),
    );
  }

  submitButton() {
    return RaisedButton(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      onPressed: () {
        submitForm();
      },
      textColor: Colors.white,
      padding: EdgeInsets.all(0.0),
      child: Container(
        alignment: Alignment.center,
        width: get_width(context),
        decoration: BoxDecoration(
          color: PRIMARY_COLOR,
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          // gradient: LinearGradient(colors: [PRIMARY_COLOR, SECONDARY_COLOR]),
        ),
        padding: const EdgeInsets.all(15.0),
        child: Text(Constant.SUBMIT, style: TextStyle(fontSize: 12)),
      ),
    );
  }

  pageTaped(page) {
    switch (page) {
      case 0:
        return upcomingBirthDays();
        break;
      case 1:
        return lastContact();
        break;
      case 2:
        return contacts();
        break;
      default:
        return upcomingBirthDays();
    }
  }

  getTitle() {
    if (_page == 0)
      return "Upcoming Birthdays";
    else if (_page == 1)
      return "Last Contact";
    else
      return "Contacts";
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: headerNav(title: getTitle(), context: context),
      drawer: SideDrawer(),
      body: Container(
        child: Center(
          child: pageTaped(_page),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
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
          setState(() {
            _page = index;
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => addNewPerson()),
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
