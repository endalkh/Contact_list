import 'package:flutter/material.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/constants/constant.dart';
import 'package:flutter_app/pages/dialog/loading_dialog.dart';
import 'package:flutter_app/pages/widgets/circularProgressBar.dart';
import 'package:flutter_app/state/app_state.dart';
import 'package:flutter_app/utilities/abstract_classes/confirmation_abstract.dart';
import 'package:provider/provider.dart';
class ConfirmationDialog  {
String title;
String type;
String id;
ShouldImp callback;
BuildContext context;
bool fal=false;
ConfirmationDialog({context,title,id,callback,type}){

    this.title=title;
    this.callback=callback;
    this.type=type;
    this.id=id;
    this.context=context;
    _alertDialog(context);
  }
  _alertDialog(BuildContext cxt) {
     showDialog(
        context: context,
        builder: (BuildContext cxt) {
          return  Center(
            child: Dialog(
              elevation: 0,
//              backgroundColor: Colors.transparent,
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
                    CircleAvatar(radius: 35,  child: (this.type==Constant.warningIcon? Icon(Icons.warning,color: Colors.yellow):Icon(Icons.info,color: PRIMARY_COLOR,))),
                    SizedBox(width: 20.0),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(this.type==Constant.warningIcon?"Warning":"Alert!", style:TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 18,
                          ) ),
                          SizedBox(height: 10.0),
                          Flexible(
                            child: Text(
                               title),
                          ),
                          SizedBox(height: 10.0),
                          Row(children: <Widget>[
                            Expanded(
                              child: RaisedButton(
                                child: Text("No"),
                                color: Colors.red,
                                colorBrightness: Brightness.dark,
                                onPressed: (){Navigator.pop(context);},
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                              ),
                            ),

                            SizedBox(width: 10.0),

                            Expanded(
                              child: RaisedButton(
                                child: Text("Yes"),
                                color: Colors.green,
                                colorBrightness: Brightness.dark,
                                onPressed: () {
                                  Navigator.pop(context);
                                  callback.changer(context: context,id: id);
                                  },

                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                              ),
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


