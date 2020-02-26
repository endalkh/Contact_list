import 'package:flutter/material.dart';
import 'package:flutter_app/api/auth.dart';
import 'package:flutter_app/api/model/contact_list.dart';
import 'package:flutter_app/api/model/get_notes.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/constants/constant.dart';
import 'package:flutter_app/pages/dialog/confirmationDialog.dart';
import 'package:flutter_app/pages/dialog/delete_update_dialog.dart';
import 'package:flutter_app/pages/dialog/info_dialog.dart';
import 'package:flutter_app/pages/dialog/loading_dialog.dart';
import 'package:flutter_app/pages/home/contacts.dart';
import 'package:flutter_app/pages/home/home.dart';
import 'package:flutter_app/pages/home/update_contacts.dart';
import 'package:flutter_app/pages/person_header/person_header.dart';
import 'package:flutter_app/pages/search/search.dart';
import 'package:flutter_app/state/app_state.dart';
import 'package:flutter_app/utilities/abstract_classes/confirmation_abstract.dart';
import 'package:flutter_app/utilities/abstract_classes/note_del_and_edit.dart';
import 'package:flutter_app/utilities/date_formater.dart';
import 'package:loader_search_bar/loader_search_bar.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart';

AppBar headerNav({context,String title}){
  return AppBar(
    iconTheme: new IconThemeData(color: TRIAL_COLOR),
    title: Text(title,
      style: TextStyle(
          fontSize: Constant.fontSize(10),
          fontWeight: FontWeight.w500,
          color: Colors.white

      ),
    ),


  );
}

class MaterialSearch implements ShouldImp,NoteDelAndEdit{
  BuildContext cxt;
  MaterialSearch(this.cxt);
  String queryText="";
   SearchBar materialSearch({context,String title}){
    return SearchBar(

        defaultBar: AppBar(
          backgroundColor: PRIMARY_COLOR,
          iconTheme: IconThemeData(color: TRIAL_COLOR),
          actions: <Widget>[
            IconButton(
              icon:Icon(Provider.of<Auth>(context,listen: false).getIsPerson()==true?Icons.person:Icons.note),
              onPressed: (){
                Provider.of<Auth>(context,listen: false).setIsPerson(!Provider.of<Auth>(context,listen: false).getIsPerson());
              },
              color: TRIAL_COLOR,
            ),
          ],
        ),
        iconified: true,
        searchItem:  SearchItem.action(
          builder: (_) => Padding(
            padding: EdgeInsets.all(12.0),
            child: Icon(
              Icons.search,
              color: TRIAL_COLOR,
            ),
          ),
        ),
        searchHint: 'Search persons...',

        loader: QuerySetLoader<GetAllContact>(
          querySetCall: filterPersonsByQueryPerson,
          itemBuilder: buildPersonRow,
          loadOnEachChange: true,
          animateChanges: true,

        )
    );

  }

  List<GetAllContact> filterPersonsByQueryPerson(String query) {

    return getList()
        .where(
            (person) => person.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }


  List<GetAllContact> getList(){
    var persons= getAllContactApi(
      token: Provider.of<Auth>(cxt,listen: false).getTokenFun(),
    );
    persons.then((value){
      Provider.of<Auth>(cxt,listen: false).setPersonList(value);
    });

    if( Provider.of<Auth>(cxt,listen: false).getPersonList().toString().length>0){
      return  Provider.of<Auth>(cxt,listen: false).getPersonList();
    }
    else return null;

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
      onTap:(){
        Navigator.push(
          cxt,
          MaterialPageRoute(builder: (context) => PersonHeaderScreen(personId: person.id,)),
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
        _buildTrailingIcon(icon: Icons.delete_forever, color: Colors.red,id:person.id),
        _buildTrailingIcon(icon: Icons.edit, color: PRIMARY_COLOR),
      ],
    );
  }

  Widget _buildTrailingIcon({icon, double padding = 4.0, Color color,id}) {
     var personId=id;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: IconButton(
        onPressed: (){
          if(icon==Icons.edit) {
            print("from edit $personId");
//            Provider.of<Auth>(cxt,listen: false).setHomePageTabFun(2);
//            Provider.of<Auth>(cxt,listen: false).setEditContact(true);
//            UpdateContact(id: id,);

          }
          else {
            print("from delete $id");
            ConfirmationDialog(
                context: cxt,
                title: "Are you sure for this action?",
                callback: MaterialSearch(cxt),
                type: Constant.warningIcon,
                id: id
            );
          }
        },
        icon: Icon(
          icon,
          color: color,
        ),

      ),
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


    LoadingDialog(context: context,title: "please wait.....");

    deleteNote.then((value) async {
      if(value==true) {
        Navigator.of(context).pop();
        Provider.of<Auth>(context, listen: false).setLoadingStateFun(false);
        InfoDialog(
            context: context,
            callback: MaterialSearch(context),
            title: Constant.success,
            type:Constant.success
        );
      }
    });

    deleteNote.catchError((value) async {
      Provider.of<Auth>(context, listen: false).setLoadingStateFun(false);
      InfoDialog(
          context: context,
          callback: MaterialSearch(context),
          title: Constant.error,
          type:Constant.error
      );
    });
//    Navigator.pop(context);

  }


  @override
  editNote({id, context, contextDialog}) {

    return null;
  }



}


