import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/constants/constant.dart';
import 'package:flutter_app/pages/appbar/AppBar.dart';
import 'package:flutter_app/pages/appbar/subAppBar.dart';
import 'package:flutter_app/pages/drawer/navigation_drawer.dart';
import 'package:flutter_app/utilities/validation/get_size.dart';

class Home extends StatefulWidget {
  Dashboard createState() => Dashboard();
}

class Dashboard extends State<Home> {
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
    selectEmail = emailDropdownMenuItems[0].value;
    super.initState();
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
      backgroundColor: TRIAL_COLOR,
      appBar: SubHeaderNav(title: Constant.UPCOMING_BIRTHDAYS),
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
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Column(
                          children: [
                            Container(
                              height: 50,
                              child: ListTile(
                                onTap: () => {
                                  Navigator.pushNamed(
                                      context, Constant.PERSON_HEADER)
                                },
                                leading: CircleAvatar(
                                  radius: 25,
                                  backgroundImage: CachedNetworkImageProvider(
                                      Constant.images[0]),
                                ),
                                title: Text(
                                  'John Doe',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 25),
                                ),
                                subtitle: Text(
                                  'Date of Birth',
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
    );
  }

  /*==== last  Contact on the second tap=======*/
  lastContact() {
    return Scaffold(
      backgroundColor: TRIAL_COLOR,
      appBar: SubHeaderNav(title: Constant.LAST_CONTACT),
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
                                leading: CircleAvatar(
                                  radius: 25,
                                  backgroundImage: CachedNetworkImageProvider(
                                      Constant.images[0]),
                                ),
                                title: Text(
                                  'John Doe',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 25),
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
      )),
    );
  }

  /*==== Adding new Contact on the third tap=======*/
  addNewPerson() {
    return Scaffold(
      backgroundColor: TRIAL_COLOR,
      appBar: SubHeaderNav(title: Constant.ADD_NEW_PERSON),
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
            margin: EdgeInsets.only(left:50, top: 50),
            width: 25,
            height: 25,
            child: FloatingActionButton(
          onPressed: () => {
          },
          backgroundColor: PRIMARY_COLOR,
          child: Icon(
            Icons.edit,
            color: lightBG,
          ),
        ),
          ) 

        ),
        Padding(padding: EdgeInsets.all(5)),
        Text(
          'Personal Information',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
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
        Row(
          children: [
            Container(
              // margin: EdgeInsets.only(right: 10),
              width: 200,
              child: Material(
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
            ),
            Padding(padding: EdgeInsets.all(5)),
            Container(
              // margin: EdgeInsets.only(left: 200),
              width: 150,
              child: Material(
                borderRadius: BorderRadius.circular(10.0),
                elevation: 12,
                child: TextFormField(
                  // controller: birthdayController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person, size: 20),
                    hintText: "Gender",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none),
                  ),
                ),
              ),
            ),
          ],
        ),
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
      backgroundColor: TRIAL_COLOR,
      appBar: SubHeaderNav(title: 'Contacts'),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 35),
          child: Column(
            children: [
              Padding(padding: EdgeInsets.all(5)),
              Container(
                width: 40,
                child: Card(
                  child: Text(
                    'A',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: InkWell(
                    onTap: () =>
                        {Navigator.pushNamed(context, Constant.PERSON_HEADER)},
                    child: Container(
                      height: 60,
                      child: ListTile(
                          leading: CircleAvatar(
                            radius: 17,
                            backgroundImage:
                                CachedNetworkImageProvider(Constant.images[0]),
                          ),
                          title: Text('Anthony Doe'),
                          subtitle: Text('Migrated From Phone Contacts')),
                    ),
                  )),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Container(
                  height: 60,
                  child: ListTile(
                      leading: CircleAvatar(
                        radius: 17,
                        backgroundImage:
                            CachedNetworkImageProvider(Constant.images[0]),
                      ),
                      title: Text('Anthony Doe'),
                      subtitle: Text('Migrated From Phone Contacts')),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Container(
                  height: 60,
                  child: ListTile(
                      leading: CircleAvatar(
                        radius: 17,
                        backgroundImage:
                            CachedNetworkImageProvider(Constant.images[0]),
                      ),
                      title: Text('Albert Einstine'),
                      subtitle: Text('Saved here')),
                ),
              ),
              Container(
                width: 40,
                child: Card(
                  child: Text(
                    'B',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Container(
                  height: 60,
                  child: ListTile(
                      leading: CircleAvatar(
                        radius: 17,
                        backgroundImage:
                            CachedNetworkImageProvider(Constant.images[0]),
                      ),
                      title: Text('Bonkers Doe'),
                      subtitle: Text('Migrated From Phone Contacts')),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Container(
                  height: 60,
                  child: ListTile(
                      leading: CircleAvatar(
                        radius: 17,
                        backgroundImage:
                            CachedNetworkImageProvider(Constant.images[0]),
                      ),
                      title: Text('Bovelier Einstine'),
                      subtitle: Text('Saved here')),
                ),
              ),
              Container(
                width: 40,
                child: Card(
                  child: Text(
                    'C',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Container(
                  height: 60,
                  child: ListTile(
                      leading: CircleAvatar(
                        radius: 17,
                        backgroundImage:
                            CachedNetworkImageProvider(Constant.images[0]),
                      ),
                      title: Text('Caroline Doe'),
                      subtitle: Text('Migrated From Phone Contacts')),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Container(
                  height: 60,
                  child: ListTile(
                      leading: CircleAvatar(
                        radius: 17,
                        backgroundImage:
                            CachedNetworkImageProvider(Constant.images[0]),
                      ),
                      title: Text('Caroline Doe'),
                      subtitle: Text('Migrated From Phone Contacts')),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Container(
                  height: 60,
                  child: ListTile(
                      leading: CircleAvatar(
                        radius: 17,
                        backgroundImage:
                            CachedNetworkImageProvider(Constant.images[0]),
                      ),
                      title: Text('Caroline Doe'),
                      subtitle: Text('Migrated From Phone Contacts')),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Container(
                  height: 60,
                  child: ListTile(
                      leading: CircleAvatar(
                        radius: 17,
                        backgroundImage:
                            CachedNetworkImageProvider(Constant.images[0]),
                      ),
                      title: Text('Caroline Doe'),
                      subtitle: Text('Migrated From Phone Contacts')),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Container(
                  height: 60,
                  child: ListTile(
                      leading: CircleAvatar(
                        radius: 17,
                        backgroundImage:
                            CachedNetworkImageProvider(Constant.images[0]),
                      ),
                      title: Text('Caroline Doe'),
                      subtitle: Text('Migrated From Phone Contacts')),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Container(
                  height: 60,
                  child: ListTile(
                      leading: CircleAvatar(
                        radius: 17,
                        backgroundImage:
                            CachedNetworkImageProvider(Constant.images[0]),
                      ),
                      title: Text('Cantona Einstine'),
                      subtitle: Text('Saved here')),
                ),
              ),
              Container(
                width: 40,
                child: Card(
                  child: Text(
                    'D',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Container(
                  height: 60,
                  child: ListTile(
                      leading: CircleAvatar(
                        radius: 17,
                        backgroundImage:
                            CachedNetworkImageProvider(Constant.images[0]),
                      ),
                      title: Text('Dunhan Doe'),
                      subtitle: Text('Migrated From Phone Contacts')),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Container(
                  height: 60,
                  child: ListTile(
                      leading: CircleAvatar(
                        radius: 17,
                        backgroundImage:
                            CachedNetworkImageProvider(Constant.images[0]),
                      ),
                      title: Text('Debra Einstine'),
                      subtitle: Text('Saved here')),
                ),
              ),
              Container(
                width: 40,
                child: Card(
                  child: Text(
                    'E',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Container(
                  height: 60,
                  child: ListTile(
                      leading: CircleAvatar(
                        radius: 17,
                        backgroundImage:
                            CachedNetworkImageProvider(Constant.images[0]),
                      ),
                      title: Text('Einstine Albert'),
                      subtitle: Text('Migrated From Phone Contacts')),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Container(
                  height: 60,
                  child: ListTile(
                      leading: CircleAvatar(
                        radius: 17,
                        backgroundImage:
                            CachedNetworkImageProvider(Constant.images[0]),
                      ),
                      title: Text('Equalia James'),
                      subtitle: Text('Saved here')),
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
                    hintText: "+251901959195",
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
        Navigator.pushNamed(context, Constant.HOME);
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

  @override
  Widget build(BuildContext context) {
    return 
       Scaffold(
        appBar: headerNav(title: Constant.DASHBOARD, context: context),
        drawer: SideDrawer(),
        body: Container(
          child: Center(
            child: pageTaped(_page),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _page,
          unselectedItemColor: Colors.black26,
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
