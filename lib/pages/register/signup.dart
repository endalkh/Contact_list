import 'package:flutter/material.dart';
import 'package:flutter_app/api/auth.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/constants/constant.dart';
import 'package:flutter_app/pages/SharedPreference/shared_preference.dart';
import 'package:flutter_app/pages/dialog/info_dialog.dart';
import 'package:flutter_app/pages/login/signin.dart';
import 'package:flutter_app/pages/logo/logo.dart';
import 'package:flutter_app/pages/slider/slider.dart';
import 'package:flutter_app/pages/widgets/circularProgressBar.dart';
import 'package:flutter_app/pages/widgets/cutter_ratio_container.dart';
import 'package:flutter_app/state/app_state.dart';
import 'package:flutter_app/utilities/abstract_classes/confirmation_abstract.dart';
import 'package:flutter_app/utilities/launcher.dart';
import 'package:flutter_app/utilities/validation/Validation.dart';
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
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> implements ShouldImp {
  bool isLoading = false;
  bool showError = false;
  bool showBackendError = false;
  bool checkBoxValue = false;
  bool isCheckBoxSelected = true;
  String emailError = "", passwordError = "";
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _secureText = true;
  bool isDark = false;

  _SignUpScreenState() {
    getTheme();
  }

  getTheme() {
    getSettingPref("dark").then((value) async {
      setState(() {
        isDark = value;
      });
    });
  }

  submitForm() {
    var themeNotifierAuth = Provider.of<Auth>(context, listen: false);
    setState(() {
      showError = true;
      emailError = validateEmail(usernameController.text);
      passwordError = validatePassword(passwordController.text);
    });
    Provider.of<Auth>(context, listen: false).setRegisterErrorFun("");
    if (emailError.isEmpty && passwordError.isEmpty && showError) {
      if (checkBoxValue == false) {
        setState(() {
          isCheckBoxSelected = false;
        });
      } else {
        setState(() {
          isCheckBoxSelected = true;
        });
        themeNotifierAuth.setLoadingStateFun(true);
        var _registerModel = registerApi(
          userId: usernameController.text,
          password: passwordController.text,
          context: context,
        );
        _registerModel.then((value) {
          if (value == true) {
            themeNotifierAuth.setLoadingStateFun(false);
            InfoDialog(
                context: context,
                callback: _SignUpScreenState(),
                title:
                    "A confirmation email has been sent. Please check your email.",
                type: Constant.success);
          }
        });

        _registerModel.catchError((value) {
          themeNotifierAuth.setHasErrorFun(value);
          themeNotifierAuth.setLoadingStateFun(false);
        });
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
      children: [
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
                focusColor: PRIMARY_COLOR,
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Forgot your password?",
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
          ),
          SizedBox(
            width: 5,
          ),
          GestureDetector(
            onTap: () {},
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
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
          ),
          SizedBox(
            width: 5,
          ),
          GestureDetector(
            onTap: () {
              Provider.of<Auth>(context, listen: false).setRegisterErrorFun("");

              Navigator.push(context, SlideLeftRoute(page: SignInPage()));
            },
            child: Text(
              "Sign in",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
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
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 30),
          ),
        ],
      ),
    );
  }

  submitButton() {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: RawMaterialButton(
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
            fillColor: PRIMARY_COLOR,
            padding: const EdgeInsets.all(15.0),
          ),
        )
      ],
    );
  }

  acceptTermsTextRow() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Checkbox(
              value: checkBoxValue,
              checkColor: TRIAL_COLOR,
              activeColor: PRIMARY_COLOR,
              onChanged: (bool newValue) {
                setState(() {
                  checkBoxValue = newValue;
                });
              }),
          FlatButton(
            onPressed: () {
              launchURL("https://relateapp.io/terms-of-service/");
            },
            child: Text(
              "I accept the Terms and Conditions",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: isCheckBoxSelected == false ? Colors.red : PRIMARY_COLOR,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  forms() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 20,
          ),
          logo(context),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.only(left: 10),
            child: headerTextRow(),
          ),
          SizedBox(
            height: 15,
          ),
          emailTextFormField(),
          SizedBox(
            height: 20,
          ),
          passwordTextFormField(),
          Consumer<Auth>(
            builder: (BuildContext context, Auth value, Widget child) =>
                value.getRegisterErrorFun().toString().isNotEmpty == true
                    ? Text(value.getRegisterErrorFun(),
                        style: TextStyle(color: Colors.red))
                    : Container(),
          ),
          Container(
            padding: EdgeInsets.only(left: 100),
          child: acceptTermsTextRow(),

          ),
          submitButton(),
          SizedBox(
            height: 10,
          ),
          signUpTextRow(),
        ],
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Provider.of<Auth>(context).getIsLoadingFun() == true
          ? circularIndicator(context: context)
          : SingleChildScrollView(
              child: Column(
              children: <Widget>[
                Provider.of<AppState>(context).getTheme() == Constant.lightTheme
                    ? CustomPaint(
                        child: Container(
                          height: 200.0,
                        ),
                        painter: CurvePainter(),
                      )
                    : SizedBox(
                        height: 100,
                      ),
                forms(),
              ],
            )),
    );
  }

  @override
  void changer({context, id}) {
  }
}
