import 'package:flutter/material.dart';
import 'package:flutter_app/api/auth.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/constants/constant.dart';
import 'package:flutter_app/pages/widgets/circularProgressBar.dart';
import 'package:flutter_app/state/app_state.dart';
import 'package:flutter_app/utilities/validation/get_size.dart';
import 'package:provider/provider.dart';

class UpdateEmail extends StatefulWidget{
  String personId;
  UpdateEmail({@required this.personId});

  _UpdateEmail createState()=>_UpdateEmail(personId);
}

class _UpdateEmail extends State<UpdateEmail>{

  TextEditingController phoneController = TextEditingController();
  List<DropdownMenuItem<PhoneType>> phoneDropdownMenuItems;
  PhoneType selectPhone;

  List<PhoneType> phoneType = PhoneType.getPhones();

  String personId;
  _UpdateEmail(this.personId){
    this.personId=personId;
  }


  @override
  void initState() {
    phoneDropdownMenuItems = phoneBuildDropdownMenuItems(phoneType);
    selectPhone = phoneDropdownMenuItems[0].value;
    super.initState();
  }
  submitForm(){
    Provider.of<Auth>(context,listen: false).setLoadingStateFun(true);
    var token=Provider.of<Auth>(context,listen: false).getTokenFun();
    var addPhone =  addPhoneApi(
        token:token ,
        personId: personId,
        type: phoneType.toString(),
        number: phoneController.text

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

  List<DropdownMenuItem<PhoneType>> phoneBuildDropdownMenuItems(
      List phoneTypes) {
    List<DropdownMenuItem<PhoneType>> items = List();
    for (PhoneType phoneType in phoneTypes) {
      items.add(
        DropdownMenuItem(
          value: phoneType,
          child: Text(phoneType.name),
        ),
      );
    }
    return items;
  }


  phoneOnChangeDropdownItem(PhoneType phone) {
    setState(() {
      selectPhone = phone;
    });
  }



  phoneNumberButton() {
    return Container(
      height: 55,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Material(
          borderRadius: BorderRadius.circular(10.0),
          elevation: 12,
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DropdownButton(
                        value: selectPhone,
                        items: phoneDropdownMenuItems,
                        onChanged: phoneOnChangeDropdownItem,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: TextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(

                    hintText: "+1(424) 341-3346",

                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none),
                  ),
                ),
              )
            ],
          )),
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
    return
      Consumer<Auth>(
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
                        child: phoneNumberButton(),
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
          floatingActionButton: FloatingActionButton(
            onPressed: () => {
              Provider.of<Auth>(context,listen: false).setEditPhone(false)
            },
            backgroundColor: PRIMARY_COLOR,
            child: Icon(
              Icons.contacts,
              color: lightBG,
            ),
          ),
        ),

      );

  }
}

