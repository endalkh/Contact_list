import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/constants/constant.dart';
import 'package:flutter_app/utilities/validation/get_size.dart';

class PersonalSetting extends StatefulWidget{
  _PersonalSetting createState()=>_PersonalSetting();
}
class _PersonalSetting extends State<PersonalSetting>{
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController birthdayController = TextEditingController();
  List<DropdownMenuItem<PhoneType>> phoneDropdownMenuItems;
  List<DropdownMenuItem<EmailType>> emailDropdownMenuItems;
  PhoneType selectPhone;
  EmailType selectEmail;
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
        width: getWidth(context),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          color: PRIMARY_COLOR,
          // gradient: LinearGradient(colors: [PRIMARY_COLOR, SECONDARY_COLOR]),
        ),
        padding: const EdgeInsets.all(15.0),
        child: Text(Constant.SUBMIT, style: TextStyle(fontSize: 12)),
      ),
    );
  }

  deleteButton() {
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
        width: getWidth(context),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          color: Colors.red,
          // gradient: LinearGradient(colors: Colors.red),
        ),
        padding: const EdgeInsets.all(15.0),
        child: Text('Delete', style: TextStyle(fontSize: 12)),
      ),
    );
  }

  get phoneOnChangeDropdownItem => null;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return   Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(15),
          child: Column(
            children: [
              Text(
                'Settings',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
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
              Container(
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
                              hintText: "JohnDoe12345@gmail.com",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  borderSide: BorderSide.none),
                            ),
                          ),
                        )
                      ],
                    )),
              ),
              Padding(padding: EdgeInsets.only(top: 10)),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child:Container(
                      width: 100,
                      child: deleteButton(),
                    ),
                  ),
                  SizedBox(width: 10,),
                  Expanded(
                    flex: 1,
                    child: Container(
                      width: 210,
                      child: submitButton(),
                    ),
                  )

                ],
              )
            ],
          ),
        ),
      ),
    );;
  }

}