import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constants/constant.dart';
import 'package:flutter_app/utilities/validation/get_size.dart';

class Notes extends StatefulWidget{
  _Notes createState()=>_Notes();
}
class _Notes extends State<Notes>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
      return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(left: 15, right: 15),
            child: Column(
              children: [
                Text(
                  'Notes',
                  style: TextStyle(fontSize: 27, fontWeight: FontWeight.w300),
                ),
                Padding(
                  padding: EdgeInsets.all(2.0),
                  child: Container(
                    height: getHeight(context),
                    child: ListView.builder(
                      itemCount: 10,
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
                                        title: Text(
                                          'Header Goes Here',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500),
                                        ),
                                        subtitle:
                                        Text(Constant.PASSWORDRESETDESC),
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
                ),
              ],
            ),
          ),
        ),
      );
  }

}