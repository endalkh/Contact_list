import 'package:flutter/material.dart';
import 'package:flutter_app/api/auth.dart';
import 'package:flutter_app/api/model/contact_list.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/state/app_state.dart';
import 'package:loader_search_bar/loader_search_bar.dart';
import 'package:provider/provider.dart';

class LoaderSearchBarPage extends StatefulWidget {
  _LoaderSearchBarPage createState()=>_LoaderSearchBarPage();
}

class _LoaderSearchBarPage extends State<LoaderSearchBarPage> {
  List<GetAllContact> personList=[];
  bool isPerson=true;
  Widget get _leadingButton => InkWell(
    borderRadius: BorderRadius.circular(16.0),
    child: Container(
      margin: EdgeInsets.all(12.0),
      child:IconButton(
        icon:Icon(isPerson==true?Icons.person:Icons.note),
        onPressed: (){
         setState(() {
           isPerson=!isPerson;
         });
        },
        color: TRIAL_COLOR,
      ),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:

      SearchBar(
        defaultBar: AppBar(
          backgroundColor: PRIMARY_COLOR,
          iconTheme: IconThemeData(color: TRIAL_COLOR),
          leading:_leadingButton,
        ),
        iconified: true,
        searchItem: SearchItem.action(
            builder: (_) => Padding(
              padding: EdgeInsets.all(12.0),
              child:Row(
                children: <Widget>[
                  Icon(
                    Icons.search,
                    color: TRIAL_COLOR,
                  ),
                ],
              )
            ),

          gravity: SearchItemGravity.end,
        ),

        searchHint: 'Search persons...',
        loader: QuerySetLoader<GetAllContact>(

          querySetCall: filterPersonsByQuery,
          itemBuilder: buildPersonRow,
          loadOnEachChange: true,
          animateChanges: true,
        ),
      ),
    );
  }



  Widget buildPersonRow(GetAllContact person) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          _buildPersonTile(person),
          Divider(),
        ],
      ),
    );
  }

  Widget _buildPersonTile(GetAllContact person) {
    return ListTile(
      title: Text(person.name),
      subtitle: Text(person.name),
      trailing: _buildTrailingIcons(person),
    );
  }

  Widget _buildTrailingIcons(GetAllContact person) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildTrailingIcon(icon: Icons.delete_forever, color: Colors.red),
        _buildTrailingIcon(icon: Icons.edit, color: PRIMARY_COLOR),
      ],
    );
  }

  Widget _buildTrailingIcon({icon, double padding = 4.0, Color color}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: Icon(
        icon,
        color: color,
      ),
    );
  }



  List<GetAllContact> filterPersonsByQuery(String query) {
    return getList()
        .where(
            (person) => person.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

   List<GetAllContact> getList(){
        var persons= getAllContactApi(
         token: Provider.of<Auth>(context).getTokenFun()
     );
        persons.then((value){
          setState(() {
            personList=value;
          });
        });
        if(personList.length>0){
          return personList;
        }

  }

   List<GetAllContact> persons = [
     GetAllContact.fromJson({
         "id": "07f8ca74-26e1-4716-aaf7-84fa077eea00",
         "name": "endalk dasdasd",
         "birthday": "2020-11-11T00:00:00Z"
       },
     )

  ];
}
