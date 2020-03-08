import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/api/auth.dart';
import 'package:flutter_app/api/model/contact_sync.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/pages/contact_sync/contact_detail.dart';
import 'package:flutter_app/pages/contact_sync/match_contact.dart';
import 'package:flutter_app/pages/slider/slider.dart';
import 'package:flutter_app/pages/widgets/circularProgressBar.dart';
import 'package:flutter_app/state/app_state.dart';
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

    String type, phone;
    for (int i = 0; i < user.phones.length; i++) {
      phone = user.phones.elementAt(i).value;
      type = user.phones.elementAt(i).label;
      break;
    }
    Provider.of<Auth>(context, listen: false).setLoadingStateFun(true);
    var token = Provider.of<Auth>(context, listen: false).getTokenFun();
    var addNewPerson = addNewPersonApi(
      emailType: 'response',
      email: 'email',
      phoneType: type,
      phone: phone,
      fName: user.familyName,
      lName: user.givenName,
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
        _contacts = contacts != null ? contacts : [];
      });
    } else {
      _handleInvalidPermissions(permissionStatus);
    }
  }

  Future addAllContact() async {
    Contact contact = new Contact();
    var cons = await ContactsService.getContacts();

    _contacts=  cons!=null?cons:[];

    Provider.of<Auth>(context, listen: false).setLoadingStateFun(true);
    await Provider.of<Auth>(context, listen: false).clearContactSync();
    phoneSyncApi(
      token: Provider.of<Auth>(context, listen: false).getTokenFun(),
    ).then((List<ContactSync> val) {
      int res;

      Provider.of<Auth>(context, listen: false).clearContactSync();

      for (int i = 0; i < val.length; i++) {
        for (int j = 0; j < val[i].phone.asMap().length; j++) {
          res = matchingContacts(val[i].phone[j].number, val[i].name);
          if (res == 0) {
            Provider.of<Auth>(context, listen: false).setContactSync(val[i]);
            break;
          }

          if (res == 1) {

            break;
          }



        }
        if(res==-1){
          contact.displayName = val[i].name;
          contact.givenName = val[i].name;
          contact.birthday = DateTime.parse('2011-11-11T00:00:00Z');
          contact.phones = val[i]
              .phone
              .map((f) => Item(label: f.type, value: f.number))
              .toList();
          contact.emails = val[i]
              .email
              .map((f) => Item(label: f.type, value: f.address))
              .toList();
          ContactsService.addContact(contact);
        }
      }
    });
    Provider.of<Auth>(context, listen: false).setLoadingStateFun(false);
    if(Provider.of<Auth>(context, listen: false).getContactSync().length>0) {
      Navigator.push(
          context,
          SlideLeftRoute(
              page: MatchedContactsPage(
              )));

    }
  }

  matchingContacts(phone, name) {
    int result;
    if(phone==null|| phone==""){
      result=-1;
    }
    else {
      for (int i = 0; i < _contacts.length; i++) {
        for (int j = 0; j < _contacts.elementAt(i).phones.length; j++) {
          if (prefixRemover(_contacts.elementAt(i).phones.elementAt(j).value) == prefixRemover(phone)) {

            if (name != _contacts.elementAt(i).displayName) {
              result = 0;
              break;
            }
            else if (name == _contacts
                .elementAt(i)
                .displayName) {
              result = 1;
              break;
            }
          }
          else {
            result = -1;
          }
        }

        if (result == 0 || result == 1) break;
      }
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

  _handleInvalidPermissions(PermissionStatus permissionStatus) {
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
          addAllContact(),
          // savePhoneContactstoApp(_contacts?.elementAt(0)),
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
