
import 'package:flutter/material.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/constants/constant.dart';
import 'package:flutter_app/pages/logo/logo.dart';
import 'package:flutter_app/pages/widgets/back_button.dart';
import 'package:flutter_app/pages/widgets/cutter_ratio_container.dart';
import 'package:flutter_app/utilities/validation/Validation.dart';
import 'package:flutter_app/utilities/validation/get_height.dart';

class SignInPage extends StatefulWidget {
  SignInPage({Key key, this.title}) : super(key: key);

  final String title;


  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<SignInPage> {
    bool isLoading = false;
  bool showError=false;
  bool showBackendError=false;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _secureText = true;

  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
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
          child: Text('SIGN IN',style: TextStyle(fontSize: 12)),
        ),
      );
    }
  emailTextFormField() {
    var checkEmail=validateEmail(usernameController.text);
    return Column(
      children: <Widget>[
        Material(
          borderRadius: BorderRadius.circular(30.0),
          elevation: 12,
          child: TextFormField(
            controller: usernameController,
            keyboardType: TextInputType.text,

            decoration: InputDecoration(
              prefixIcon: Icon(Icons.email, size: 20),
              hintText: "Email",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none
              ),
            ),

          ),

        ),
        checkEmail.isNotEmpty && showError?

        Text(checkEmail,style: TextStyle(
            color: Colors.red
        )):Container()
      ],
    );
  }
  passwordTextFormField() {
    var checkPassword=validatePassword(passwordController.text);
    return Column(
      children: <Widget>[
        Material(
          borderRadius: BorderRadius.circular(30.0),
          elevation: 11,
          child: TextFormField(
            obscureText:_secureText ,
            controller: passwordController,
            keyboardType: TextInputType.text,

            decoration: InputDecoration(
              prefixIcon: Icon(Icons.lock, size: 20),
              hintText: "Password",
              suffixIcon: IconButton(
              onPressed: showHide,
             icon: Icon(_secureText
             ? Icons.visibility_off
                 : Icons.visibility),
    ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none
              ),
            ),
          ),
        ),
        checkPassword.isNotEmpty && showError?

        Text(checkPassword,style: TextStyle(
            color: Colors.red
        )):Container()
      ],
    );
  }
  forgetPassTextRow() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Text(
            "Forgot your password?",
            style: TextStyle(fontWeight: FontWeight.w400,fontSize: 12),
          ),
          SizedBox(
            width: 5,
          ),
          GestureDetector(
            onTap: () {
              print("Routing");
            },
            child: Text(
              "Recover",
              style: TextStyle(
                  fontWeight: FontWeight.w800, ),
            ),
          )
        ],
      ),
    );
  }
  signUpTextRow() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Don't have an account?",
            style: TextStyle(fontWeight: FontWeight.w400,fontSize: 12),
          ),
          SizedBox(
            width: 5,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(Constant.SIGN_UP);
              print("Routing to Sign up screen");
            },
            child: Text(
              "Sign up",
              style: TextStyle(
                  fontWeight: FontWeight.w800, fontSize:  17),
            ),
          )
        ],
      ),
    );
  }
  headerTextRow() {
    return Container(
      margin: EdgeInsets.only(left: 15.0),
      child: Row(
        children: <Widget>[
          Text(
            "LOGIN",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30),
            ),


        ],
      ),
    );
  }
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: SizedBox(),
                  ),
                  logo(),
                  SizedBox(
                    height: 20,
                  ),
                  headerTextRow(),
                  SizedBox(
                    height: 20,
                  ),
                  emailTextFormField(),
                  SizedBox(
                    height: 20,
                  ),
                  passwordTextFormField(),

                  SizedBox(
                    height: 20,
                  ),

                  forgetPassTextRow(),
                  SizedBox(
                    height: 10,
                  ),
                  button(),

                  SizedBox(
                    height: 10,
                  ),
                  signUpTextRow(),
                  Expanded(
                    flex: 1,
                    child: SizedBox(),
                  ),
                ],
              ),
            ),



            Positioned(top: 40, left: 0, child: backButton(context)),
            Positioned(
                top: -MediaQuery.of(context).size.height * .15,
                right: -MediaQuery.of(context).size.width * .4,
                child: CutterRatioContainer())
          ],
        ),
      );
    }


}
