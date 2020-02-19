import 'package:flutter/material.dart';
import 'package:flutter_app/api/auth.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/constants/constant.dart';
import 'package:flutter_app/pages/appbar/AppBar.dart';
import 'package:flutter_app/pages/widgets/circularProgressBar.dart';
import 'package:flutter_app/state/app_state.dart';
import 'package:flutter_app/utilities/validation/get_size.dart';
import 'package:provider/provider.dart';

class AddEmail extends StatefulWidget {
  String personId;

  AddEmail({@required this.personId});

  _AddEmail createState() => _AddEmail(personId);
}

class _AddEmail extends State<AddEmail> {
  List<EmailType> emailType = EmailType.getEmails();
  List<DropdownMenuItem<EmailType>> emailDropdownMenuItems;
  TextEditingController emailController = TextEditingController();

  EmailType selectEmail;
  String personId;

  _AddEmail(this.personId);
  bool isApiLoaded;

  @override
  void initState() {
    isApiLoaded=false;
    emailDropdownMenuItems = emailBuildDropdownMenuItems(emailType);
    selectEmail = emailDropdownMenuItems[0].value;
    super.initState();
  }

  @override
  void didChangeDependencies() {
 if(!isApiLoaded){
   Provider.of<Auth>(context,listen: false).setLoadingStateFun(false);
   Provider.of<Auth>(context).setHasErrorFun("");
   isApiLoaded=true;
 }

    super.didChangeDependencies();
  }
  submitForm() {
    print(personId);
    Provider.of<Auth>(context, listen: false).setLoadingStateFun(true);
    var token = Provider.of<Auth>(context, listen: false).getTokenFun();
    var addEmail = addEmailApi(
        token: token,
        personId: personId,
        type: emailType.toString(),
        address: emailController.text);
    addEmail.then((value) async {
      if(value==true) {
        Provider.of<Auth>(context, listen: false).setSuccessfullyRegisteredFun(true);
        Provider.of<Auth>(context, listen: false).setLoadingStateFun(false);
      }
    });

    addEmail.catchError((value) async {
      Provider.of<Auth>(context, listen: false).setLoadingStateFun(false);
      Provider.of<Auth>(context, listen: false)
          .setSuccessfullyRegisteredFun(false);

      Provider.of<Auth>(context, listen: false)
          .setHasErrorFun(value.toString());
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
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.check_circle,
                        color: Colors.blue,
                      ),
                      onPressed: () {
                        submitForm();
                      },
                    ),
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
    return Consumer<Auth>(
      builder: (BuildContext context, Auth value, Widget child) =>
          value.getIsLoadingFun() == true
              ? circularIndicator(context: context)
              :
                   SingleChildScrollView(
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
                                child: emailTypeButton(),
                              ),
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
                      ],
                    ),
                  ),

    );
  }
}
