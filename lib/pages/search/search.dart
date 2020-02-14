import 'package:flutter/material.dart';
import 'package:flutter_app/pages/search/search_result.dart';

class Search{

final _names =  [
'Igor Minar',
'Brad Green',
'Dave Geddes',
'Naomi Black',
'Greg Weber',
'Dean Sofer',
'Wes Alvaro',
'John Scott',
'Daniel Nadasi',
];



_buildMaterialSearchPage(BuildContext context) {
return new MaterialPageRoute<String>(
settings: new RouteSettings(
name: 'material_search',
isInitialRoute: false,
),
builder: (BuildContext context) {
return  Material(
child:  MaterialSearch<String>(
placeholder: 'Search',
results: _names.map((String v) => new MaterialSearchResult<String>(
icon: Icons.person,
value: v,
text: "Mr(s). $v",
)).toList(),
filter: (dynamic value, String criteria) {
return value.toLowerCase().trim()
    .contains(new RegExp(r'' + criteria.toLowerCase().trim() + ''));
},
onSelect: (dynamic value) => Navigator.of(context).pop(value),
onSubmit: (String value) => Navigator.of(context).pop(value),
),

);
}//        primarySwatch: Colors.blue,
);
}
Search(context) {
Navigator.of(context)
    .push(_buildMaterialSearchPage(context))
    .then((dynamic value) {
//        setState(() => _name = value as String);
});

}
}