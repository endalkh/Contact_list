import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/constants/constant.dart';
import 'package:flutter_app/pages/appbar/AppBar.dart';
import 'package:flutter_app/pages/appbar/subAppBar.dart';
import 'package:flutter_app/utilities/validation/get_size.dart';

class RecoverPassword extends StatefulWidget{
  _RecoverPassword createState()=>_RecoverPassword();
}
class _RecoverPassword extends State<RecoverPassword>{

  TextEditingController emailController = TextEditingController();
  emailTextFormField() {
//    var checkEmail=validateEmail(usernameController.text);
    return Column(
      children: <Widget>[
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
                  borderSide: BorderSide.none
              ),
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
        Navigator.pushNamed(context, Constant.HOME);
      },
      textColor: Colors.white,
      padding: EdgeInsets.all(0.0),
      child: Container(
        alignment: Alignment.center,
        width:  get_width(context),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          gradient: LinearGradient(
              colors: [PRIMARY_COLOR,SECONDARY_COLOR]
          ),
        ),
        padding: const EdgeInsets.all(15.0),
        child: Text(Constant.RECOVERPASSWORD,style: TextStyle(fontSize: 12)),
      ),
    );
  }
  resetPassword(){
    return Scaffold(
      appBar: SubHeaderNav(context: context,title:Constant.RESETPASSWORD,),
      body:  Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
      child:Column(
//        crossAxisAlignment: CrossAxisAlignment.t,
//        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          SizedBox(height: 10,),
          Text(
            Constant.PASSWORDRESETDESC,
            style: TextStyle(
              fontSize: Constant.fontSize(Constant.L),
            ),

          ),



          SizedBox(height: 40,),
          emailTextFormField(),
          SizedBox(height: 10,),
          button(),

        ],
      ),
      ),
    );


  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: headerNav(context: context,title: Constant.RECOVERPASSWORD),
      body: resetPassword(),
    );
  }

}