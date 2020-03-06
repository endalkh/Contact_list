import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/api/auth.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/pages/contact_sync/contact_detail.dart';
import 'package:flutter_app/pages/contact_sync/match_contact.dart';
import 'package:flutter_app/pages/widgets/circularProgressBar.dart';
import 'package:flutter_app/state/app_state.dart';
import 'package:flutter_app/utilities/date_formater.dart';
import 'package:flutter_app/utilities/phone_prefix.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class ContactListPage extends StatefulWidget {
  _ContactListPageState createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage> {
  Iterable<Contact> _contacts;

  @override
  initState() {
    super.initState();
    refreshContacts();
  }

  savePhoneContactstoApp(_contacts) {
        Contact user = _contacts;

      Provider.of<Auth>(context, listen: false).setLoadingStateFun(true);
      var token = Provider.of<Auth>(context, listen: false).getTokenFun();
      var addNewPerson = addNewPersonApi(
        emailType: 'response',
        email: 'email',
        phoneType: 'mobile',
        phone: '+251921258848',
        fName: user.familyName,
        lName: 'Yohannes',
        birthday: '2011-11-11T00:00:00Z',
        token: token,
        // notes: addNoteController.text,
      );

      addNewPerson.then((value) {
        print('object');
      });
      addNewPerson.catchError((value) {
        print('error');

      });
  }

  refreshContacts() async {
    PermissionStatus permissionStatus = await _getContactPermission();
    if (permissionStatus == PermissionStatus.granted) {
      var contacts = await ContactsService.getContacts();
      setState(() {
        _contacts = contacts;
      });
    } else {
      _handleInvalidPermissions(permissionStatus);
    }
  }

  Future addAllContact() async {
    Provider.of<Auth>(context, listen: false).setLoadingStateFun(true);
    await Provider.of<Auth>(context, listen: false).clearContactSync();
    await phoneSyncApi(
      token: Provider.of<Auth>(context, listen: false).getTokenFun(),
    ).then((val) {
      for (int i = 0; i < val.length; i++) {
        val[i].phone.asMap().forEach((index, value) {
          var res = matchingContacts(value.number, val[i].name);
          if (res == true) {
            Provider.of<Auth>(context, listen: false).setContactSync(val[i]);
          }
        });
      }
    });
    Provider.of<Auth>(context, listen: false).setLoadingStateFun(false);
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => MatchedContactsPage()));
  }

  matchingContacts(phone, name) {
    bool result = false;
    for (int i = 0; i < _contacts.length; i++) {
      _contacts.elementAt(i).phones.forEach((f) {
        if ((_contacts.elementAt(i).displayName != name) &&
            (prefixRemover(f.value) == prefixRemover(phone)) &&
            (phone != null && phone != "")) {
          print(_contacts.elementAt(i).displayName);
          print(phone);
          print(f.value);
          print(name);
          print(" ");
          result = true;
        } else {
          result = false;
        }
      });
      if (result == true) break;
    }
    return result;
  }

  updateContact() async {
    Contact user = _contacts
        .toList()
        .firstWhere((contact) => contact.familyName.startsWith("John"));
    user.avatar = null;
    await ContactsService.updateContact(user);
    refreshContacts();
  }

  Future<PermissionStatus> _getContactPermission() async {
    PermissionStatus permission = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.contacts);
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.disabled) {
      Map<PermissionGroup, PermissionStatus> permissionStatus =
          await PermissionHandler()
              .requestPermissions([PermissionGroup.contacts]);
      return permissionStatus[PermissionGroup.contacts] ??
          PermissionStatus.unknown;
    } else {
      return permission;
    }
  }

  void _handleInvalidPermissions(PermissionStatus permissionStatus) {
    if (permissionStatus == PermissionStatus.denied) {
      throw new PlatformException(
          code: "PERMISSION_DENIED",
          message: "Access to location data denied",
          details: null);
    } else if (permissionStatus == PermissionStatus.disabled) {
      throw new PlatformException(
          code: "PERMISSION_DISABLED",
          message: "Location data is not available on device",
          details: null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Contact Sync",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => MatchedContactsPage()));
            },
            child: Icon(Icons.merge_type, color: Colors.white),
          )
        ],
      ),
      body: Provider.of<Auth>(context).getIsLoadingFun() == true
          ? circularIndicator(context: context)
          : SafeArea(
              child: _contacts != null
                  ? ListView.builder(
                      itemCount: _contacts?.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        Contact c = _contacts?.elementAt(index);
                        return Card(
                          margin: EdgeInsets.only(
                              left: 15, right: 15, bottom: 3, top: 3),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: ListTile(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      ContactDetailsPage(c)));
                            },
                            leading: (c.avatar != null && c.avatar.length > 0)
                                ? CircleAvatar(
                                    backgroundImage: MemoryImage(c.avatar))
                                : CircleAvatar(
                                    child: Text(
                                      c.initials(),
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    backgroundColor: PRIMARY_COLOR,
                                  ),
                            title: Text(c.displayName ?? ""),
                          ),
                        );
                      },
                    )
                  : Center(
                      child: circularIndicator(context: context),
                    ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          // addAllContact(),
          savePhoneContactstoApp(_contacts?.elementAt(0)),
        },
        backgroundColor: PRIMARY_COLOR,
        child: Icon(
          Icons.sync,
          color: Colors.white,
        ),
      ),
    );
  }
}
