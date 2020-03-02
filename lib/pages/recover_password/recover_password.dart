import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/api/auth.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/constants/constant.dart';
import 'package:flutter_app/pages/appbar/AppBar.dart';
import 'package:flutter_app/pages/widgets/circularProgressBar.dart';
import 'package:flutter_app/state/app_state.dart';
import 'package:flutter_app/utilities/validation/get_size.dart';
import 'package:provider/provider.dart';

import '../../utilities/validation/Validation.dart';

class RecoverPassword extends StatefulWidget {
  _RecoverPassword createState() => _RecoverPassword();
}

class _RecoverPassword extends State<RecoverPassword> {
  TextEditingController emailController = TextEditingController();
  String message;
  bool showError = false;
  String emailError = "";

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      Provider.of<Auth>(context, listen: false).setHasErrorFun("");
      message = "";
    });

    super.initState();
  }

  emailTextFormField() {
    return Column(
      children: [
        Material(
          borderRadius: BorderRadius.circular(30.0),
          elevation: 12,
          child: TextFormField(
            controller: emailController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.email, size: 20),
              hintText: "Email@example.com",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none),
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        (showError == true && emailError.isNotEmpty)
            ? Text(emailError, style: TextStyle(color: Colors.red))
            : Container(),
      ],

    );
  }

  button() {
    return RaisedButton(
      elevation: 5,
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
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            color: PRIMARY_COLOR),
        padding: const EdgeInsets.all(15.0),
        child: Text(Constant.RECOVERPASSWORD, style: TextStyle(fontSize: 12)),
      ),
    );
  }

  resetPassword() {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Text("Reset your Password",
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 26
            ),),
        Card(
            shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20.0),
  ),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Text(
                        Constant.PASSWORDRESETDESC,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    emailTextFormField(),
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.only(left: 25, right: 20),
                child: message.isNotEmpty == true
                    ? Text(message, style: TextStyle(color: Colors.green))
                    : Container(),
              ),

              Consumer<Auth>(
                builder: (BuildContext context, Auth value, Widget child) =>
                    value.getHasErrorFun().toString().isNotEmpty == true
                        ? Text(value.getHasErrorFun(),
                            style: TextStyle(color: Colors.red))
                        : Container(),
              ),
              // SizedBox(height: 15,),
              Container(
                width: 200,
                child: button(),
              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
          ]
        ),

        margin: EdgeInsets.all(20),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: headerNav(context: context, title: Constant.RECOVERPASSWORD),
      body: Provider.of<Auth>(context).getIsLoadingFun() == true
          ? circularIndicator(context: context)
          : resetPassword(),
    );
  }

  void submitForm() {
    setState(() {
      showError = true;
      emailError = validateEmail(emailController.text);
    });

    if (emailError.isEmpty && showError) {
      Provider.of<Auth>(context, listen: false).setLoadingStateFun(true);

      var reset = resetPasswordApi(
          email: emailController.text
      );
      reset.then((val) {
        Provider.of<Auth>(context, listen: false).setLoadingStateFun(false);
        setState(() {
          message =
          "A password reset email has been sent. Please check your email.";
        });
      });
      reset.catchError((val) {
        Provider.of<Auth>(context, listen: false).setLoadingStateFun(false);
        Provider.of<Auth>(context, listen: false).setHasErrorFun(
            val.toString());
        setState(() {
          message = "";
        });
      });
    }
  }
}
