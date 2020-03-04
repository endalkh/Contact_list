import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/api/auth.dart';
import 'package:flutter_app/api/model/contact_sync.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/pages/appbar/AppBar.dart';
import 'package:flutter_app/pages/widgets/circularProgressBar.dart';
import 'package:flutter_app/state/app_state.dart';
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

  addAllContact() async{
    print("clicked");
           var contactSync= phoneSyncApi(
          token: Provider.of<Auth>(context,listen: false).getTokenFun(),
        );
      contactSync.then((val){
     for(int i=0;i<val.length;i++){
       print(val[i].name);
       print(" ");
       val[i].phone.asMap().forEach((index,value){
         print(value.number);
       });

       print(" ");
     }
          });

  }

  updateContact() async {
    Contact user = _contacts
        .toList()
        .firstWhere((contact) => contact.familyName.startsWith("John"));
    user.avatar = null;
    await ContactsService.updateContact(user);
    refreshContacts();
  }

  matchingContacts() {


  }

  syncronizationApptoPhone() {
  Contact contact = Contact();

  }
  syncronizationPhonetoApp() {
    
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
      appBar: headerNav(title: "Contact Sync", context: context),
      body: SafeArea(
        child: _contacts != null
            ? ListView.builder(
          itemCount: _contacts?.length ?? 0,
          itemBuilder: (BuildContext context, int index) {
            Contact c = _contacts?.elementAt(index);
            return Card(
              margin:
              EdgeInsets.only(left: 15, right: 15, bottom: 3, top: 3),
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
                    ? CircleAvatar(backgroundImage: MemoryImage(c.avatar))
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
          },
          backgroundColor: PRIMARY_COLOR,
          child: Icon(Icons.add),
        )
    );
  }
}

class AddContactPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddContactPageState();
}

class _AddContactPageState extends State<AddContactPage> {

  Contact contact = Contact();
  PostalAddress address = PostalAddress(label: "Home");
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add a contact"),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              _formKey.currentState.save();
              contact.postalAddresses = [address];
              ContactsService.addContact(contact);
              Navigator.of(context).pop();
            },
            child: Icon(Icons.save, color: Colors.white),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(12.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(labelText: 'First name'),
                onSaved: (v) => contact.givenName = v,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Middle name'),
                onSaved: (v) => contact.middleName = v,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Last name'),
                onSaved: (v) => contact.familyName = v,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Phone'),
                onSaved: (v) =>
                contact.phones = [Item(label: "mobile", value: v)],
                keyboardType: TextInputType.phone,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'E-mail'),
                onSaved: (v) =>
                contact.emails = [Item(label: "work", value: v)],
                keyboardType: TextInputType.emailAddress,
              ),
            ],
          ),
        ),
      ),
    );
  }

}

class ContactDetailsPage extends StatelessWidget {
  ContactDetailsPage(this._contact);

  final Contact _contact;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_contact.displayName ?? "",
            style: TextStyle(fontWeight: FontWeight.w400, color: Colors.white)),
        actions: <Widget>[
          IconButton(
              color: Colors.white,
              icon: Icon(Icons.delete),
              onPressed: () =>
                  ContactsService.deleteContact(_contact).then(
                        (_) {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => ContactListPage()));
                    },
                  )),
          IconButton(
            color: Colors.white,
            icon: Icon(Icons.update),
            onPressed: () =>
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        UpdateContactsPage(
                          contact: _contact,
                        ),
                  ),
                ),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 20, top: 10, bottom: 10),
              child: Text(
                "Personal Informations",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
              ),
            ),
            Card(
              margin: EdgeInsets.only(left: 15, right: 15, bottom: 3, top: 3),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: ListTile(
                title: Text("Name"),
                trailing: Text(_contact.givenName ?? '--'),
              ),
            ),
            Card(
              margin: EdgeInsets.only(left: 15, right: 15, bottom: 3, top: 3),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: ListTile(
                title: Text("MiddleName"),
                trailing: Text(_contact.middleName ?? "--"),
              ),
            ),
            Card(
              margin: EdgeInsets.only(left: 15, right: 15, bottom: 3, top: 3),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: ListTile(
                title: Text("Family name"),
                trailing: Text(_contact.familyName ?? "--"),
              ),
            ),
            // AddressesTile(_contact.postalAddresses),
            ItemsTile("Phones", _contact.phones),
            ItemsTile("Emails", _contact.emails)
          ],
        ),
      ),
    );
  }
}

class ItemsTile extends StatelessWidget {
  ItemsTile(this._title, this._items);

  final Iterable<Item> _items;
  final String _title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 20),
          child: Text(
            this._title,
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
          ),
        ),
        Column(
          children: _items
              .map(
                (i) =>
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: ListTile(
                      title: Text(i.label ?? "--"),
                      trailing: Text(i.value ?? "--"),
                    ),
                  ),
                ),
          )
              .toList(),
        ),
      ],
    );
  }
}

class UpdateContactsPage extends StatefulWidget {
  UpdateContactsPage({@required this.contact});

  final Contact contact;

  @override
  _UpdateContactsPageState createState() => _UpdateContactsPageState();
}

class _UpdateContactsPageState extends State<UpdateContactsPage> {
  Contact contact;
  PostalAddress address = PostalAddress(label: "Home");
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    contact = widget.contact;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text(
          "Update Contact",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.save,
              color: Colors.white,
            ),
            onPressed: () async {
              _formKey.currentState.save();
              contact.postalAddresses = [address];
              await ContactsService.updateContact(contact).then((_) {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => ContactListPage()));
              });
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(12.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 30,
              ),
              Material(
                borderRadius: BorderRadius.circular(10.0),
                elevation: 12,
                child: TextFormField(
                  // controller: fNameController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person, size: 20),
                    hintText: "First Name",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none),
                  ),
                  initialValue: contact.givenName ?? "",
                  onSaved: (v) => contact.givenName = v,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Material(
                borderRadius: BorderRadius.circular(10.0),
                elevation: 12,
                child: TextFormField(
                  // controller: fNameController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person, size: 20),
                    hintText: "Middle Name",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none),
                  ),
                  initialValue: contact.middleName ?? "",
                  onSaved: (v) => contact.middleName = v,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Material(
                borderRadius: BorderRadius.circular(10.0),
                elevation: 12,
                child: TextFormField(
                  // controller: fNameController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person, size: 20),
                    hintText: "Last Name",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none),
                  ),
                  initialValue: contact.familyName ?? "",
                  onSaved: (v) => contact.familyName = v,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Material(
                borderRadius: BorderRadius.circular(10.0),
                elevation: 12,
                child: TextFormField(
                  // controller: fNameController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person, size: 20),
                    hintText: "Phone",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none),
                  ),
                  initialValue: contact.suffix ?? "",
                  onSaved: (v) =>
                  contact.phones = [Item(label: "mobile", value: v)],
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }
}
