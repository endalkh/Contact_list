import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/api/auth.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/constants/constant.dart';
import 'package:flutter_app/pages/appbar/AppBar.dart';
import 'package:flutter_app/pages/progress/circularProgressBar.dart';
import 'package:flutter_app/state/app_state.dart';
import 'package:flutter_app/utilities/validation/get_size.dart';
import 'package:provider/provider.dart';

class AddNewPersonScreen extends StatefulWidget{
  _AddNewPerson createState()=>_AddNewPerson();
}

class _AddNewPerson extends State<AddNewPersonScreen>{

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
  submitForm(){
    Provider.of<Auth>(context,listen: false).setLoadingStateFun(true);
    var token=Provider.of<Auth>(context,listen: false).getTokenFun();
    var addNewPerson =  addNewPersonApi(
      fName: fNameController.text,
      lName: lNameController.text,
      birthday: birthdayController.text,
      token:token ,

    );
    addNewPerson.then((value) async{
      Provider.of<Auth>(context,listen: false).setSuccessfullyRegisteredFun(true);

      Provider.of<Auth>(context,listen: false).setLoadingStateFun(false);
    });

    addNewPerson.catchError((value) async{
      Provider.of<Auth>(context,listen: false).setLoadingStateFun(false);
      Provider.of<Auth>(context,listen: false).setSuccessfullyRegisteredFun(false);

      Provider.of<Auth>(context,listen: false).setHasErrorFun(value.toString());




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
          value.getSuccessfullyRegisteredFun()==true?Text("Your data successfully registered!",
              style: TextStyle(color: Colors.green)):value.hasError.isNotEmpty==true?
          Text(value.getHasErrorFun(),
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
        width: getWidth(context),
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
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
      return WillPopScope(
        child:Consumer<Auth>(
          builder: (BuildContext context, Auth value, Widget child) =>
          value.getIsLoadingFun()==true?circularIndicator():
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
        ),
        onWillPop: (){
          Provider.of<Auth>(context,listen: false).setHasErrorFun("");
          Provider.of<Auth>(context,listen: false).setSuccessfullyRegisteredFun(false);
          return Future(()=>true);
        },
      );
    }
  }

