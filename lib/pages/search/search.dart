import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/api/auth.dart';
import 'package:flutter_app/api/model/contact_list.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/constants/constant.dart';
import 'package:flutter_app/pages/dialog/confirmationDialog.dart';
import 'package:flutter_app/pages/dialog/info_dialog.dart';
import 'package:flutter_app/pages/dialog/loading_dialog.dart';
import 'package:flutter_app/pages/person_header/person_header.dart';
import 'package:flutter_app/state/app_state.dart';
import 'package:flutter_app/utilities/abstract_classes/confirmation_abstract.dart';
import 'package:flutter_app/utilities/date_formater.dart';
import 'package:loader_search_bar/loader_search_bar.dart';
import 'package:provider/provider.dart';

//class MaterialSearch extends StatelessWidget implements ShouldImp {
//  BuildContext cxt;
//
//  @override
//  Widget build(BuildContext context) {
//    this.cxt = context;
//    return Scaffold(
//      appBar: SearchBar(
//        autoActive: AutoActive.on,
//        defaultBar: AppBar(
//          automaticallyImplyLeading: true,
//          backgroundColor: PRIMARY_COLOR,
//          iconTheme: IconThemeData(color: TRIAL_COLOR),
//        ),
//        iconified: true,
//        searchItem: SearchItem.action(builder: (_) {
//          return Padding(
//            padding: EdgeInsets.all(12.0),
//            child: Icon(
//              Icons.search,
//              color: TRIAL_COLOR,
//            ),
//          );
//        }),
//        searchHint: 'Search persons...',
//        loader: QuerySetLoader<GetAllContact>(
//          querySetCall: filterPersonsByQueryPerson,
//          itemBuilder: buildPersonRow,
//          loadOnEachChange: true,
//          animateChanges: true,
//        ),
//      ),
//    );
//  }
//
//  SearchBar materialSearch({context, String title}) {
//    return SearchBar(
//        defaultBar: AppBar(
//          automaticallyImplyLeading: true,
//          backgroundColor: PRIMARY_COLOR,
//          iconTheme: IconThemeData(color: TRIAL_COLOR),
//          actions: <Widget>[
//            IconButton(
//              icon: Icon(
//                  Provider.of<Auth>(context, listen: false).getIsPerson() ==
//                          true
//                      ? Icons.person
//                      : Icons.note),
//              onPressed: () {
//                Provider.of<Auth>(context, listen: false).setIsPerson(
//                    !Provider.of<Auth>(context, listen: false).getIsPerson());
//              },
//              color: TRIAL_COLOR,
//            ),
//          ],
//        ),
//        iconified: true,
//        searchItem: SearchItem.action(builder: (_) {
//          return Padding(
//            padding: EdgeInsets.all(12.0),
//            child: Icon(
//              Icons.search,
//              color: TRIAL_COLOR,
//            ),
//          );
//        }),
//        searchHint: 'Search persons...',
//        loader: QuerySetLoader<GetAllContact>(
//          querySetCall: filterPersonsByQueryPerson,
//          itemBuilder: buildPersonRow,
//          loadOnEachChange: true,
//          animateChanges: true,
//        ));
//  }
//
//  List<GetAllContact> filterPersonsByQueryPerson(String query) {
//    return getList()
//        .where(
//            (person) => person.name.toLowerCase().contains(query.toLowerCase()))
//        .toList();
//  }
//
//  List<GetAllContact> getList() {
//    var persons = getAllContactApi(
//      token: Provider.of<Auth>(cxt, listen: false).getTokenFun(),
//    );
//    persons.then((value) {
//      Provider.of<Auth>(cxt, listen: false).setPersonList(value);
//    });
//
//    if (Provider.of<Auth>(cxt, listen: false)
//            .getPersonList()
//            .toString()
//            .length >
//        0) {
//      return Provider.of<Auth>(cxt, listen: false).getPersonList();
//    } else
//      return null;
//  }
//
//  Widget buildPersonRow(GetAllContact person) {
//    return Container(
//      color: Colors.white,
//      child: Column(
//        children: [
//          _buildPersonTile(person),
//          Divider(),
//        ],
//      ),
//    );
//  }
//
//  Widget _buildPersonTile(GetAllContact person) {
//    return ListTile(
//      onTap: () {
//        Provider.of<Auth>(cxt, listen: false).setAutoActive(AutoActive.off);
//        Navigator.push(
//          cxt,
//          MaterialPageRoute(
//              builder: (context) => PersonHeaderScreen(
//                    personId: person.id,
//                  )),
//        );
//      },
//      title: Text(person.name),
//      subtitle: Text(dateFormatter(person.birthDate)),
//      trailing: _buildTrailingIcons(person),
//    );
//  }
//
//  Widget _buildTrailingIcons(GetAllContact person) {
//    return Row(
//      mainAxisAlignment: MainAxisAlignment.end,
//      mainAxisSize: MainAxisSize.min,
//      children: [
//        Padding(
//            padding: EdgeInsets.symmetric(horizontal: 72),
//            child: IconButton(
//              icon: Icon(Icons.delete_forever, color: Colors.red),
//            )),
//        Padding(
//            padding: EdgeInsets.symmetric(horizontal: 72),
//            child: IconButton(
//              icon: Icon(Icons.delete_forever, color: Colors.red),
//            )),
//      ],
//    );
//  }
//
//
//  @override
//  void changer({context, id}) {
//    Provider.of<Auth>(context, listen: false).setLoadingStateFun(true);
//    var token = Provider.of<Auth>(context, listen: false).getTokenFun();
//    var deleteNote = deletePersonApi(
//      id: id,
//      token: token,
//    );
//
//    LoadingDialog(context: context, title: "please wait.....");
//
//    deleteNote.then((value) async {
//      if (value == true) {
//        Navigator.of(context).pop();
//        Provider.of<Auth>(context, listen: false).setLoadingStateFun(false);
//        InfoDialog(
//            context: context,
//            callback: MaterialSearch(),
//            title: Constant.success,
//            type: Constant.success);
//      }
//    });
//
//    deleteNote.catchError((value) async {
//      Provider.of<Auth>(context, listen: false).setLoadingStateFun(false);
//      InfoDialog(
//          context: context,
//          callback: MaterialSearch(),
//          title: Constant.error,
//          type: Constant.error);
//    });
////    Navigator.pop(context);
//  }
//}
class MaterialSearch  implements ShouldImp {
  BuildContext cxt;


  SearchBar materialSearch({context,String title}) {
    cxt=context;
    return SearchBar(

      defaultBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(color: TRIAL_COLOR),
      ),
      iconified: true,

      searchItem: SearchItem.action(
          builder: (_) {
            return Padding(
              padding: EdgeInsets.all(12.0),
              child: Icon(
                Icons.search,
                color: TRIAL_COLOR,
              ),
            );
          }
      ),
      searchHint: 'Search persons...',
      loader: QuerySetLoader<GetAllContact>(
        querySetCall: filterPersonsByQueryPerson,
        itemBuilder: buildPersonRow,
        loadOnEachChange: true,
        animateChanges: true,
      ),
      onQueryChanged: queryChanged,
    );

  }
queryChanged(query) async{
  await searchApi(
    token: Provider.of<Auth>(cxt, listen: false).getTokenFun(),
    query: query,
    context: cxt,
  ).then((val) {
    Provider.of<Auth>(cxt, listen: false).setPersonList(val);
  }).catchError((onError){
    print("hello error");
  });

}


  List<GetAllContact> filterPersonsByQueryPerson(String query) {

    if (query.length > 0) {
      return Provider.of<Auth>(cxt, listen: false).getPersonList();
    }



  }
//  List<GetAllContact> getList() {
//    if (Provider
//        .of<Auth>(cxt, listen: false)
//        .getPersonList()
//        .toString()
//        .length > 0) {
//
//      return Provider.of<Auth>(cxt, listen: false).getPersonList();
//    }
//    else
//      return null;
//  }


  Widget buildPersonRow(GetAllContact person) {
    return Container(
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
      onTap: () {
        Navigator.push(
          cxt,
          MaterialPageRoute(
              builder: (context) => PersonHeaderScreen(personId: person.id,)),
        );
      },
      title: Text(person.name),
      subtitle: Text(dateFormatter(person.birthDate)),
      trailing: _buildTrailingIcons(person),
    );
  }

  Widget _buildTrailingIcons(GetAllContact person) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 1),
            child: IconButton(
              onPressed: (){
                ConfirmationDialog(
                    context: cxt,
                    title: "Are you sure for this action?",
                    callback: MaterialSearch(),
                    type: Constant.warningIcon,
                    id: person.id
                );
              },
              icon: Icon(Icons.delete_forever, color: PRIMARY_COLOR),
            )),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 1),
            child: IconButton(
              onPressed: (){
                Provider.of<Auth>(cxt,listen: false).setEditContact(true);
                Provider.of<Auth>(cxt,listen: false).setHomePageTabFun(2);
                Provider.of<Auth>(cxt,listen: false).setId(person.id);
                Navigator.pushNamed(cxt, Constant.HOME);

              },
              icon: Icon(Icons.edit, color: PRIMARY_COLOR),
            )),
      ],
    );
  }

  @override
  void changer({context, id}) {
    Provider.of<Auth>(context, listen: false).setLoadingStateFun(true);
    var token = Provider.of<Auth>(context, listen: false).getTokenFun();
    var deleteNote = deletePersonApi(
      id: id,
      token: token,
    );

    LoadingDialog(context: context, title: "please wait.....");

    deleteNote.then((value) async {
      if (value == true) {

        Navigator.of(context).pop();
        Provider.of<Auth>(context, listen: false).setLoadingStateFun(false);
        InfoDialog(
            context: context,
            callback: MaterialSearch(),
            title: Constant.success,
            type: Constant.success
        );

        Navigator.pushNamed(context, Constant.HOME);

        Provider.of<Auth>(context,listen: false).setHomePageTabFun(0);


      }
    });

    deleteNote.catchError((value) async {
      Navigator.of(context).pop();
      Provider.of<Auth>(context, listen: false).setLoadingStateFun(false);
      InfoDialog(
          context: context,
          callback: MaterialSearch(),
          title: Constant.error,
          type: Constant.error
      );
    });
//    Navigator.pop(context);

  }




}