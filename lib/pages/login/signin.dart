import 'package:flutter/material.dart';
import 'package:flutter_app/api/auth.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/constants/constant.dart';
import 'package:flutter_app/pages/SharedPreference/shared_preference.dart';
import 'package:flutter_app/pages/home/home.dart';
import 'package:flutter_app/pages/logo/logo.dart';
import 'package:flutter_app/pages/recover_password/recover_password.dart';
import 'package:flutter_app/pages/register/signup.dart';
import 'package:flutter_app/pages/slider/slider.dart';
import 'package:flutter_app/pages/widgets/circularProgressBar.dart';
import 'package:flutter_app/pages/widgets/clip_shape.dart';
import 'package:flutter_app/state/app_state.dart';
import 'package:flutter_app/utilities/validation/Validation.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {
  final String title;
  SignInPage({this.title});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<SignInPage> {
  bool isLoading = false;
  bool showError = false;
  bool showBackendError = false;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _secureText = true;
  bool isDark = false;
  String emailError = "",
      passwordError = "";


  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }




  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  submitForm() async {
    setState(() {
      showError = true;
      emailError = validateEmail(usernameController.text);
      passwordError = validatePassword(passwordController.text);
    });

    if (emailError.isEmpty && passwordError.isEmpty && showError) {
      Provider.of<Auth>(context, listen: false).setLoadingStateFun(true);
      var _loginModel = loginApi(
        userId: usernameController.text,
        password: passwordController.text,
        context: context,
      );
      _loginModel.then((value) async {
        savePref(
          email: value.email,
          refreshToken: value.refreshToken,
          accessToken: value.accessToken,
        );
        Provider.of<Auth>(context, listen: false).setLoadingStateFun(false);
        Navigator.push(context, SlideLeftRoute(
            page: Home()
        ));
      });

      _loginModel.catchError((value) async {
        Provider.of<Auth>(context, listen: false).setHasErrorFun(value);
        Provider.of<Auth>(context, listen: false).setLoadingStateFun(false);
      });
    }
    else {
      Provider.of<Auth>(context, listen: false).setHasErrorFun("");
    }
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
                size: 35.0,
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


  emailTextFormField() {
    return Column(
      children: <Widget>[
        Material(
          borderRadius: BorderRadius.circular(30.0),
          elevation: 12,
          child: TextFormField(
            controller: usernameController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.email,
                size: 20,
                color: PRIMARY_COLOR,
              ),
              hintText: "Email",
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

  passwordTextFormField() {
    return Column(
      children: <Widget>[
        Material(
          borderRadius: BorderRadius.circular(30.0),
          elevation: 11,
          child: TextFormField(
            obscureText: _secureText,
            controller: passwordController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.lock, size: 20, color: PRIMARY_COLOR),
              hintText: "Password",
              suffixIcon: IconButton(
                onPressed: showHide,
                icon:
                Icon(_secureText ? Icons.visibility_off : Icons.visibility),
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none),
            ),
          ),
        ),
        (showError == true && passwordError.isNotEmpty)
            ? Text(passwordError, style: TextStyle(color: Colors.red))
            : Container(),

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
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
          ),
          SizedBox(
            width: 5,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context, SlideLeftRoute(
                  page: RecoverPassword()
              ));
            },
            child: Text(
              "Recover",
              style: TextStyle(
                fontWeight: FontWeight.w800,

              ),
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
        children: [
          Text(
            "Don't have an account?",
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),

          ),
          SizedBox(
            width: 5,
          ),
          GestureDetector(
            onTap: () {
              Provider.of<Auth>(context, listen: false).setHasErrorFun("");
              Navigator.push(context, SlideLeftRoute(
                  page: SignUpPage()
              ));
            },
            child: Text(
              "Sign up",
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 17),

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
            "Login",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),

          ),
        ],
      ),
    );
  }

  forms() {
    return Padding(
      padding: EdgeInsets.all(20),
      child:Column(
        children: <Widget>[

          SizedBox(height: 15,),
          logo(context),
          SizedBox(
            height: 15,
          ),
          headerTextRow(),
          SizedBox(
            height: 15,
          ),
          emailTextFormField(),
          SizedBox(
            height: 15,
          ),
          passwordTextFormField(),
          SizedBox(
            height: 15,
          )
          ,
      Consumer<Auth>(
                    builder: (BuildContext context, Auth value, Widget child) =>
                    value.getHasErrorFun().toString().isNotEmpty==true?Text(value.getHasErrorFun(),
                        style: TextStyle(color: Colors.red)):Container(),
                  ),
          SizedBox(
            height: 10,
          ),
          forgetPassTextRow(),

          SizedBox(
            height: 20,
          ),
         submitButton(),

          SizedBox(
            height: 20,
          ),

          signUpTextRow(),
        ],
      ) ,
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body:Provider.of<Auth>(context).getIsLoadingFun() == true
          ? circularIndicator(context: context):
          SingleChildScrollView(

      child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Provider.of<AppState>(context).getTheme()==Constant.lightTheme?
          clipShape(context)
          :SizedBox(height: 100,),
          Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: forms(),
          ),
        ],
      )
      ),
      );

  }
}


