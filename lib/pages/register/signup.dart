import 'package:flutter/material.dart';
import 'package:flutter_app/api/auth.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/constants/constant.dart';
import 'package:flutter_app/pages/SharedPreference/shared_preference.dart';
import 'package:flutter_app/pages/animation/animate.dart';
import 'package:flutter_app/pages/logo/logo.dart';
import 'package:flutter_app/pages/widgets/circularProgressBar.dart';
import 'package:flutter_app/pages/widgets/cutter_ratio_container.dart';
import 'package:flutter_app/state/app_state.dart';
import 'package:flutter_app/utilities/validation/Validation.dart';
import 'package:flutter_app/utilities/validation/get_size.dart';
import 'package:provider/provider.dart';
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
    var themeNotifierAuth = Provider.of<Auth>(context,listen: false);
    setState(() {
      showError=true;
      emailError=validateEmail(usernameController.text);
      passwordError=validatePassword(passwordController.text);
    });
    Provider.of<Auth>(context,listen: false).setRegisterErrorFun("");
    if(emailError.isEmpty  && passwordError.isEmpty && showError){

      if(checkBoxValue==false){

setState(() {
  isCheckBoxSelected=false;
});
      }

        else{
        setState(() {
          isCheckBoxSelected = true;
        });
        themeNotifierAuth.setLoadingStateFun(true);
        var _registerModel =  registerApi(
          userId: usernameController.text,
          password: passwordController.text,
          context: context,
        );
        _registerModel.then((value) async{
          themeNotifierAuth.setLoadingStateFun(false);
        });

        _registerModel.catchError((value) async{
          themeNotifierAuth.setHasErrorFun(value);
          themeNotifierAuth.setLoadingStateFun(false);

        });

//          Navigator.pushNamed(context, Constant.HOME);
      }



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
      children:[
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

              Provider.of<Auth>(context,listen: false).setRegisterErrorFun("");


              Navigator.of(context).pushNamed(Constant.SIGN_IN);
            },
            child: Text(
              "Sign in",
              style: TextStyle(
                  fontWeight: FontWeight.w600, fontSize:  17),
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
            "Register",
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 30),
          ),


        ],
      ),
    );
  }
  button() {
      return FadeIn(
        5,
        RaisedButton(
          elevation: 0,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
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
                color: PRIMARY_COLOR
              // gradient: LinearGradient(colors: [PRIMARY_COLOR, SECONDARY_COLOR]),
            ),
            padding: const EdgeInsets.all(15.0),
            child: Text('SIGN Up',
                style: TextStyle(
                    fontSize: 12,
                    // fontWeight: FontWeight.w900,
                    color: lightPrimary)),
          ),
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
      body:  Provider.of<Auth>(context).getIsLoadingFun() == true
          ? circularIndicator()
          : Stack(
        children: <Widget>[

          Container(
            margin: EdgeInsets.only(top: 40, left: 20, right: 20),
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children:[
                Expanded(
                  flex: 1,
                  child: SizedBox(),
                ),
                FadeIn(2,logo(context)),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.only(left: 30),
child:                 headerTextRow(),

                ),

                FadeIn(2.5,headerTextRow(),),

                SizedBox(
                  height: 10,
                ),
                FadeIn(3,emailTextFormField()),
                SizedBox(
                  height: 10,
                ),
                FadeIn(3.5,passwordTextFormField(),),


                SizedBox(
                  height: 10,
                ),

                FadeIn(3.7,
                  Consumer<Auth>(
                    builder: (BuildContext context, Auth value, Widget child) =>
                    value.getRegisterErrorFun().toString().isNotEmpty==true?Text(value.getRegisterErrorFun(),
                        style: TextStyle(color: Colors.red)):Container(),
                  ),


                ),
                SizedBox(
                  height: 10,
                ),


                FadeIn(4.0,acceptTermsTextRow(),),
                SizedBox(
                  height: 10,
                ),

                FadeIn(4.5,  Container(
                  width: 150,
                  child: button(),
                ),),

                SizedBox(
                  height: 10,
                ),

                FadeIn(5.0, signUpTextRow(),),
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

