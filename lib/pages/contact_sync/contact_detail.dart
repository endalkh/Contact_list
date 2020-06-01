import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/pages/contact_sync/contact_page.dart';
import 'package:flutter_app/pages/contact_sync/items_tile.dart';
import 'package:flutter_app/pages/contact_sync/update_contact.dart';

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
              onPressed: () => ContactsService.deleteContact(_contact).then(
                    (_) {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => ContactListPage()));
                },
              )),
          IconButton(
            color: Colors.white,
            icon: Icon(Icons.update),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => UpdateContactsPage(
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