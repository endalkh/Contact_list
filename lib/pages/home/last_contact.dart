import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/api/auth.dart';
import 'package:flutter_app/api/model/last_contact.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/pages/person_header/person_header.dart';
import 'package:flutter_app/pages/slider/slider.dart';
import 'package:flutter_app/pages/widgets/circularProgressBar.dart';
import 'package:flutter_app/state/app_state.dart';
import 'package:flutter_app/utilities/date_formater.dart';
import 'package:flutter_app/utilities/round_letter_getter/get_round_letter.dart';
import 'package:provider/provider.dart';
import 'package:rounded_letter/rounded_letter.dart';
import 'package:rounded_letter/shape_type.dart';

class LastContact extends StatefulWidget{
  _LastContact createState()=>_LastContact();
}
class _LastContact extends State<LastContact>{
  @override
  Widget build(BuildContext context) {
      return  Scaffold(
        body:   Padding(
      padding: EdgeInsets.only(top: 10),
        child:FutureBuilder <List<GetLastContact>> (
          future: getLastContactApi(
              token: Provider.of<Auth>(context).getTokenFun()
          ),
          builder: (context, snapshot) {
         if (snapshot.hasData) {
               return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return  SingleChildScrollView(
                      child: Container(
                        margin: EdgeInsets.only(left: 10,right: 10),
                        child: Column(
                          children: [
                            SizedBox(height: 3,),
                            Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(context, SlideLeftRoute(
                                        page: PersonHeaderScreen(
                                          personId: snapshot.data[index].id,)
                                    ));
                                  },

                                  child: Container(
                                    child: ListTile(
                                        leading: RoundedLetter(
                                          text: getRoundLetter(snapshot.data[index].name.toString().toUpperCase()),
                                          shapeType: ShapeType.circle,
                                          shapeColor: PRIMARY_COLOR,
                                          shapeSize: 40,
                                          fontSize: 20,
                                          borderWidth: 1,
                                          borderColor: Color.fromARGB(255, 0, 0, 0),
                                        ),
                                        title:Text(snapshot.data[index].name,style: TextStyle(
                                          fontSize: 20,
                                        ),),

                                        subtitle: Text(dateFormatter(snapshot.data[index].lastContact),
                                          style: TextStyle(fontSize: 15),
                                        )),

                                  ),
                                )),

                          ],
                        ),
                      ),
                    );
                  }
              );
            }
            else if (snapshot.hasError) {
              print(snapshot.error);
              return Center(
                child: Text(snapshot.error.toString(),style: TextStyle(
                    fontSize: 20,fontWeight: FontWeight.w900
                ),),
              );
            }
            return circularIndicator(context: context);

          },

        ),
        ),
      );


    }
  }

