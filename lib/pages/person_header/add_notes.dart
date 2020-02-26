import 'package:flutter/material.dart';
import 'package:flutter_app/api/auth.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/constants/constant.dart';
import 'package:flutter_app/pages/dialog/info_dialog.dart';
import 'package:flutter_app/pages/widgets/circularProgressBar.dart';
import 'package:flutter_app/state/app_state.dart';
import 'package:flutter_app/utilities/abstract_classes/confirmation_abstract.dart';
import 'package:flutter_app/utilities/validation/get_size.dart';
import 'package:provider/provider.dart';

class AddNote extends StatefulWidget {
  String personId;

  AddNote({@required this.personId});

  _AddNote createState() => _AddNote(personId);
}

class _AddNote extends State<AddNote> implements ShouldImp {
  TextEditingController noteController = TextEditingController();

  EmailType selectEmail;
  String personId;

  _AddNote(this.personId);
  bool isApiLoaded;
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      Provider.of<Auth>(context, listen: false).setLoadingStateFun(false);
      Provider.of<Auth>(context,listen: false).setHasErrorFun("");
    });
    super.initState();
  }

  submitForm() {
    Provider.of<Auth>(context, listen: false).setLoadingStateFun(true);
    var token = Provider.of<Auth>(context, listen: false).getTokenFun();
    Provider.of<Auth>(context, listen: false).setHasErrorFun("");
    var addNote =
        addNoteApi(token: token, personId: personId, body: noteController.text);
    addNote.then((value) async {
      if(value==true) {
        Provider.of<Auth>(context, listen: false).setSuccessfullyRegisteredFun(true);
        Provider.of<Auth>(context, listen: false).setLoadingStateFun(false);
        InfoDialog(
            context: context,
            callback: _AddNote(personId),
            title: Constant.success,
            type:Constant.success
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
          type:Constant.error
      );
    });
  }

  enterNotesTextFormField() {
    return Column(
      children: <Widget>[
        Divider(),
        Text(
          'Additional Notes',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
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
                        IconButton(
                          icon: Icon(
                            Icons.check_circle,
                            color: Colors.blue,
                          ),
                          onPressed: () {
                            submitForm();
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
        )
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
