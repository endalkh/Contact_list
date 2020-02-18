import 'package:flutter/material.dart';
import 'package:flutter_app/api/auth.dart';
import 'package:flutter_app/api/model/get_phone.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/constants/constant.dart';
import 'package:flutter_app/state/app_state.dart';
import 'package:flutter_app/utilities/validation/get_size.dart';
import 'package:provider/provider.dart';

class UpdatePhone extends StatefulWidget {
  String id;

  UpdatePhone({@required this.id});

  _UpdatePhone createState() => _UpdatePhone(id);
}

class _UpdatePhone extends State<UpdatePhone> {
  TextEditingController phoneController = TextEditingController();
  List<DropdownMenuItem<PhoneType>> phoneDropdownMenuItems;
  PhoneType selectPhone;
  BuildContext context;

  List<PhoneType> phoneType = PhoneType.getPhones();

  String id;

  _UpdatePhone(this.id) {
    this.id = id;
  }


  @override
  void dispose(){
    phoneController.dispose();
    super.dispose();
  }

  submitForm() {
    Provider.of<Auth>(context, listen: false).setLoadingStateFun(true);
    var token = Provider.of<Auth>(context, listen: false).getTokenFun();
    var addPhone = addPhoneApi(
        token: token,
        personId: id,
        type: phoneType.toString(),
        number: phoneController.text);
    addPhone.then((value) async {
      Provider.of<Auth>(context, listen: false)
          .setSuccessfullyRegisteredFun(true);
      Provider.of<Auth>(context, listen: false).setLoadingStateFun(false);
    });

    addPhone.catchError((value) async {
      Provider.of<Auth>(context, listen: false).setLoadingStateFun(false);
      Provider.of<Auth>(context, listen: false)
          .setSuccessfullyRegisteredFun(false);
      Provider.of<Auth>(context, listen: false)
          .setHasErrorFun(value.toString());
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
                    suffixIcon: IconButton(
                          icon: Icon(Icons.check_circle,color: Colors.blue),
                          onPressed: (){


                          },

                        ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: IconButton(
                  icon: Icon(Icons.cancel,color: Colors.red,),
                  onPressed: (){
                    Provider.of<Auth>(context,listen: false).setEditPhone(false);
                  },
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


this.context=context;

    phoneDropdownMenuItems = phoneBuildDropdownMenuItems(phoneType);
    Future<GetPhone> phoneApi =  getSinglePhoneApi(
      token: Provider.of<Auth>(context).getTokenFun(),
      personId: id,
    );

    phoneApi.then((val)  {
      switch (val.type.toString()) {
        case "Mobile":
          setState(() {
            selectPhone = phoneDropdownMenuItems[0].value;

          });
          break;
        case "Home":
          setState(() {
            selectPhone = phoneDropdownMenuItems[0].value;

          });
          break;
        case "Work":
          setState(() {
            selectPhone = phoneDropdownMenuItems[0].value;

          });
          break;
        case "Fax":
          setState(() {
            selectPhone = phoneDropdownMenuItems[0].value;

          });
          break;
        case "Line":
          setState(() {
            selectPhone = phoneDropdownMenuItems[0].value;

          });
          break;

      }
      phoneController.text=val.number;
    });
    phoneApi.catchError((val) {
//      Provider.of<Auth>(context,listen: false).setLoadingStateFun(false);
    });

    return SingleChildScrollView(
        child:Column(
children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
                    child: phoneNumberButton(),
                  ),
        ],
    ),
    );


  }
}
