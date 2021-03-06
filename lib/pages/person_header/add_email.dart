import 'package:flutter/material.dart';
import 'package:flutter_app/api/auth.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/constants/constant.dart';
import 'package:flutter_app/pages/dialog/info_dialog.dart';
import 'package:flutter_app/pages/widgets/circularProgressBar.dart';
import 'package:flutter_app/state/app_state.dart';
import 'package:flutter_app/utilities/abstract_classes/confirmation_abstract.dart';
import 'package:flutter_app/utilities/validation/Validation.dart';
import 'package:provider/provider.dart';

class AddEmail extends StatefulWidget {
  final String personId;
  AddEmail({@required this.personId});

  _AddEmail createState() => _AddEmail(personId);
}

class _AddEmail extends State<AddEmail> implements ShouldImp{
  List<DropdownMenuItem<EmailType>> emailDropdownMenuItems;
  TextEditingController emailController = TextEditingController();
  List<EmailType> emailType = EmailType.getEmails();
  EmailType selectEmail;
  String personId;
  bool showError=false;
  _AddEmail(this.personId);

  @override
  void initState() {

     Future.delayed(Duration.zero, () {
      emailDropdownMenuItems = emailBuildDropdownMenuItems(emailType);
      selectEmail = emailDropdownMenuItems[0].value;
      Provider.of<Auth>(context,listen: false).setLoadingStateFun(false);
      Provider.of<Auth>(context,listen: false).setHasErrorFun("");
    },
    );
    super.initState();
  }

  submitForm() {
    if (validateEmail(emailController.text)
        .toString()
        .isNotEmpty == true) {
      setState(() {
        showError = true;
      });
    }
    else {
      setState(() {
        showError=false;
      });
      Provider.of<Auth>(context, listen: false).setLoadingStateFun(true);
      Provider.of<Auth>(context, listen: false).setHasErrorFun("");
      var token = Provider.of<Auth>(context, listen: false).getTokenFun();
      var addEmail = addEmailApi(
          token: token,
          personId: personId,
          type: selectEmail.name,
          address: emailController.text
      );
      addEmail.then((value) {
        if (value == true) {
          Provider.of<Auth>(context, listen: false).setLoadingStateFun(false);
          Provider.of<Auth>(context, listen: false).setAddEmail(false);

        }
      });

      addEmail.catchError((value) {
        Provider.of<Auth>(context, listen: false).setLoadingStateFun(false);
        Provider.of<Auth>(context, listen: false)
            .setSuccessfullyRegisteredFun(false);
        InfoDialog(
            context: context,
            callback: _AddEmail(personId),
            title: value.toString(),
            type: Constant.error
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

  emailOnChangeDropdownItem(EmailType email) {
    setState(() {
      selectEmail = email;
    });
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


  @override
  Widget build(BuildContext context) {
    return Consumer<Auth>(
      builder: (BuildContext context, Auth value, Widget child) =>
          value.getIsLoadingFun() == true
              ? circularIndicator(context: context)
              :
                   SingleChildScrollView(
                    child: Column(
                      children: [
                        Text(
                          'Additional Email Address',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
                        ),
                        // SizedBox(
                        //   height: 5,
                        // ),
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
                                child: emailTypeButton(),
                              ),

                              showError==true && validateEmail(emailController.text).toString().isNotEmpty==true?Text(validateEmail(emailController.text),style: TextStyle(color: Colors.red),):Container(),
                              SizedBox(height: 10,),
                              value.getHasErrorFun().toString().isNotEmpty ==
                                      true
                                  ? Text(
                                      Provider.of<Auth>(context, listen: false)
                                          .getHasErrorFun(),
                                      style: TextStyle(
                                        color: Colors.red,
                                      ),
                                    )
                                  : Container(),
                            ],
                          ),
                        ),
                        submitButton(),
                      ],
                    ),
                  ),

    );
  }

  @override
  void changer({context, id}) {
  }
}
