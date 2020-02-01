
import 'package:flutter/material.dart';
import 'package:flutter_app/constants/colors.dart';
class SettingScreen extends StatefulWidget{
  _SettingScreen createState()=>_SettingScreen();
}
class _SettingScreen extends State<SettingScreen> {
  bool isThemeOn=false;
  final TextStyle headerStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 20.0,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "ACCOUNT",
              style: headerStyle,
            ),
            const SizedBox(height: 10.0),
            Card(
              elevation: 0.5,
              margin: const EdgeInsets.symmetric(
                vertical: 4.0,
                horizontal: 0,
              ),
              child: Column(
                children: <Widget>[

                  ListTile(
                    leading: CircleAvatar(
                        backgroundImage: AssetImage('assets/images/adis2.png'),
                    ),
                    title: Text("Endalk Belete"),
                    onTap: () {},
                  ),
                  _buildDivider(),
                  SwitchListTile(
                    activeColor: PRIMARY_COLOR,
                    value: isThemeOn,
                    title: Text("Use app Primary theme",style: TextStyle(
                      color: PRIMARY_COLOR
                    ),),
                    onChanged: (val) {
                      setState(() {
                        isThemeOn=!isThemeOn;
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            Text(
              "ACCOUNT SETTING",
              style: headerStyle,
            ),
            Card(
              margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0,),
              child: Column(
                children: <Widget>[
              Card(
                child:  ListTile(
                  title: Text("Change password",
                    style: TextStyle(
                        color: COLOR_LINK
                    ),
                  ),
                ) ,
              ),
                  Card(
                    child:  ListTile(
                      title: Text("Change user name",
                        style: TextStyle(
                            color: COLOR_LINK
                        ),
                      ),
                    ) ,
                  ),


                ],
              ),
            ),
            Card(
              margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0,),
              child: ListTile(
              leading: Icon(Icons.exit_to_app,color: COLOR_LINK,),
              title: Text("Logout",
                style: TextStyle(
                  color: COLOR_LINK,
                ),
              ),
              onTap: (){},
            ),
              
            ),
            const SizedBox(height: 60.0),

          ],
        ),
      ),
    );
  }

  Container _buildDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      width: double.infinity,
      height: 1.0,
     // color: Colors.grey.shade300,
    );
  }
}