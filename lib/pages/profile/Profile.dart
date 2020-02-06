
import 'package:flutter/material.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/constants/constant.dart';

class ProfileOnePage extends StatelessWidget {
  static final String path = "lib/src/pages/profile/profile1.dart";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.deepOrange,
      appBar: AppBar(
        title: Text("View Profile"),
//        backgroundColor: COLOR_PRIMARY,
        elevation: 0,
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: 200,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    stops: [0.0, 0.9],
                    colors: [
                      PRIMARY_COLOR,
                      SECONDARY_COLOR
                    ]
                )
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 10,),
                Text("Stefan Belete", style: TextStyle(fontSize: 22.0, color: Colors.white),),
                Text("Addis Abaaba, Ethiopia", style: TextStyle(fontSize: 14.0,

                                                                fontWeight: FontWeight.w900),)
              ],
            ),
          ),
          Container(
            // height: 50,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    color: SECONDARY_COLOR,
                    child: ListTile(
                      title: Text("1000",textAlign: TextAlign.center, style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold, fontSize: Constant.fontSize(Constant.XL),
                      ),),
                      subtitle: Text("Persons", textAlign: TextAlign.center, style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: Constant.fontSize(Constant.M),

                      ),),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: PRIMARY_COLOR,
                    child: ListTile(
                      title: Text("10000",textAlign: TextAlign.center, style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold, fontSize: Constant.fontSize(Constant.XL),
                      ),),
                      subtitle: Text("Notes", textAlign: TextAlign.center, style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: Constant.fontSize(Constant.M),

                      ),),
                    ),
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            title: Text("Email", style: TextStyle(color: PRIMARY_COLOR, fontSize: 12.0),),
            subtitle: Text("endalkhbel@gmail.com", style: TextStyle(fontSize: 18.0),),
          ),
          Divider(),
          ListTile(
            title: Text("Phone", style: TextStyle(color: PRIMARY_COLOR, fontSize: 12.0),),
            subtitle: Text("0937383805", style: TextStyle(fontSize: 18.0),),
          ),
          Divider(),

        ],
      ),
    );
  }
}