import 'package:flutter/material.dart';
import 'package:flutter_app/api/auth.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/constants/constant.dart';
import 'package:flutter_app/pages/widgets/circularProgressBar.dart';
import 'package:flutter_app/state/app_state.dart';
import 'package:flutter_app/utilities/validation/get_size.dart';
import 'package:provider/provider.dart';

class AddPhone extends StatefulWidget{
  String personId;
  AddPhone({@required this.personId});

  _AddPhone createState()=>_AddPhone(personId);
}

class _AddPhone extends State<AddPhone>{

  TextEditingController phoneController = TextEditingController();
  List<DropdownMenuItem<PhoneType>> phoneDropdownMenuItems;
  PhoneType selectPhone;

  List<PhoneType> phoneType = PhoneType.getPhones();

  String personId;
  _AddPhone(this.personId){
    print(personId);
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
      if(value==true){
        Provider.of<Auth>(context,listen: false).setSuccessfullyRegisteredFun(true);
        Provider.of<Auth>(context,listen: false).setLoadingStateFun(false);
      }

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
    return Padding(

      padding: EdgeInsets.zero,
      child: Material(
          borderRadius: BorderRadius.circular(20.0),
          elevation: 3,
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
                        underline: SizedBox(),
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
                    suffixIcon: IconButton(
                      icon: Icon(Icons.check_circle,color: Colors.blue,),
                      onPressed: (){
submitForm();
                      },
                    ),
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


  @override
  Widget build(BuildContext context) {
    return
      Consumer<Auth>(
        builder: (BuildContext context, Auth value, Widget child) =>
        value.getIsLoadingFun()==true?circularIndicator(context: context):
        SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Divider(),

                      Padding(
                        padding: EdgeInsets.all(2),
                        child: phoneNumberButton(),
                      ),

                      value.getHasErrorFun().toString().isNotEmpty==true?Text(Provider.of<Auth>(context,listen: false).getHasErrorFun(),
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ):Container(),


                    ],
                  ),
                ),
              ],
            ),

          ),
      );


  }
}

