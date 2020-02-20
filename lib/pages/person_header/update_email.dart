import 'package:flutter/material.dart';
import 'package:flutter_app/api/auth.dart';
import 'package:flutter_app/api/model/get_email.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/constants/constant.dart';
import 'package:flutter_app/pages/widgets/circularProgressBar.dart';
import 'package:flutter_app/state/app_state.dart';
import 'package:flutter_app/utilities/validation/get_size.dart';
import 'package:provider/provider.dart';

class UpdateEmail extends StatefulWidget {
  String id;

  UpdateEmail({@required this.id});

  _UpdateEmail createState() => _UpdateEmail(id);
}

class _UpdateEmail extends State<UpdateEmail> {
  TextEditingController emailController = TextEditingController();
  List<DropdownMenuItem<EmailType>> emailDropdownMenuItems;
  EmailType selectEmail;
  List<EmailType> emailType;
  String id;
  bool isApiLoaded;
  @override
  void initState() {
    isApiLoaded=false;
    super.initState();
  }
  _UpdateEmail(this.id) {
    this.id = id;
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if(!isApiLoaded){
      Provider.of<Auth>(super.context, listen: false).setLoadingStateFun(false);

      Provider.of<Auth>(context).setHasErrorFun("");

      emailType = EmailType.getEmails();
      emailDropdownMenuItems = emailBuildDropdownMenuItems(emailType);
      emailDropdownMenuItems = emailBuildDropdownMenuItems(emailType);

      Provider.of<Auth>(super.context, listen: false).setLoadingStateFun(true);
      Future<GetEmail> emailApi = getSingleEmailApi(
        token: Provider.of<Auth>(super.context,listen: false).getTokenFun(),
        id: id,
      );

      emailApi.then((val) async {

        Provider.of<Auth>(super.context, listen: false).setLoadingStateFun(false);
        Provider.of<Auth>(super.context,listen: false).setHasErrorFun("");

        switch (val.type) {
          case "Gmail":
            setState(() {
              selectEmail = emailDropdownMenuItems[0].value;
            });
            break;

          case "Icloud":
            setState(() {
              selectEmail = emailDropdownMenuItems[1].value;
            });
            break;

          case "yahoo":
            setState(() {
              selectEmail = emailDropdownMenuItems[2].value;
            });
            break;

          case "Hotbird":
            setState(() {
              selectEmail = emailDropdownMenuItems[3].value;
            });
            break;
          default:{
            setState(() {
              selectEmail = emailDropdownMenuItems[0].value;
            });
          }
        }
        emailController.text = val.address;
      });

      emailApi.catchError((val) {

        Provider.of<Auth>(super.context,listen: false).setLoadingStateFun(false);
        Provider.of<Auth>(super.context,listen: false).setHasErrorFun(val.toString());
      });

isApiLoaded=true;
    }

  }

  submitForm() {
    Provider.of<Auth>(context, listen: false).setLoadingStateFun(true);
    var token = Provider.of<Auth>(context, listen: false).getTokenFun();
    var updateEmail = updateEmailApi(
        token: token,
        id: id,
        type: emailType.toString(),
        address: emailController.text);
    updateEmail.then((value) async {
      if (value == true) {
        Provider.of<Auth>(context, listen: false)
            .setSuccessfullyRegisteredFun(true);
        Provider.of<Auth>(context, listen: false).setLoadingStateFun(false);
      }
    });

    updateEmail.catchError((value) async {
      Provider.of<Auth>(context, listen: false).setLoadingStateFun(false);
      Provider.of<Auth>(context, listen: false)
          .setSuccessfullyRegisteredFun(false);
      Provider.of<Auth>(context, listen: false)
          .setHasErrorFun(value.toString());
    });
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

  emailButton() {
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
                      icon: Icon(Icons.check_circle, color: Colors.blue),
                      onPressed: () {
                        submitForm();
                      },
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: IconButton(
                  icon: Icon(
                    Icons.cancel,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    Provider.of<Auth>(context, listen: false)
                        .setEditEmail(false);
                  },
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
    return  Consumer<Auth>(
        builder: (BuildContext context, Auth value, Widget child) =>
    value.getIsLoadingFun()==true?circularIndicator(context: context):SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: emailButton(),
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
    );
  }
}