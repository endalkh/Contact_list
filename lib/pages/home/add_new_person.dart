import 'package:flutter/material.dart';
import 'package:flutter_app/api/auth.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/constants/constant.dart';
import 'package:flutter_app/pages/appbar/AppBar.dart';
import 'package:flutter_app/pages/dialog/info_dialog.dart';
import 'package:flutter_app/pages/person_header/person_header.dart';
import 'package:flutter_app/pages/widgets/circularProgressBar.dart';
import 'package:flutter_app/state/app_state.dart';
import 'package:flutter_app/utilities/abstract_classes/confirmation_abstract.dart';
import 'package:flutter_app/utilities/validation/Validation.dart';
import 'package:provider/provider.dart';

class AddNewPersonScreen extends StatefulWidget{
  _AddNewPerson createState()=>_AddNewPerson();
}

class _AddNewPerson extends State<AddNewPersonScreen> implements ShouldImp{

  TextEditingController fNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController birthdayController = TextEditingController();
  TextEditingController addNoteController = TextEditingController();

  List<PhoneType> phoneType = PhoneType.getPhones();
  List<EmailType> emailType = EmailType.getEmails();

  List<DropdownMenuItem<PhoneType>> phoneDropdownMenuItems;
  List<DropdownMenuItem<EmailType>> emailDropdownMenuItems;
  PhoneType selectPhone;
  EmailType selectEmail;
  bool showError=false;

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      phoneDropdownMenuItems = phoneBuildDropdownMenuItems(phoneType);
      emailDropdownMenuItems = emailBuildDropdownMenuItems(emailType);
      selectPhone = phoneDropdownMenuItems[0].value;
      selectEmail = emailDropdownMenuItems[0].value;
      birthdayController.text='';
      Provider.of<Auth>(context,listen: false).setHasErrorFun("");
      Provider.of<Auth>(context, listen: false).setLoadingStateFun(false);
    });
    super.initState();
  }

  submitButton() {
    return
      Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child:  RawMaterialButton(
              onPressed: () {
                submitForm();
              },
              child: new Icon(
                Icons.arrow_forward,
                color: TRIAL_COLOR,
                size: 25.0,
              ),
              shape: new CircleBorder(),
              elevation: 2.0,
              fillColor:PRIMARY_COLOR,
              padding: const EdgeInsets.all(15.0),
            ),
          )


        ],
      );

  }
  submitForm(){
    if(
    validateEmailForAddPerson(emailController.text).toString().isNotEmpty==true||
    validateFirstNameForAddPerson(fNameController.text).toString().isNotEmpty==true||
    validateLastNameForAddPerson(lNameController.text).toString().isNotEmpty==true||
    validatePhoneForAddPerson(phoneController.text).toString().isNotEmpty==true

    ){
      setState(() {
        showError=true;
      });
    }
    else{
      setState(() {
        showError=false;
      });
      Provider.of<Auth>(context,listen: false).setLoadingStateFun(true);
      var token=Provider.of<Auth>(context,listen: false).getTokenFun();
      var addNewPerson =  addNewPersonApi(
         emailType: selectEmail.name,
          email: emailController.text,
          phoneType: selectPhone.name,
          phone: phoneController.text,
          fName: fNameController.text,
          lName: lNameController.text,
          birthday: birthdayController.text.isEmpty||birthdayController==null?null:DateTime.parse(birthdayController.text).toIso8601String(),
          token:token ,
          notes: addNoteController.text

      );
      addNewPerson.then((value) {
        Provider.of<Auth>(context,listen: false).setSuccessfullyRegisteredFun(true);

        Provider.of<Auth>(context,listen: false).setLoadingStateFun(false);
        InfoDialog(
            context: context,
            callback: _AddNewPerson(),
            title: Constant.success,
            type:Constant.success
        );
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PersonHeaderScreen(personId: value.id,)),
        );
      });

      addNewPerson.catchError((value) {
        Provider.of<Auth>(context,listen: false).setLoadingStateFun(false);
        Provider.of<Auth>(context,listen: false).setSuccessfullyRegisteredFun(false);

        Provider.of<Auth>(context,listen: false).setHasErrorFun(value.toString());
        InfoDialog(
            context: context,
            callback: _AddNewPerson(),
            title: Constant.error,
            type:Constant.error
        );



      });
    }


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
        new RawMaterialButton(
          onPressed: () {},
          child: new Icon(
            Icons.person_add,
            color: TRIAL_COLOR,
            size: 35.0,
          ),
          shape: new CircleBorder(),
          elevation: 2.0,
          fillColor:PRIMARY_COLOR,
          padding: const EdgeInsets.all(15.0),
        ),

        Padding(padding: EdgeInsets.all(5)),
        Text(
          'Personal Information',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
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
        showError==true && validateFirstNameForAddPerson(fNameController.text).toString().isNotEmpty==true?Text(validateFirstNameForAddPerson(fNameController.text),style: TextStyle(color: Colors.red),):Container(),
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
        showError==true && validateLastNameForAddPerson(lNameController.text).toString().isNotEmpty==true?Text(validateLastNameForAddPerson(lNameController.text),style: TextStyle(color: Colors.red),):Container(),

        Padding(padding: EdgeInsets.all(5)),
        Material(
          borderRadius: BorderRadius.circular(10.0),
          elevation: 12,
          child: TextFormField(
            controller: birthdayController,
            keyboardType: TextInputType.datetime,
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
                  initialDate:  DateTime.now().toUtc(),
                  firstDate: Constant.initialDate.dateTime.toUtc(),
                  lastDate: DateTime.now().toUtc()
              );
              birthdayController.text = date.toUtc().toIso8601String();
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
        showError==true && validatePhoneForAddPerson(phoneController.text).toString().isNotEmpty==true?Text(validatePhoneForAddPerson(phoneController.text),style: TextStyle(color: Colors.red),):Container(),

        Padding(padding: EdgeInsets.all(5)),
        emailTypeButton(),
        showError==true && validateEmailForAddPerson(emailController.text).toString().isNotEmpty==true?Text(validateEmailForAddPerson(emailController.text),style: TextStyle(color: Colors.red),):Container(),

        Padding(padding: EdgeInsets.all(5)),
      ],
    );
  }

  enterNotesTextFormField() {
    return Column(
      children: <Widget>[
        Text(
          'Additional Notes',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Flexible(
              child:Material(
                borderRadius: BorderRadius.circular(10.0),
                elevation: 12,
                child: TextFormField(
                  controller: addNoteController,
                  keyboardType: TextInputType.text,
                  maxLines: 3,
                  decoration: InputDecoration(
                    suffixIcon: Column(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.clear,color: Colors.red,),
                          onPressed: (){
                            addNoteController.clear();
                          },
                        )


                      ],
                    ),
                    hintText: "Enter Notes",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none),
                  ),
                ),
              ),
            ),



          ],
        )
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
                  keyboardType: TextInputType.phone,
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
                  keyboardType: TextInputType.emailAddress,
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


  @override
  Widget build(BuildContext context) {
      return WillPopScope(
        child:Consumer<Auth>(
          builder: (BuildContext context, Auth value, Widget child) =>
          value.getIsLoadingFun()==true?circularIndicator(context: context):
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

  @override
  void changer({context, id}) {
  }
  }

