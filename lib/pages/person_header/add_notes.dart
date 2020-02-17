import 'package:flutter/material.dart';
import 'package:flutter_app/api/auth.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/constants/constant.dart';
import 'package:flutter_app/pages/widgets/circularProgressBar.dart';
import 'package:flutter_app/state/app_state.dart';
import 'package:flutter_app/utilities/validation/get_size.dart';
import 'package:provider/provider.dart';

class AddNote extends StatefulWidget{
  String personId;
  AddNote({@required this.personId});
  _AddNote createState()=>_AddNote(personId);
}

class _AddNote extends State<AddNote>{

  List<EmailType> emailType = EmailType.getEmails();
  List<DropdownMenuItem<EmailType>> emailDropdownMenuItems;
  TextEditingController emailController = TextEditingController();

  EmailType selectEmail;
  String personId;
  _AddNote(this.personId);

  submitForm(){
    Provider.of<Auth>(context,listen: false).setLoadingStateFun(true);
    var token=Provider.of<Auth>(context,listen: false).getTokenFun();
    var addPhone =  addEmailApi(
        token:token ,
        personId: personId,
        type: emailType.toString(),
        address: emailController.text

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
    return Column(
      children: [
        Text(
          'Additional Notes',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
        Padding(padding: EdgeInsets.all(5)),
        Container(
          height: 150,
          child: Material(
            borderRadius: BorderRadius.circular(10.0),
            elevation: 12,
            child: TextFormField(
              // controller: nameController,
              keyboardType: TextInputType.text,
              maxLines: 10,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.note, size: 20),
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

  submitButton() {
    return RaisedButton(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      onPressed: () {
        submitForm();
      },
      textColor: Colors.white,
      padding: EdgeInsets.all(0.0),
      child: Container(
        alignment: Alignment.center,
        width: getWidth(context),
        decoration: BoxDecoration(
          color: PRIMARY_COLOR,
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          // gradient: LinearGradient(colors: [PRIMARY_COLOR, SECONDARY_COLOR]),
        ),
        padding: const EdgeInsets.all(15.0),
        child: Text(Constant.SUBMIT, style: TextStyle(fontSize: 12)),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer<Auth>(
      builder: (BuildContext context, Auth value, Widget child) =>
      value.getIsLoadingFun()==true?circularIndicator(context: context):
      Scaffold(
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

                    value.getHasErrorFun().toString().isNotEmpty==true?Text(Provider.of<Auth>(context,listen: false).getHasErrorFun(),
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ):Container(),
                    Container(
                      margin: EdgeInsets.only(left: 10, right: 10),
                      child: submitButton(),
                    ),

                  ],
                ),
              ),
            ],
          ),

        ),
      ),
    );


  }
}

