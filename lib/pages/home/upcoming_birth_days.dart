import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/constants/constant.dart';
import 'package:flutter_app/utilities/round_letter_getter/get_round_letter.dart';
import 'package:flutter_app/utilities/validation/get_size.dart';
import 'package:rounded_letter/rounded_letter.dart';
import 'package:rounded_letter/shape_type.dart';

class UpcomingBirthDaysScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
      return Scaffold(
        // backgroundColor: TRIAL_COLOR,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(padding: EdgeInsets.all(5)),
              Text(
                'Tomorrow',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                    fontStyle: FontStyle.italic),
              ),
              Padding(
                padding: EdgeInsets.only(left: 14, right: 14, bottom: 14),
                child: Container(
                  height: getHeight(context),
                  decoration: BoxDecoration(),
                  child: ListView.builder(
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 1.0),
                          child: Column(
                            children: [
                              Container(
//                              height: 50,
                                child: ListTile(
                                  onTap: () => {
                                    Navigator.pushNamed(
                                        context, Constant.PERSON_HEADER)
                                  },
                                  leading:RoundedLetter(
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

                                      fontSize: 20,
                                    ),
                                  ),
                                  subtitle: Text(
                                    'Date of Birth',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontStyle: FontStyle.italic,
                                        fontSize: 15
                                    ),

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
      );
    }
  }
