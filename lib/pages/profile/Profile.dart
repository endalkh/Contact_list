
import 'package:flutter/material.dart';

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
                      Colors.black,
                      Colors.black
                    ]
                )
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    CircleAvatar(
                      child: Icon(Icons.call, size: 30.0,),
                      minRadius: 30.0,
                      backgroundColor: Colors.red.shade600,),
//                    CircleAvatar(
//                      minRadius: 60,
//                      backgroundColor: Colors.deepOrange.shade300,
//                      child: CircleAvatar(
//                        backgroundImage: CachedNetworkImageProvider(images[0]),
//                        minRadius: 50,
//
//                      ),
//                    ),
                    CircleAvatar(
                      child: Icon(Icons.message, size: 30.0,),
                      minRadius: 30.0,
                      backgroundColor: Colors.red.shade600,),
                  ],
                ),
                SizedBox(height: 10,),
                Text("Stefan Belete", style: TextStyle(fontSize: 22.0, color: Colors.white),),
                Text("Addis Abaaba, Ethiopia", style: TextStyle(fontSize: 14.0, color: Colors.red.shade700),)
              ],
            ),
          ),
//          Container(
//            // height: 50,
//            child: Row(
//              children: <Widget>[
//                Expanded(
//                  child: Container(
//                    color: Colors.deepOrange.shade300,
//                    child: ListTile(
//                      title: Text("50895",textAlign: TextAlign.center, style: TextStyle(
//                          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24.0
//                      ),),
//                      subtitle: Text("FOLLOWERS", textAlign: TextAlign.center, style: TextStyle(color: Colors.red),),
//                    ),
//                  ),
//                ),
//                Expanded(
//                  child: Container(
//                    color: Colors.red,
//                    child: ListTile(
//                      title: Text("34524",textAlign: TextAlign.center, style: TextStyle(
//                          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24.0
//                      ),),
//                      subtitle: Text("FOLLOWING", textAlign: TextAlign.center, style: TextStyle(color: Colors.white70),),
//                    ),
//                  ),
//                ),
//              ],
//            ),
//          ),
//          ListTile(
//            title: Text("Email", style: TextStyle(color: COLOR_PRIMARY, fontSize: 12.0),),
//            subtitle: Text("endalkhbel@gmail.com", style: TextStyle(fontSize: 18.0),),
//          ),
//          Divider(),
//          ListTile(
//            title: Text("Phone", style: TextStyle(color: COLOR_PRIMARY, fontSize: 12.0),),
//            subtitle: Text("0937383805", style: TextStyle(fontSize: 18.0),),
//          ),
//          Divider(),
//          ListTile(
//            title: Text("Twitter", style: TextStyle(color: COLOR_PRIMARY, fontSize: 12.0),),
//            subtitle: Text("@endalk", style: TextStyle(fontSize: 18.0),),
//          ),
//          Divider(),
//          ListTile(
//            title: Text("Facebook", style: TextStyle(color: COLOR_PRIMARY, fontSize: 12.0),),
//            subtitle: Text("facebook.com/stefan", style: TextStyle(fontSize: 18.0),),
//          ),
          Divider(),
        ],
      ),
    );
  }
}