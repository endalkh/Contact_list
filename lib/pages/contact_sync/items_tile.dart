import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';

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
                (i) => Padding(
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