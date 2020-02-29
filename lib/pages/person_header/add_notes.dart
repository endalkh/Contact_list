import 'package:flutter/material.dart';
import 'package:flutter_app/api/auth.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/constants/constant.dart';
import 'package:flutter_app/pages/dialog/info_dialog.dart';
import 'package:flutter_app/pages/widgets/circularProgressBar.dart';
import 'package:flutter_app/state/app_state.dart';
import 'package:flutter_app/utilities/abstract_classes/confirmation_abstract.dart';
import 'package:provider/provider.dart';

class AddNote extends StatefulWidget {
  final String personId;

  AddNote({@required this.personId});

  _AddNote createState() => _AddNote(personId);
}

class _AddNote extends State<AddNote> implements ShouldImp {
  TextEditingController noteController = TextEditingController();

  EmailType selectEmail;
  String personId;

  _AddNote(this.personId);
  bool showError=false;
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      Provider.of<Auth>(context, listen: false).setLoadingStateFun(false);
      Provider.of<Auth>(context,listen: false).setHasErrorFun("");
    });
    super.initState();
  }

  submitForm() {
    if (noteController.text.isEmpty == true) {
      setState(() {
        showError = true;
      });
    }
    else {
      setState(() {
        showError=false;
      });
      Provider.of<Auth>(context, listen: false).setLoadingStateFun(true);
      var token = Provider.of<Auth>(context, listen: false).getTokenFun();
      Provider.of<Auth>(context, listen: false).setHasErrorFun("");
      var addNote =
      addNoteApi(token: token, personId: personId, body: noteController.text);
      addNote.then((value) async {
        if (value == true) {
          Provider.of<Auth>(context, listen: false)
              .setSuccessfullyRegisteredFun(true);
          Provider.of<Auth>(context, listen: false).setLoadingStateFun(false);
          InfoDialog(
              context: context,
              callback: _AddNote(personId),
              title: Constant.success,
              type: Constant.success
          );
        }
      });

      addNote.catchError((value) async {
        Provider.of<Auth>(context, listen: false).setLoadingStateFun(false);
        Provider.of<Auth>(context, listen: false)
            .setSuccessfullyRegisteredFun(false);

        Provider.of<Auth>(context, listen: false)
            .setHasErrorFun(value.toString());
        InfoDialog(
            context: context,
            callback: _AddNote(personId),
            title: value.toString(),
            type: Constant.error
        );
      });
    }
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
    return Column(
      children: <Widget>[
        Text(
          'Additional Notes',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
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
                  decoration: InputDecoration(
//                prefixIcon: Icon(Icons.note, size: 20),
                    suffixIcon: Column(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            Icons.clear,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            noteController.clear();
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
        ),
        SizedBox(height: 10,),
        showError==true?Text(
          "Note field is required!",style: TextStyle(color: Colors.red),
        ):Container(),
        SizedBox(height: 20,),
        submitButton(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer<Auth>(
      builder: (BuildContext context, Auth value, Widget child) =>
          value.getIsLoadingFun() == true
              ? circularIndicator(context: context)
              : Scaffold(
                  body: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: enterNotesTextFormField(),
                              ),
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
                        ),

                      ],
                    ),
                  ),
                ),
    );
  }

  @override
  void changer({context, id}) {

  }
}
