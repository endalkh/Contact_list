import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/constants/constant.dart';
import 'package:flutter_app/pages/SharedPreference/shared_preference.dart';
import 'package:flutter_app/pages/contact_sync/contact_sync.dart';
import 'package:flutter_app/pages/dialog/confirmationDialog.dart';
import 'package:flutter_app/pages/login/signin.dart';
import 'package:flutter_app/pages/slider/slider.dart';
import 'package:flutter_app/pages/widgets/custom_shape.dart';
import 'package:flutter_app/state/app_state.dart';
import 'package:flutter_app/utilities/abstract_classes/confirmation_abstract.dart';
import 'package:flutter_app/utilities/get_email.dart';
import 'package:flutter_app/utilities/launcher.dart';
import 'package:flutter_app/utilities/round_letter_getter/get_round_letter.dart';
import 'package:flutter_app/utilities/validation/get_size.dart';
import 'package:provider/provider.dart';
import 'package:rounded_letter/rounded_letter.dart';
import 'package:rounded_letter/shape_type.dart';

import '../login/signin.dart';


class SideDrawer extends StatefulWidget implements ShouldImp{
  _SideDrawer createState() => _SideDrawer();

  @override
  void changer({context,id}) {
    signOut();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (BuildContext context) => SignInPage()),
      ModalRoute.withName('/signIn'),
    );

//    Navigator.pop(context);
//    Navigator.push(context, SlideLeftRoute(
//        page: SignInPage()
//    ));

  }
}


 class _SideDrawer extends State<SideDrawer> {

  bool isDark = false;
  BuildContext context;

  @override
  void initState() {
    getSettingPref("dark").then((value) async {
      if(value==true){
        setState(() {
          isDark = true;
        });
      }
      else if(value==false){
        setState(() {
          isDark = false;
        });
      }
      else{
        setState(() {
          isDark = false;
        });
      }


    });
   super.initState();
  }


  String firstName, lastName, email, photo;
  final Color primary = Colors.white;
  final Color active = Colors.grey.shade800;
  final Color divider = Colors.grey.shade600;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  build(BuildContext context) {
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
            mainAxisAlignment: MainAxisAlignment.start,
            children:[

          Flexible(
            child: SafeArea(
              child: ListView(
                shrinkWrap: true,
                children: [
                  Container(
                    height: 200.0,
                    width: getWidth(context)*0.5,
                    child: Stack(
                      children:[
                        isDark==true? Container() : clipShape(context),
                        Container(
                          child: Container(
                            child: Column(
                              children:[

                                Container(

                                child:RoundedLetter(
                                  text: getRoundLetter(getEmail(context)).toUpperCase(),
                                  shapeType: ShapeType.circle,
                                  shapeColor: PRIMARY_COLOR.withOpacity(0.5),
                                  shapeSize: 60,
                                  fontSize: 30,
                                  borderWidth: 1,
                                  borderColor: Color.fromARGB(255, 0, 0, 0),
                                ),
                                ),
                                SizedBox(height: 15.0),
                                Expanded(
                                child:Text(
                                  getEmail(context),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600),
                                ),
                                ),

                              ],
                            ),
                          ),
                          padding: const EdgeInsets.only(left: 40,right: 40,top: 40),
                        )
                      ],
                    ),
                  ),
            


                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(context, SlideLeftRoute(
                          page: ContactListPage()
                      ));
                    },
                    child:
                        _buildRow(Icons.timeline, "Contact Sync"),
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  // GestureDetector(


                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                     launchURL("https://relateapp.io/app/support/create-ticket");
                    },
                    child: _buildRow(Icons.help, "Help"),
                  ),

                  GestureDetector(

                    onTap: () {},
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
                              Provider.of<AppState>(context,listen: false).setDark();
                            } else {
                              Provider.of<AppState>(context,listen: false).setLight();
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
    return navigationDrawer(context);
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
