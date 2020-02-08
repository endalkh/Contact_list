import 'package:flutter/material.dart';
import 'package:flutter_app/api/auth.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/constants/constant.dart';
import 'package:flutter_app/pages/SharedPreference/shared_preference.dart';
import 'package:flutter_app/pages/animation/animate.dart';
import 'package:flutter_app/pages/logo/logo.dart';
import 'package:flutter_app/pages/widgets/back_button.dart';
import 'package:flutter_app/pages/widgets/cutter_ratio_container.dart';
import 'package:flutter_app/utilities/validation/Validation.dart';
import 'package:flutter_app/utilities/validation/get_size.dart';
class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: SignUpScreen(),
    );
  }
}
class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key key}) : super(key: key);
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignUpScreen> {
  bool isLoading = false;
  bool showError=false;
  bool showBackendError=false;
  bool checkBoxValue = false;
  bool isCheckBoxSelected=true;
  String emailError="",passwordError="";
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _secureText = true;
  bool isDark=false;

  _SignInScreenState(){
    getTheme();
  }

  getTheme() {
    getSettingPref("dark").then((value)async{
      setState(() {
        isDark=value;
      });
    });
  }

  submitForm(){
    setState(() {
      showError=true;
      emailError=validateEmail(usernameController.text);
      passwordError=validatePassword(passwordController.text);
    });

    if(emailError.isEmpty  && passwordError.isEmpty && showError){
      if(checkBoxValue==false){
setState(() {
  isCheckBoxSelected=false;
});
      }
      else if(checkBoxValue==true) {
        setState(() {
          isCheckBoxSelected = true;
        });
      }
        else{
          Navigator.pushNamed(context, Constant.HOME);
      }


//      setState(() {
//        isLoading=true;
//      });
//      loginApi(
//        userId:usernameController.text,
//        password:passwordController.text,
//        context:context,
//      );
//      setState(() {
//        isLoading=false;
//      });



    }
  }
  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
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
        mainAxisAlignment: MainAxisAlignment.center,
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
                  fontWeight: FontWeight.w600, color: Colors.orange[200]),
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
              Navigator.of(context).pushNamed(Constant.SIGN_IN);
              print("Routing to Sign up screen");
            },
            child: Text(
              "Sign in",
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
      child: Row(
        children: <Widget>[
          Text(
            "REGISTER",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30),
          ),


        ],
      ),
    );
  }
  button() {
    return RaisedButton(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      onPressed: () {
       submitForm();
      },
      padding: EdgeInsets.all(0.0),
      child: Container(

        alignment: Alignment.center,
        width:  get_width(context),
        decoration: BoxDecoration(
         gradient: LinearGradient(
           colors: [PRIMARY_COLOR,SECONDARY_COLOR]
         ),
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        padding: const EdgeInsets.all(12.0),
        child: Text('SIGN Up',style: TextStyle(fontSize: 12,color: Colors.white,fontWeight: FontWeight.w900)),
      ),
    );
  }
  acceptTermsTextRow() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Checkbox(
              value: checkBoxValue,
              onChanged: (bool newValue) {
                setState(() {
                  checkBoxValue = newValue;
                });
              }),
          FlatButton(
            onPressed:()=>{
              Navigator.pushNamed(context, Constant.TERMS_AND_CONDTION),
            },
            child: Text("I accept all terms and conditions",
              style: TextStyle(fontWeight: FontWeight.w400,
                  color: isCheckBoxSelected==false?Colors.red:PRIMARY_COLOR,
                  fontSize:12,


              ),
            ),
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
                FadeIn(2,logo()),
                SizedBox(
                  height: 20,
                ),

                FadeIn(2.5,headerTextRow(),),
                SizedBox(
                  height: 20,
                ),
                FadeIn(3,emailTextFormField()),
                SizedBox(
                  height: 20,
                ),
                FadeIn(3.5,passwordTextFormField(),),


                SizedBox(
                  height: 20,
                ),


                FadeIn(4.0,acceptTermsTextRow(),),
                SizedBox(
                  height: 10,
                ),

                FadeIn(4.5, button(),),

                SizedBox(
                  height: 10,
                ),

                FadeIn(4.5,  signUpTextRow(),),
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

