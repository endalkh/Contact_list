import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/api/auth.dart';
import 'package:flutter_app/api/model/contact_list.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/constants/constant.dart';
import 'package:flutter_app/pages/widgets/circularProgressBar.dart';
import 'package:flutter_app/state/app_state.dart';
import 'package:flutter_app/utilities/round_letter_getter/get_round_letter.dart';
import 'package:flutter_app/utilities/validation/get_size.dart';
import 'package:provider/provider.dart';
import 'package:rounded_letter/rounded_letter.dart';
import 'package:rounded_letter/shape_type.dart';

class UpcomingBirthDaysScreen extends StatefulWidget{
  _UpcomingBirthDaysScreen createState()=>_UpcomingBirthDaysScreen();
}
class _UpcomingBirthDaysScreen extends State<UpcomingBirthDaysScreen>{
  @override
  void initState() {
    Provider.of<Auth>(context,listen: false).setHomePageTabFun(0);
    super.initState();
  }

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
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                    fontStyle: FontStyle.italic),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: EdgeInsets.only(left: 14, right: 14, bottom: 14),
                child: Container(
                  height: getHeight(context),
                  decoration: BoxDecoration(),

 child: FutureBuilder <List<GetAllContact>> (
    future: getUpComingBirthday(
    token: Provider.of<Auth>(context).getTokenFun()
    ),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        return ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (context, index) {
            return  SingleChildScrollView(
                child: Card(
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
                        onTap: () =>
                        {
                          Navigator.pushNamed(
                              context, Constant.PERSON_HEADER)
                        },
                        leading: RoundedLetter(
                          text: getRoundLetter(snapshot.data[index].name).toUpperCase(),
                          shapeType: ShapeType.circle,
                          shapeColor: PRIMARY_COLOR,
                          shapeSize: 40,
                          fontSize: 20,
                          borderWidth: 1,
                          borderColor: Color.fromARGB(255, 0, 0, 0),

                        ),
                        title: Text(
                          snapshot.data[index].name,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,

                            fontSize: 20,
                          ),
                        ),
                        subtitle: Text(
                       snapshot.data[index].birthDate,
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
            ),
            );
          },
        );
    }
      else if (snapshot.hasError) {

        return Center(
          child: Text(snapshot.error.toString(),style: TextStyle(
              fontSize: 20,fontWeight: FontWeight.w900
          ),),
        );
      }
      return circularIndicator(context: context);
    }
                ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
