
import 'package:flutter/material.dart';
import 'package:flutter_app/api/auth.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/constants/constant.dart';
import 'package:flutter_app/pages/SharedPreference/shared_preference.dart';
import 'package:flutter_app/pages/logo/logo.dart';
import 'package:flutter_app/pages/widgets/circularProgressBar.dart';
import 'package:flutter_app/pages/widgets/cutter_ratio_container.dart';
import 'package:flutter_app/utilities/validation/Validation.dart';
import 'package:flutter_app/utilities/validation/get_size.dart';

class SignInPage extends StatefulWidget {
  final String title;
  SignInPage({this.title});

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
  bool isDark=false;
  String emailError="",passwordError="";
  var login;


  _LoginPageState(){
      getTheme();
    }
    @override
    void initState() {
      super.initState();
    }
    @override
    void dispose() {
      usernameController.dispose();
      passwordController.dispose();
      super.dispose();
    }

    getTheme() {
      getSettingPref("dark").then((value)async{
        setState(() {
          isDark=value;
        });
      });
    }

  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }
submitForm(){
  setState(() {
    showError=true;
    emailError=validateEmail(usernameController.text);
    passwordError=validatePassword(passwordController.text);
  });

  if(emailError.isEmpty  && passwordError.isEmpty && showError){
    setState(() {
      isLoading=true;
    });
    login=loginApi(
      userId:usernameController.text,
      password:passwordController.text,
      context:context,
    );
    setState(() {
      isLoading=false;
    });
    Navigator.pushNamed(context, Constant.HOME);
    print("$login");


  }
}

  button() {
      return RaisedButton(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
     onPressed: (){


submitForm();


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
          child: Text('SIGN IN',style: TextStyle(fontSize: 12,fontWeight: FontWeight.w900,color: lightPrimary)),
        ),
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
              prefixIcon: Icon(Icons.email, size: 20,color: PRIMARY_COLOR,),
              hintText: "Email",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none
              ),
            ),

          ),

        ),

        SizedBox(height: 5,),
        (showError==true && emailError.isNotEmpty)?
         Text(emailError,style: TextStyle(
             color: Colors.red)
        ):Container(),
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
            obscureText:_secureText ,
            controller: passwordController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.lock, size: 20,color: PRIMARY_COLOR),
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
        (showError==true && passwordError.isNotEmpty)?
        Text(passwordError,style: TextStyle(
            color: Colors.red)
        ):Container(),
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
              Navigator.pushNamed(context, Constant.RECOVER_PASSWORD);
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

        body: isLoading==true?CircularIndicator()

        :Stack(
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
isDark==true?Container():
            Positioned(
                top: -MediaQuery.of(context).size.height * .15,
                right: -MediaQuery.of(context).size.width * .4,
                child: CutterRatioContainer())

          ],
        ),
      );


    }


}
