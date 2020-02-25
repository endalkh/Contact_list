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

class RecoverPassword extends StatefulWidget {
  _RecoverPassword createState() => _RecoverPassword();
}
class _RecoverPassword extends State<RecoverPassword> {
  TextEditingController emailController = TextEditingController();

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
      ],
    );
  }

  button() {
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
        margin: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            SizedBox(
              height: 10,
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
                        fontSize: 17,
                      ),
                    ),
                  ),
                  Container(
                    child: emailTextFormField(),
                  ),
                ],
              ),
            ),
            Consumer<Auth>(
              builder: (BuildContext context, Auth value, Widget child) =>
              value.getHasErrorFun().toString().isNotEmpty==true?Text(value.getHasErrorFun(),
                  style: TextStyle(color: Colors.red)):Container(),
            ),
            SizedBox(height: 20,),
            Container(
              width: 200,
              child: button(),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: headerNav(context: context, title: Constant.RECOVERPASSWORD),
      body: Provider.of<Auth>(context).getIsLoadingFun() == true
          ? circularIndicator(context: context): resetPassword(),
    );
  }

  void submitForm() {
    Provider.of<Auth>(context,listen: false).setLoadingStateFun(true);

    var reset=resetPasswordApi(
        email: emailController.text
    );
    reset.then((val){
      Provider.of<Auth>(context,listen: false).setLoadingStateFun(false);
      Provider.of<Auth>(context,listen: false).setHasErrorFun(val.toString());
    });
    reset.catchError((val){
      Provider.of<Auth>(context,listen: false).setLoadingStateFun(false);
      Provider.of<Auth>(context,listen: false).setHasErrorFun(val.toString());
    });



  }
}
