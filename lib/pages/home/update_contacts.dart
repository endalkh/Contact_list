import 'package:flutter/material.dart';
import 'package:flutter_app/api/auth.dart';
import 'package:flutter_app/api/model/contact_list.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/constants/constant.dart';
import 'package:flutter_app/pages/dialog/info_dialog.dart';
import 'package:flutter_app/pages/widgets/circularProgressBar.dart';
import 'package:flutter_app/state/app_state.dart';
import 'package:flutter_app/utilities/abstract_classes/confirmation_abstract.dart';
import 'package:flutter_app/utilities/date_formater.dart';
import 'package:provider/provider.dart';

class UpdateContact extends StatefulWidget{
  String id;

  UpdateContact({@required this.id});

  _UpdateContact createState()=>_UpdateContact(id: id);
}

class _UpdateContact extends State<UpdateContact> implements ShouldImp{

  TextEditingController fNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  TextEditingController birthdayController = TextEditingController();

  String id;
  _UpdateContact({this.id});
@override
  void initState() {
  Future.delayed(Duration.zero, () {
    Provider.of<Auth>(context,listen: false).setHasErrorFun("");
    Provider.of<Auth>(context, listen: false).setLoadingStateFun(true);
    Future<GetAllContact> updatePersonApi = getSingleContactApi(
      token: Provider.of<Auth>(context, listen: false).getTokenFun(),
      id: id,
    );
    updatePersonApi.then((val) async {
      Provider.of<Auth>(context, listen: false).setLoadingStateFun(false);
      birthdayController.text = dateFormatter(val.birthDate);
      fNameController.text = val.name;
    });
    updatePersonApi.catchError((val) {
      Provider.of<Auth>(context, listen: false).setLoadingStateFun(false);
      Provider.of<Auth>(context, listen: false).setHasErrorFun(val.toString());
    });
  });
    super.initState();
  }

  submitButton() {
    return
      Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child:  RawMaterialButton(
                onPressed: () {
                  Provider.of<Auth>(context, listen: false)
                      .setEditContact(false);
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

  submitForm(){
    Provider.of<Auth>(context,listen: false).setLoadingStateFun(true);
    var token=Provider.of<Auth>(context,listen: false).getTokenFun();
    var updatePerson =  updatePersonApi(
        token:token ,
        id: id,
      name: fNameController.text + " "+ lNameController.text,
      birthDate: birthdayController.text

    );

    updatePerson.then((value) async{
      Provider.of<Auth>(context,listen: false).setLoadingStateFun(false);
      InfoDialog(
          context: context,
          callback: _UpdateContact(),
          title: Constant.success,
          type:Constant.success
      );
    });

    updatePerson.catchError((value) async{
      Provider.of<Auth>(context,listen: false).setLoadingStateFun(false);
      InfoDialog(
          context: context,
          callback: _UpdateContact(),
          title: value,
          type:Constant.error
      );

    });

  }





  @override
  Widget build(BuildContext context) {
    return Consumer<Auth>(
        builder: (BuildContext context, Auth value, Widget child) =>
        value.getIsLoadingFun() == true
            ? circularIndicator(context: context)
            :
    SingleChildScrollView(
        child:Padding(
          padding: EdgeInsets.all(10),
          child:  Column(
            children: <Widget>[
              personalInformation(),
              SizedBox(height: 15,),
              submitButton(),


            ],
          ),
        ),
    ),
    );

  }

  @override
  void changer({context, id}) {
    // TODO: implement changer
  }
}
