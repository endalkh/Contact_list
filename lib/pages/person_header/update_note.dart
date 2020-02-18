import 'package:flutter/material.dart';
import 'package:flutter_app/api/auth.dart';
import 'package:flutter_app/api/model/get_email.dart';
import 'package:flutter_app/api/model/get_notes.dart';
import 'package:flutter_app/state/app_state.dart';
import 'package:provider/provider.dart';

class UpdateNote extends StatefulWidget{
  String id;

  UpdateNote({@required this.id});

  _UpdateNote createState()=>_UpdateNote(id);
}

class _UpdateNote extends State<UpdateNote>{

  TextEditingController noteController = TextEditingController();
  BuildContext context;


  String id;
  _UpdateNote(this.id){
    this.id=id;
  }


  submitForm(){
    Provider.of<Auth>(context,listen: false).setLoadingStateFun(true);
    var token=Provider.of<Auth>(context,listen: false).getTokenFun();
    var addPhone =  addEmailApi(
        token:token ,
        personId: id,
        type: noteController.toString(),
        address: noteController.text
    );

    addPhone.then((value) async{
      Provider.of<Auth>(context,listen: false).setSuccessfullyRegisteredFun(true);
      Provider.of<Auth>(context,listen: false).setLoadingStateFun(false);
    });

    addPhone.catchError((value) async{
      Provider.of<Auth>(context,listen: false).setLoadingStateFun(false);
      Provider.of<Auth>(context,listen: false).setSuccessfullyRegisteredFun(false);
      Provider.of<Auth>(context,listen: false).setHasErrorFun(value.toString());

    });

  }

  enterNotesTextFormField() {
    return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          Flexible(
                child:Material(
            borderRadius: BorderRadius.circular(10.0),
            elevation: 12,
            child: TextFormField(
              controller: noteController,
              keyboardType: TextInputType.text,
              maxLines: 3,
              minLines: 3,
              decoration: InputDecoration(
//                prefixIcon: Icon(Icons.note, size: 20),
                suffixIcon: Column(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.cancel,color: Colors.red,),
                      onPressed: (){
                        Provider.of<Auth>(context,listen: false).setEditNote(false);
                      },
                    ),

                    IconButton(
                      icon: Icon(Icons.check_circle,color: Colors.blue,),
                      onPressed: (){

                      },
                    ),
                  ],
                ),
                hintText: "Enter Notes",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide.none),
              ),
            ),
          ),
            ),



          ],
        );


  }



  @override
  Widget build(BuildContext context) {
    this.context=context;

    Future<GetNoteList> noteApi =  getNoteSingleApi(
      token: Provider.of<Auth>(context).getTokenFun(),
      id: id,
    );

    noteApi.then((val)  {
      noteController.text=val.body;
    });
    noteApi.catchError((val) {
//      Provider.of<Auth>(context,listen: false).setLoadingStateFun(false);

    });
    return
      SingleChildScrollView(
        child:Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10),
              child: enterNotesTextFormField(),
            ),
          ],
        ),
      );

  }
}
