import 'package:flutter/material.dart';
import 'package:flutter_app/api/auth.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/constants/constant.dart';
import 'package:flutter_app/pages/widgets/circularProgressBar.dart';
import 'package:flutter_app/state/app_state.dart';
import 'package:provider/provider.dart';

class UpdatePhone extends StatefulWidget {
  final String id;

  UpdatePhone({@required this.id});

  _UpdatePhone createState() => _UpdatePhone(id);
}

class _UpdatePhone extends State<UpdatePhone> {
  TextEditingController phoneController = TextEditingController();
  List<DropdownMenuItem<PhoneType>> phoneDropdownMenuItems;
  PhoneType selectPhone;

  List<PhoneType> phoneType = PhoneType.getPhones();

  String id;

  _UpdatePhone(this.id) {
    this.id = id;
  }
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      Provider.of<Auth>(context, listen: false).setLoadingStateFun(false);

      Provider.of<Auth>(context, listen: false).setHasErrorFun("");
      

      phoneDropdownMenuItems = phoneBuildDropdownMenuItems(phoneType);

      Provider.of<Auth>(context, listen: false).setLoadingStateFun(true);
      var phoneApi = getSinglePhoneApi(
        token: Provider.of<Auth>(context, listen: false).getTokenFun(),
        personId: id,
      );
      phoneApi.then((val) {
        Provider.of<Auth>(context, listen: false).setLoadingStateFun(false);
        Provider.of<Auth>(context, listen: false).setHasErrorFun("");
        switch (val.type) {

            case "Home":
            setState(() {
              selectPhone = phoneDropdownMenuItems[0].value;
            });
            break;
          case "Cell":
            setState(() {
              selectPhone = phoneDropdownMenuItems[1].value;
            });
            break;
          case "Work":
            setState(() {
              selectPhone = phoneDropdownMenuItems[2].value;
            });
            break;
          case "Fax":
            setState(() {
              selectPhone = phoneDropdownMenuItems[3].value;
            });
            break;
          case "Others":
            setState(() {
              selectPhone = phoneDropdownMenuItems[4].value;
            });
            break;
        }
        phoneController.text = val.number;
      });
      phoneApi.catchError((val) {
        Provider.of<Auth>(context, listen: false).setLoadingStateFun(false);
        Provider.of<Auth>(context, listen: false)
            .setHasErrorFun(val.toString());
      });
    });
    super.initState();
  }

  submitForm() {
    Provider.of<Auth>(context, listen: false).setLoadingStateFun(true);
    var token = Provider.of<Auth>(context, listen: false).getTokenFun();
    var addPhone = updatePhoneApi(
        token: token,
        id: id,
        type: selectPhone.name,
        number: phoneController.text);

    addPhone.then((value) async {
      Provider.of<Auth>(context, listen: false)
          .setSuccessfullyRegisteredFun(true);
      Provider.of<Auth>(context, listen: false).setLoadingStateFun(false);
      Provider.of<Auth>(context, listen: false).setEditPhone(false);
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
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: IconButton(
                  icon: Icon(
                    Icons.cancel,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    Provider.of<Auth>(context, listen: false)
                        .setEditPhone(false);
                  },
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
                children: <Widget>[
                  Text(
                    'Update Phone Number',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: phoneNumberButton(),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  submitButton(),
                  value.getHasErrorFun().toString().isNotEmpty == true
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
    );
  }
}
