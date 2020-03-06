import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/api/model/contact_sync.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/state/app_state.dart';
import 'package:provider/provider.dart';

class MatchedContactsPage extends StatefulWidget {
  @override
  _MatchedContactsPageState createState() => _MatchedContactsPageState();
}

class _MatchedContactsPageState extends State<MatchedContactsPage> {
Iterable<Contact> _contacts;
  addToPhone(ContactSync add) {
  
    Contact contact = _contacts
        .toList()
        .firstWhere((contact) => contact.givenName.startsWith(add.name));
         contact.displayName = add.name;
    contact.phones =
        add.phone.map((f) => Item(label: f.type, value: f.number)).toList();
    contact.emails =
        add.email.map((f) => Item(label: f.type, value: f.address)).toList();
    ContactsService.updateContact(contact);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Matched Contacts",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 15),
          child: Column(
            children: <Widget>[
              Column(
                children: Provider.of<Auth>(context)
                    .getContactSync()
                    .map(
                      (i) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0.0),
                    child: Card(
                      margin: EdgeInsets.only(
                          left: 15, right: 15, bottom: 3, top: 3),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: ExpansionTile(
                        title: ListTile(
                          title: Text(
                            i.name,
                            style: TextStyle(fontSize: 19),
                          ),
                        ),
                        children: [
                          Column(
                            children: [
                              Card(
                                margin:
                                EdgeInsets.only(left: 15, right: 15),
                                elevation: 0,
                                child: ListTile(
                                  title: Row(
                                    children: [
                                      Expanded(
                                        flex: 7,
                                        child: Text("From Relate"),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          height: 30,
                                          width: 30,
                                          child: FloatingActionButton(
                                            onPressed: () => {
                                              addToPhone(i),
                                            },
                                            backgroundColor: PRIMARY_COLOR,
                                            foregroundColor: Colors.white,
                                            child:
                                            Icon(Icons.save, size: 15),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Divider(),
                              Card(
                                margin:
                                EdgeInsets.only(left: 15, right: 15),
                                elevation: 0,
                                child: ListTile(
                                  title: Row(
                                    children: [
                                      Expanded(
                                        flex: 7,
                                        child: Text("From Phone"),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          height: 30,
                                          width: 30,
                                          child: FloatingActionButton(
                                            onPressed: () => {},
                                            backgroundColor: PRIMARY_COLOR,
                                            foregroundColor: Colors.white,
                                            child:
                                            Icon(Icons.save, size: 15),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}