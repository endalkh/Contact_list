import 'package:flutter/material.dart';
import 'package:flutter_app/constants/constant.dart';
import 'package:flutter_app/utilities/abstract_classes/confirmation_abstract.dart';
class InfoDialog {
  String title;
  String type;
  ShouldImp callback;
  InfoDialog({context,title,callback,type}){
    this.title=title;
    this.callback=callback;
    this.type=type;
    _alertDialog(context);
  }
  _alertDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return  Center(
            child: Dialog(
              elevation: 0,
              child: Container(
                padding: EdgeInsets.only(right: 16.0),
                height: 150,
                decoration: BoxDecoration(
//                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(75),
                        bottomLeft: Radius.circular(75),
                        topRight: Radius.circular(75),
                        bottomRight: Radius.circular(10)
                    )
                ),
                child: Row(
                  children: <Widget>[
                    SizedBox(width: 20.0),
                    CircleAvatar(radius: 35,  child:this.type==Constant.success? Icon(Icons.check_circle,color: Colors.green,):Icon(Icons.error,color: Colors.red,)),
                    SizedBox(width: 20.0),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[

                          Text(this.type==Constant.success?"Success":"Error", style:TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 18,
                            color: this.type==Constant.success?Colors.green:Colors.red
                          ) ),
                          SizedBox(height: 10.0),
                          Flexible(
                            child: Text(
                                title),
                          ),
                          SizedBox(height: 10.0),
                          Row(children: <Widget>[



                            RaisedButton(
                                child: Text("Ok"),
                                color: this.type==Constant.success?Colors.green:Colors.red,
                                colorBrightness: Brightness.dark,
                                onPressed: () {
                                Navigator.pop(context);
                                },

                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                              ),

                          ],)
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }
    );
  }
}


