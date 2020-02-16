import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/constants/constant.dart';
import 'package:flutter_app/pages/SharedPreference/shared_preference.dart';
import 'package:flutter_app/pages/dialog/confirmationDialog.dart';
import 'package:flutter_app/pages/widgets/custom_shape.dart';
import 'package:flutter_app/pages/widgets/oval_right_clipper.dart';
import 'package:flutter_app/state/app_state.dart';
import 'package:flutter_app/utilities/confirmation_abstract/confirmation_abstract.dart';
import 'package:flutter_app/utilities/get_email.dart';
import 'package:flutter_app/utilities/round_letter_getter/get_round_letter.dart';
import 'package:flutter_app/utilities/validation/get_size.dart';
import 'package:provider/provider.dart';
import 'package:rounded_letter/rounded_letter.dart';
import 'package:rounded_letter/shape_type.dart';


class SideDrawer extends StatefulWidget implements ShouldImp{
  _SideDrawer createState() => _SideDrawer();

  @override
  void changer({context}) {
    signOut();
    Navigator.pushNamed(context, Constant.SIGN_IN);
  }
}


 class _SideDrawer extends State<SideDrawer> {


  bool isDark = false;
  BuildContext context;

  @override
  void initState() {
    getTheme();
   super.initState();
  }

  getTheme() {
    getSettingPref("dark").then((value) async {
      setState(() {
        isDark = value;
      });
    });
  }



  String firstName, lastName, email, photo;
  final Color primary = Colors.white;
  final Color active = Colors.grey.shade800;
  final Color divider = Colors.grey.shade600;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  build(BuildContext context) {
    this.context=context;
    return _buildDrawer(context);
  }

  clipShape(context) {
    return Stack(
      children: <Widget>[
        Opacity(
          opacity: 0.75,
          child: ClipPath(
            clipper: CustomShapeClipper(),
            child: Container(
              height: getHeight(context),
              decoration: BoxDecoration(
                color: PRIMARY_COLOR,
                
              ),
            ),
          ),
        ),
        Opacity(
          opacity: 0.6,
          child: ClipPath(
            clipper: CustomShapeClipper2(),
            child: Container(
              height: getHeight(context),
              decoration: BoxDecoration(
                color: PRIMARY_COLOR,

              ),
            ),
          ),
        ),

      ],
    );
  }

  navigationDrawer(context) {

    return Drawer(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:[

          Flexible(
            child: SafeArea(
              child: ListView(
                shrinkWrap: true,
                children: [
                  Container(
                    height: 280.0,
                    child: Stack(
                      children:[
                        isDark==true? Container() : clipShape(context),
                        Container(
                          child: Container(
                            child: Column(
                              children:[

                                Container(
                                  alignment: Alignment.centerRight,
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.power_settings_new,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {

                                     exit(0);
                                    },
                                  ),
                                ),
                                Container(

                                child:RoundedLetter(
                                  text: getRoundLetter(getEmail(context)).toUpperCase(),
                                  shapeType: ShapeType.circle,
                                  shapeColor: PRIMARY_COLOR.withOpacity(0.5),
                                  shapeSize: 80,
                                  fontSize: 40,
                                  borderWidth: 1,
                                  borderColor: Color.fromARGB(255, 0, 0, 0),
                                ),
                                ),
                                SizedBox(height: 15.0),
                                Text(
                                  getEmail(context),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600),
                                ),

                              ],
                            ),
                          ),
                          padding: const EdgeInsets.all(40),
                        )
                      ],
                    ),
                  ),
            


                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, Constant.DIALOG_PAGE);
                    },
                    child:
                        _buildRow(Icons.timeline, "My Note"),
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  // GestureDetector(

                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, Constant.DIALOG_PAGE);
                    },
                    child: _buildRow(Icons.send, "Send Link"),
                  ),



                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, Constant.ABOUT_US);
                    },
                    child: _buildRow(Icons.email, "About us"),
                  ),

                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, Constant.SETTING);
                    },
                    child: _buildRow(Icons.settings, "Setting"),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, Constant.SETTING);
                    },
                    child: _buildRow(Icons.help, "Help"),
                  ),

                  GestureDetector(

                    onTap: () {
                      Navigator.pushNamed(context, Constant.SETTING);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 15),
                      child: Row(children: [
                        Icon(Icons.wb_sunny,color: PRIMARY_COLOR,),

                        SizedBox(width: 10.0),
                        Text(
                          "Dark mode",
                        ),
                        Switch(
                          value: Provider.of<AppState>(context).getTheme()==Constant.lightTheme?false:true,

                          onChanged: (value) async {
                            setState(() {
                              isDark = !isDark;
                              setSettingPref(
                                key: "dark",
                                value: isDark,
                              );
                            });

                            if (isDark == true) {
                              Provider.of<AppState>(context).setDark();
                            } else {
                              Provider.of<AppState>(context).setLight();
                            }
                          },
                          activeTrackColor: PRIMARY_COLOR,
                          activeColor: SECONDARY_COLOR,
                        ),
                        Spacer(),
                      ]),
                    ),
                  ),
                  Divider(),
                  GestureDetector(
                    onTap: () {
                      ConfirmationDialog(context: context,title: "Are you sure to logout?",callback: SideDrawer());

                      },
                    child: _buildRow(Icons.exit_to_app, "Logout"),
                  ),

                ],
              ),
            ),
          ),
        ]));
  }

  _buildDrawer(context) {
    return ClipPath(
      clipper: OvalRightBorderClipper(),
      child: navigationDrawer(context),
    );
  }

  _buildRow(IconData icon, String title) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
      child: Row(children: [
        Icon(icon,color: PRIMARY_COLOR,),

        SizedBox(width: 10.0),
        Text(
          title,
        ),
        Spacer(),
      ]),
    );
  }

}
