import 'package:flutter/material.dart';
import 'package:flutter_app/api/auth.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/constants/constant.dart';
import 'package:flutter_app/pages/dialog/info_dialog.dart';
import 'package:flutter_app/pages/widgets/circularProgressBar.dart';
import 'package:flutter_app/state/app_state.dart';
import 'package:flutter_app/utilities/abstract_classes/confirmation_abstract.dart';
import 'package:flutter_app/utilities/validation/Validation.dart';
import 'package:provider/provider.dart';

class AddPhone extends StatefulWidget {
  final String personId;
  AddPhone({@required this.personId});

  _AddPhone createState() => _AddPhone(personId);
}

class _AddPhone extends State<AddPhone> implements ShouldImp {
  TextEditingController phoneController = TextEditingController();
  List<DropdownMenuItem<PhoneType>> phoneDropdownMenuItems;
  PhoneType selectPhone;

  List<PhoneType> phoneType = PhoneType.getPhones();

  String personId;
  bool showError = false;
  _AddPhone(this.personId);

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      Provider.of<Auth>(context, listen: false).setLoadingStateFun(false);
      Provider.of<Auth>(context, listen: false).setHasErrorFun("");
      phoneDropdownMenuItems = phoneBuildDropdownMenuItems(phoneType);
      selectPhone = phoneDropdownMenuItems[0].value;
    });
    super.initState();
  }

  submitForm() {
    if (validatePhone(phoneController.text).toString().isNotEmpty == true) {
      setState(() {
        showError = true;
      });
    } else {
      setState(() {
        showError = false;
      });
      Provider.of<Auth>(context, listen: false).setLoadingStateFun(true);
      Provider.of<Auth>(context, listen: false).setHasErrorFun("");
      var token = Provider.of<Auth>(context, listen: false).getTokenFun();
      var addPhone = addPhoneApi(
          token: token,
          personId: personId,
          type: selectPhone.name,
          number: phoneController.text);
      addPhone.then((value) {
        if (value == true) {
          Provider.of<Auth>(context, listen: false).setLoadingStateFun(false);
          Provider.of<Auth>(context, listen: false).setAddPhone(false);
        }
      });

      addPhone.catchError((value) async {
        Provider.of<Auth>(context, listen: false).setLoadingStateFun(false);
        Provider.of<Auth>(context, listen: false)
            .setSuccessfullyRegisteredFun(false);
        InfoDialog(
            context: context,
            callback: _AddPhone(personId),
            title: value.toString(),
            type: Constant.error);
      });
    }
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
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: RawMaterialButton(
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
            fillColor: PRIMARY_COLOR,
            padding: const EdgeInsets.all(15.0),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Auth>(
      builder: (BuildContext context, Auth value, Widget child) => value
                  .getIsLoadingFun() ==
              true
          ? circularIndicator(context: context)
          : SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    'Additional Phone Number',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(2),
                          child: phoneNumberButton(),
                        ),
                        showError == true &&
                                validatePhone(phoneController.text)
                                        .toString()
                                        .isNotEmpty ==
                                    true
                            ? Text(
                                validatePhone(phoneController.text),
                                style: TextStyle(color: Colors.red),
                              )
                            : Container(),
                        SizedBox(
                          height: 5,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  submitButton(),
                ],
              ),
            ),
    );
  }

  @override
  void changer({context, id}) {}
}
