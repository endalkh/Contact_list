import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/constants/constant.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/pages/SharedPreference/shared_preference.dart';
import 'package:flutter_app/pages/widgets/custom_shape.dart';
import 'package:flutter_app/pages/widgets/oval_right_clipper.dart';
import 'package:flutter_app/theme/theme.dart';
import 'package:flutter_app/utilities/validation/get_size.dart';
import 'package:provider/provider.dart';
class SideDrawer extends StatefulWidget{
  _SideDrawer createState()=>_SideDrawer();

}
class _SideDrawer extends State <SideDrawer> {
  bool isDark=false;
  _SideDrawer(){
    getTheme();
  }
  getTheme() {
    getSettingPref("dark").then((value)async{
      setState(() {
        isDark=value;
      });
    });
    print(isDark);
  }

  String firstName,lastName,email,photo;
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
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
              height:get_height(context),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [PRIMARY_COLOR,SECONDARY_COLOR]
                ),
              ),
            ),
          ),
        ),
        Opacity(
          opacity: 0.6,
          child: ClipPath(
            clipper: CustomShapeClipper2(),
            child: Container(
              height: get_height(context),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [PRIMARY_COLOR,SECONDARY_COLOR]
                ),
              ),
            ),
          ),
        ),
//        Container(
//          child: SizedBox.expand(child: RadialMenu()),
//
//        ),

      ],
    );

  }



   navigationDrawer(context){

     final themeNotifier = Provider.of<ThemeNotifier>(context);
    return Drawer(
          child: Column(
              mainAxisAlignment: MainAxisAlignment
                  .spaceBetween,
              children: <Widget>[
                Flexible(
                  child: SafeArea(
                    child: ListView(
                      shrinkWrap: true,
                      children: <Widget>[
                        Container(
                          height: 280.0,
                          child: Stack(
                            children: <Widget>[
                              isDark?Container():clipShape(context),
                              Container(
//                                color: Colors.transparent,
                                child: Container(

  child: Column(
    children: <Widget>[
      Container(
        alignment: Alignment.centerRight,
        child: IconButton(
          icon: Icon(
            Icons.power_settings_new,
            color: Colors.white,
          ),
          onPressed: () {
//            ConfirmationDialog(context,"Are you sure to Logout?",SIGN_IN);
          },
        ),
      ),
      Container(
        height: 90,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
                colors: [Colors.orange, Colors.deepOrange])),
        child: CircleAvatar(
          radius: 40,
          backgroundImage: CachedNetworkImageProvider(Constant.images[0]),
        ),
      ),
      SizedBox(height: 5.0),
      Text(
     "Samuel kassa",
        style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontWeight: FontWeight.w600),
      ),
      Text(
        "sami_k@gmail.com",
        style: TextStyle(color: Colors.white, fontSize: 16.0),
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
                      Navigator.pushNamed(context, Constant.PROFILE);
                    },
                    child: _buildRow(Icons.person_pin, "My profile",showBadge: false),
                  ),





                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, Constant.DIALOGE_PAGE);
                    },
                    child: _buildRow(Icons.timeline, "My Note", showBadge: false),
                  ),
                  Divider(thickness: 1,),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, Constant.DIALOGE_PAGE);
                    },
                    child: _buildRow(Icons.share, "Share", showBadge: false),
                  ),

                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, Constant.DIALOGE_PAGE);
                    },
                    child: _buildRow(Icons.send, "Send Link", showBadge: false),
                  ),

                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, Constant.SETTING);
                    },
                    child: _buildRow(Icons.settings, "Settings", showBadge: false),
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
                    child: _buildRow(Icons.email, "Contact us"),
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
                            padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 15),
                            child: Row(children: [
                              Icon(
                                  Icons.wb_sunny
                              ),
                              SizedBox(width: 10.0),
                              Text(
                                "Dark mode",
                              ),
                              Switch(
                                value: isDark,
                                onChanged: (value) async {
                      setState(() {
                        isDark=!isDark;
                        setSettingPref(
                          key: "dark",
                           value: isDark,

                        );

                      });
                      if(isDark){
                        themeNotifier.setTheme(Constant.darkTheme);
                      }
                      else{
                        themeNotifier.setTheme(Constant.lightTheme);
                      }

                                },
                                activeTrackColor: PRIMARY_COLOR,
                                activeColor: SECONDARY_COLOR,
                              ),
                              Spacer(),


                            ]),
                          ),

//                          child:Container(
////                          padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 15),
//                         child: Row(
//                           children: <Widget>[
//                             Icon(
//                                 Icons.add
//                             ),
//                             SizedBox(width: 10.0),
//                             Text(
//                               "hello",
//                             ),
//                             SizedBox(width: 10.0),
//                             SwitchListTile(
//                               activeColor: Colors.blue,
//                               value: true,
//                               onChanged: (val) {},
//                             ),
//                           ],
//                         ),
//                          )





//                          SwitchListTile(
//                            activeColor: Colors.blue,
//                            value: true,
//                            title: Text("P"),
//                            onChanged: (val) {},
//                          ),

//                          _buildRow(Icons.wb_sunny, "Night mode"),
                        ),

                      ],
                    ),
                  ),

                ),
              ])

      );



  }
  _buildDrawer(context) {
    return ClipPath(
      clipper: OvalRightBorderClipper(),
      child: navigationDrawer(context),

    );
  }
  _buildRow(IconData icon, String title, {bool showBadge = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 15),
      child: Row(children: [
        Icon(
          icon
        ),
        SizedBox(width: 10.0),
        Text(
          title,
        ),
        Spacer(),

      ]),
    );
  }
}