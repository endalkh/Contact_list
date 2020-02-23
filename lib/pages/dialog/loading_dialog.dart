import 'package:flutter/material.dart';
import 'package:flutter_app/pages/widgets/circularProgressBar.dart';

class LoadingDialog  {
  String title;
  BuildContext context;
  LoadingDialog({context,title}){

    this.title=title;
    this.context=context;
    _alertDialog(context);
  }
  _alertDialog(BuildContext cxt) {
    showDialog(
        context: context,
        barrierDismissible: false,
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
                    CircleAvatar(radius: 35,  child:circularIndicator(context: context),),
                         SizedBox(width: 20.0),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Loading...", style:TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 18,
                          ) ),
                          SizedBox(height: 10.0),
                          Flexible(
                            child: Text(title),
                          ),
                          SizedBox(height: 10.0),
                          Row(children: <Widget>[
                            Expanded(
                              child: RaisedButton(
                                child: Text("Deleting..."),
                                color: Colors.red,
                                colorBrightness: Brightness.dark,
                                onPressed: (){},
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                              ),
                            ),

                            SizedBox(width: 10.0),


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


