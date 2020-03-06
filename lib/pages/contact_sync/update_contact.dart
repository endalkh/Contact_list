import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/pages/contact_sync/contact_page.dart';

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
                  // onSaved: (v) => contact.middleName = v,
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
