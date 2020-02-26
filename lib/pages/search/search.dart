import 'package:flutter/material.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:loader_search_bar/loader_search_bar.dart';

class LoaderSearchBarPage extends StatefulWidget {
  _LoaderSearchBarPage createState()=>_LoaderSearchBarPage();
}

class _LoaderSearchBarPage extends State<LoaderSearchBarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchBar(
        iconified: false,
        searchItem: SearchItem.menu(
          builder: (_) => PopupMenuItem(
            child: Text("Search  🔍"),
            value: "search",
          ),
          gravity: SearchItemGravity.end,
        ),
        defaultBar: _appBar,
        searchHint: 'Search persons...',
        loader: QuerySetLoader<Person>(
          querySetCall: Person.filterPersonsByQuery,
          itemBuilder: Person.buildPersonRow,
          loadOnEachChange: true,
          animateChanges: true,
        ),
      ),
    );
  }

  AppBar get _appBar => AppBar(
leading: _leadingButton,
    title: Text('Loader example'),
  );

  Widget get _body => Container(
    color: Colors.black12,
    child: Center(
      child: Text('Iconified bar page', style: TextStyle(fontSize: 18.0)),
    ),
  );
}

Widget get _leadingButton => InkWell(
  borderRadius: BorderRadius.circular(16.0),
  child: Container(
    margin: EdgeInsets.all(12.0),
    child: Icon(Icons.menu, color: Colors.white, size: 24.0),
  ),
);


class Person {
  const Person(this.name, this.address);
  final String name;
  final String address;
  static const _tileDividerMargin = 72.0;

  static List<Person> filterPersonsByQuery(String query) {
    return persons
        .where(
            (person) => person.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  static Widget buildPersonRow(Person person) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          _buildPersonTile(person),
          _buildTileDivider(),
        ],
      ),
    );
  }

  static Widget _buildPersonTile(Person person) {
    return ListTile(
      title: Text(person.name),
      subtitle: Text(person.address),
      trailing: _buildTrailingIcons(person),
    );
  }

  static Widget _buildTrailingIcons(Person person) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildTrailingIcon(icon:Icons.delete_forever,color: Colors.red),
        _buildTrailingIcon(icon:Icons.edit,color: PRIMARY_COLOR),
      ],
    );
  }

  static Widget _buildTrailingIcon(
      {icon,double padding = 4.0,Color color}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: Icon(
        icon,
        color: color,
      ),
    );
  }

  static Widget _buildTileDivider() {
    return Container(
      margin: EdgeInsets.only(left: _tileDividerMargin),
      height: 1.0,
      color: Colors.black12,
    );
  }
  static const List<Person> persons = [
    Person('Derek Robertson',
        '8397 California St'),
    Person('Ethel Mills',
        '5050 Dogwood Ave'),
    Person('Aiden Cruz',
        '8866 W Gray St'),
    Person('Earl Ray',
        '3220 Central St'),
    Person('Arnold Bailey',
        '1809 Abby Park St'),
    Person('Evelyn Oliver',
        '3220 Central St'),
    Person('Wesley Byrd',
        '3603 W Tropical Pkwy'),
    Person('Andre Stewart',
        '5931 Railroad St'),
    Person('Denise Rose',
        '5928 Cherry St'),
    Person('Jane Morrison',
        '3499 Perfect Day Ave'),
  ];
}
