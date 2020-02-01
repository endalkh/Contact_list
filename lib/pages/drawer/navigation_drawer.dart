import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/constants/constant.dart';
import 'package:flutter_app/pages/widgets/custom_shape.dart';
import 'package:flutter_app/pages/widgets/oval_right_clipper.dart';
import 'package:flutter_app/utilities/validation/get_size.dart';

class SideDrawer extends StatelessWidget {
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
          opacity: 0.5,
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
    return
      Drawer(
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
                              clipShape(context),
                              Container(
                                color: Colors.transparent,
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
    final TextStyle tStyle = TextStyle(color: active, fontSize: 16.0);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 15),
      child: Row(children: [
        Icon(
          icon,
          color: active,
        ),
        SizedBox(width: 10.0),
        Text(
          title,
          style: tStyle,
        ),
        Spacer(),
        if (showBadge)
          Material(
            color: Colors.deepOrange,
            elevation: 5.0,
            shadowColor: Colors.red,
            borderRadius: BorderRadius.circular(5.0),
            child: Container(
              width: 25,
              height: 25,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.deepOrange,
                borderRadius: BorderRadius.circular(5.0),
              ),

            ),
          )
      ]),
    );
  }
}