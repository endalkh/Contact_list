import 'package:flutter/material.dart';
import 'package:flutter_app/api/auth.dart';
import 'package:flutter_app/api/model/get_email.dart';
import 'package:flutter_app/api/model/get_notes.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/constants/constant.dart';
import 'package:flutter_app/pages/dialog/confirmationDialog.dart';
import 'package:flutter_app/pages/dialog/info_dialog.dart';
import 'package:flutter_app/pages/widgets/circularProgressBar.dart';
import 'package:flutter_app/state/app_state.dart';
import 'package:flutter_app/utilities/abstract_classes/confirmation_abstract.dart';
import 'package:provider/provider.dart';

class UpdateNote extends StatefulWidget {
  String id;

  UpdateNote({@required this.id});

  _UpdateNote createState() => _UpdateNote(id);
}

class _UpdateNote extends State<UpdateNote> implements ShouldImp{
  TextEditingController noteController = TextEditingController();

  String id;
  _UpdateNote(this.id);


  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      Provider.of<Auth>(super.context, listen: false).setLoadingStateFun(false);

      Provider.of<Auth>(context,listen: false).setHasErrorFun("");

      Provider.of<Auth>(context,listen: false).setLoadingStateFun(true);
      Future<GetNoteList> noteApi = getNoteSingleApi(
        token: Provider.of<Auth>(context,listen: false).getTokenFun(),
        id: id,
      );
      noteApi.then((val) {
        noteController.text = val.body;
        Provider.of<Auth>(context,listen: false).setLoadingStateFun(false);
        Provider.of<Auth>(context,listen: false).setHasErrorFun("");

      });
      noteApi.catchError((val) {
        Provider.of<Auth>(context,listen: false).setLoadingStateFun(false);
        Provider.of<Auth>(context,listen: false).setHasErrorFun(val.toString());

      });
    });
    super.initState();
  }




  submitForm() {
    Provider.of<Auth>(context, listen: false).setLoadingStateFun(true);
    var token = Provider.of<Auth>(context, listen: false).getTokenFun();
    var updateNote = updateNoteApi(
      token: token,
      id: id,
      body: noteController.text,
    );

    updateNote.then((value)  {
      if (value == true) {
        Provider.of<Auth>(context, listen: false)
            .setSuccessfullyRegisteredFun(true);
        Provider.of<Auth>(context, listen: false).setLoadingStateFun(false);
        InfoDialog(
            context: context,
            callback: _UpdateNote(id),
            title: Constant.success,
            type:Constant.success
        );
      }
    });

    updateNote.catchError((value) async {
      Provider.of<Auth>(context, listen: false).setLoadingStateFun(false);
      Provider.of<Auth>(context, listen: false)
          .setSuccessfullyRegisteredFun(false);
      Provider.of<Auth>(context, listen: false)
          .setHasErrorFun(value.toString());
      InfoDialog(
          context: context,
          callback: _UpdateNote(id),
          title: value,
          type:Constant.error
      );
    });
  }
  submitButton() {
    return
      Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child:  RawMaterialButton(
              onPressed: () {
                submitForm();
              },
              child: new Icon(
                Icons.arrow_forward,
                color: TRIAL_COLOR,
                size: 25.0,
              ),
              shape: new CircleBorder(),
              elevation: 2.0,
              fillColor:PRIMARY_COLOR,
              padding: const EdgeInsets.all(15.0),
            ),
          )


        ],
      );

  }
  enterNotesTextFormField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Flexible(
          child: Material(
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
                      icon: Icon(
                        Icons.cancel,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        Provider.of<Auth>(context, listen: false)
                            .setEditNote(false);
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
    return
      Consumer<Auth>(
        builder: (BuildContext context, Auth value, Widget child) =>
    value.getIsLoadingFun()==true?circularIndicator(context: context):SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: enterNotesTextFormField(),
          ),
          SizedBox(height: 20,),
          submitButton(),
          value.getHasErrorFun().toString().isNotEmpty ==
              true
              ? Text(
            Provider.of<Auth>(context, listen: false)
                .getHasErrorFun(),
            style: TextStyle(
              color: Colors.red,
            ),
          )
              : Container(),
        ],
      ),
    )
    );
  }

  @override
  void changer({context, id}) {

  }


}
