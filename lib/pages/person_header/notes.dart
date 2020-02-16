import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/api/auth.dart';
import 'package:flutter_app/api/model/get_notes.dart';
import 'package:flutter_app/constants/constant.dart';
import 'package:flutter_app/pages/widgets/circularProgressBar.dart';
import 'package:flutter_app/state/app_state.dart';
import 'package:flutter_app/utilities/validation/get_size.dart';
import 'package:provider/provider.dart';


class Notes extends StatelessWidget{
  String personId;
  Notes({@required this.personId});

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        body: FutureBuilder <List<GetNoteList>>(
    future: getNoteListApi(
    token: Provider.of<Auth>(context).getTokenFun(),
    after: "2010-01-16T23:17:50.258328Z",
    limit: 2,
    personId: "63376d59-2028-4b0d-94fa-0cc1ef3c6c25",
    ),
    builder: (context, snapshot) {
    if (snapshot.hasData) {
      return Padding(
        padding: EdgeInsets.all(10),
        child: ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.all(2.0),
                child: Container(
                  height: getHeight(context),
                  child: ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {

                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: ListTile(
                                    title: ExpansionTile(
                                      subtitle:
                                      Text(snapshot.data[index].body),
                                      children: [
                                        ListTile(
                                          leading: Icon(Icons.delete),
                                        ),
                                        ListTile(
                                          leading: Icon(Icons.edit),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                              ],
                            )),
                      );
                    },
                  ),
                ),
              );


            }
        ),
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


        );

  }

}