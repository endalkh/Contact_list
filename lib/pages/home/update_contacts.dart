import 'package:flutter/material.dart';
import 'package:flutter_app/api/auth.dart';
import 'package:flutter_app/api/model/contact_list.dart';
import 'package:flutter_app/api/model/get_notes.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/constants/constant.dart';
import 'package:flutter_app/state/app_state.dart';
import 'package:flutter_app/utilities/date_formater.dart';
import 'package:flutter_app/utilities/round_letter_getter/get_round_letter.dart';
import 'package:flutter_app/utilities/validation/get_size.dart';
import 'package:provider/provider.dart';
import 'package:rounded_letter/rounded_letter.dart';
import 'package:rounded_letter/shape_type.dart';

class UpdateContact extends StatefulWidget{
  String id;

  UpdateContact({@required this.id});

  _UpdateContact createState()=>_UpdateContact(id);
}

class _UpdateContact extends State<UpdateContact>{


  TextEditingController fNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  TextEditingController birthdayController = TextEditingController();
  BuildContext context;


  String id;
  _UpdateContact(this.id){
    this.id=id;
  }
  submitButton() {
    return
      Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child:  RawMaterialButton(
                onPressed: () {
                  Provider.of<Auth>(context,listen: false).setEditContact(false);
                },
                child: new Icon(
                  Icons.cancel,
                  color: TRIAL_COLOR,
                  size: 25.0,
                ),
                shape: new CircleBorder(),
                elevation: 2.0,
                fillColor:Colors.red,
                padding: const EdgeInsets.all(15.0),
              ),
            ),
            Expanded(
              flex: 1,
              child:  RawMaterialButton(
                onPressed: () {

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
  personalInformation() {
    return Column(
      children: [
        RawMaterialButton(
          child: new Icon(
            Icons.edit,
            color: TRIAL_COLOR,
            size: 35.0,
          ),
          shape: new CircleBorder(),
          elevation: 2.0,
          fillColor:PRIMARY_COLOR,
          padding: const EdgeInsets.all(15.0),
        ),



        SizedBox(height: 15,),
        Consumer<Auth>(
          builder: (BuildContext context, Auth value, Widget child) =>
          value.getSuccessfullyRegisteredFun()==true?Text("Your data successfully updated!",
              style: TextStyle(color: Colors.green)):value.hasError.isNotEmpty==true?
          Text(value.getHasErrorFun(),
              style: TextStyle(color: Colors.red)):Container(),
        ),
        SizedBox(height: 10,),

        Material(
          borderRadius: BorderRadius.circular(10.0),
          elevation: 12,
          child: TextFormField(
            controller: fNameController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.person, size: 20),
              hintText: "First Name",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none),
            ),
          ),
        ),

        SizedBox(height: 10,),
        Material(
          borderRadius: BorderRadius.circular(10.0),
          elevation: 12,
          child: TextFormField(
            controller: birthdayController,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.timer, size: 20),
              hintText: "Date of Birth",

              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none),
            ),

            onTap: () async {
              DateTime date = DateTime(1900);
              FocusScope.of(context).requestFocus(new FocusNode());

              date = await showDatePicker(
                  context: context,
                  initialDate: Constant.initialDate.dateTime.toUtc(),
                  firstDate: Constant.initialDate.dateTime.toUtc(),
                  lastDate: Constant.finalDate.dateTime.toUtc()
              );
              birthdayController.text = date.toUtc().toIso8601String();
            },
          ),

        ),
        Padding(padding: EdgeInsets.all(5)),



      ],
    );
  }

//  submitForm(){
//    Provider.of<Auth>(context,listen: false).setLoadingStateFun(true);
//    var token=Provider.of<Auth>(context,listen: false).getTokenFun();
//    var addPhone =  addEmailApi(
//        token:token ,
//        personId: id,
//        type: noteController.toString(),
//        address: noteController.text
//    );
//
//    addPhone.then((value) async{
//      Provider.of<Auth>(context,listen: false).setSuccessfullyRegisteredFun(true);
//      Provider.of<Auth>(context,listen: false).setLoadingStateFun(false);
//    });
//
//    addPhone.catchError((value) async{
//      Provider.of<Auth>(context,listen: false).setLoadingStateFun(false);
//      Provider.of<Auth>(context,listen: false).setSuccessfullyRegisteredFun(false);
//      Provider.of<Auth>(context,listen: false).setHasErrorFun(value.toString());
//
//    });
//
//  }





  @override
  Widget build(BuildContext context) {
    this.context=context;

    Future<GetAllContact> noteApi =  getSingleContactApi(
      token: Provider.of<Auth>(context).getTokenFun(),
      id: id,
    );

    noteApi.then((val)  {
birthdayController.text=dateFormatter(val.birthDate);
fNameController.text=val.name;
    });
    noteApi.catchError((val) {
//      Provider.of<Auth>(context,listen: false).setLoadingStateFun(false);

    });
    return SingleChildScrollView(
        child:Padding(
          padding: EdgeInsets.all(10),
          child:  Column(
            children: <Widget>[
              personalInformation(),
              SizedBox(height: 15,),
              submitButton(),

            ],
          ),
        )

      );

  }
}
