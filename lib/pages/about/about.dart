

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/pages/appbar/AppBar.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: headerNav(context: context,title: "About us"),
      body: body(context),
    );
  }


  Widget body(context) {
    return Container(
      padding: EdgeInsets.all(25),
      child: ListView(
        children: <Widget>[
          headerComponent(),
          Container(margin: EdgeInsets.only(top: 40)),
          descriptionComponent(),
          Container(margin: EdgeInsets.only(top: 40)),
          Container(margin: EdgeInsets.only(top: 20)),
          Divider(thickness: 2,),
          Container(margin: EdgeInsets.only(top: 40)),
          developerItemComponent(
            "Developers",
            "AddisAba Software ",
            github: "https://github.com/addisabasoftware",
            linkedIn: "https://www.linkedin.com/in/endalk/",
          ),
          Container(margin: EdgeInsets.only(top: 30)),
          developerItemComponent(
            "Designer",
            "Addisaba software",
            github: "https://github.com/roshanrahman/",
            linkedIn: "https://www.linkedin.com/in/roshanrahman6399/",
          )
        ],
      ),
    );
  }

  Widget headerComponent() {
    return Text("About app", style: TextStyle(fontSize: 36));
  }

  Widget descriptionComponent() {
    return Text(
      "AddisAba is a software company founded 1989",
      style: TextStyle(
        fontSize: 19,
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w300,
      ),
    );
  }


  Widget developerItemComponent(
    String role,
    String name, {
    String linkedIn,
    String github,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          role,
          style: TextStyle(fontSize: 18),
        ),
        Container(margin: EdgeInsets.only(top: 5)),
        Row(
          children: <Widget>[
            Text(
              name,
              style: TextStyle(fontSize: 24),
            ),
            Expanded(child: Container()),

            Container(margin: EdgeInsets.only(left: 5)),
            IconButton(
              icon: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.asset(
                  "assets/icon/github_ic.png",
                  width: 26,
                  height: 26,
                ),
              ),
              onPressed: () async {
//                await launchURL(github);
              },
            )
          ],
        )
      ],
    );
  }


}
