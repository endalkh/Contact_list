import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/constants/constant.dart';
import 'package:flutter_app/state/app_state.dart';
import 'package:flutter_app/utilities/round_letter_getter/get_round_letter.dart';
import 'package:flutter_app/utilities/validation/get_size.dart';
import 'package:provider/provider.dart';
import 'package:rounded_letter/rounded_letter.dart';
import 'package:rounded_letter/shape_type.dart';

class LastContact extends StatefulWidget{
  _LastContact createState()=>_LastContact();
}
class _LastContact extends State<LastContact>{
  @override
  void initState() {
    Provider.of<Auth>(context,listen: false).setHomePageTabFun(1);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
      return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(15),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(0),

                  child: Container(
                    height: getHeight(context),
                    child: ListView.builder(
                      itemBuilder: (context, position) {
                        return Container(
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Column(
                              children: [

                                Container(
                                  height: 70,
                                  child: ListTile(
                                    onTap: () => {
                                      Navigator.pushNamed(
                                          context, Constant.PERSON_HEADER)
                                    },
                                    leading: RoundedLetter(
                                      text: getRoundLetter("John Doe").toUpperCase(),
                                      shapeType: ShapeType.circle,
                                      shapeColor: PRIMARY_COLOR,
                                      shapeSize: 40,
                                      fontSize: 20,
                                      borderWidth: 1,
                                      borderColor: Color.fromARGB(255, 0, 0, 0),
                                    ),
                                    title: Text(
                                      'John Doe',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 20),
                                    ),
                                    subtitle: Text(
                                      'Date(time) of last Contact',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 15,
                                          fontStyle: FontStyle.italic),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

