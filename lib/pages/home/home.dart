import 'package:flutter/material.dart';
import 'package:flutter_app/api/auth.dart';
import 'package:flutter_app/api/model/contact_list.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/constants/constant.dart';
import 'package:flutter_app/pages/dialog/confirmationDialog.dart';
import 'package:flutter_app/pages/dialog/info_dialog.dart';
import 'package:flutter_app/pages/dialog/loading_dialog.dart';
import 'package:flutter_app/pages/drawer/navigation_drawer.dart';
import 'package:flutter_app/pages/home/add_new_person.dart';
import 'package:flutter_app/pages/home/contacts.dart';
import 'package:flutter_app/pages/home/last_contact.dart';
import 'package:flutter_app/pages/home/upcoming_birth_days.dart';
import 'package:flutter_app/pages/person_header/person_header.dart';
import 'package:flutter_app/pages/slider/slider.dart';
import 'package:flutter_app/state/app_state.dart';
import 'package:flutter_app/utilities/abstract_classes/confirmation_abstract.dart';
import 'package:flutter_app/utilities/date_formater.dart';
import 'package:flutter_app/utilities/round_letter_getter/get_round_letter.dart';
import 'package:flutter_app/utilities/validation/get_size.dart';
import 'package:loader_search_bar/loader_search_bar.dart';
import 'package:provider/provider.dart';
import 'package:rounded_letter/rounded_letter.dart';
import 'package:rounded_letter/shape_type.dart';

class Home extends StatefulWidget{
  Dashboard createState()=>Dashboard();
}
class Dashboard extends State<Home> implements ShouldImp {
  List<GetAllContact> personList=[];

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      getAllContactApi(
        token: Provider.of<Auth>(context, listen: false).getTokenFun(),
      ).then((val){
        setState(() {
          personList=val;
        });

      });
    });
    super.initState();
  }

  List<GetAllContact> filterPersonsByQueryPerson(String query) {

   return personList.where(
            (person) => person.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

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
      leading: RoundedLetter(
        text: getRoundLetter(person.name.toString().toUpperCase()),
        shapeType: ShapeType.circle,
        shapeColor: PRIMARY_COLOR,
        shapeSize: 40,
        fontSize: 20,
        borderWidth: 1,
        borderColor: Color.fromARGB(255, 0, 0, 0),
      ),
      onTap: () {
        Navigator.push(
          context,
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
                    context: context,
                    title: "Are you sure for this action?",
                    callback: Dashboard(),
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
                Provider.of<Auth>(context,listen: false).setEditContact(true);
                Provider.of<Auth>(context,listen: false).setHomePageTabFun(2);
                Provider.of<Auth>(context,listen: false).setId(person.id);
                Navigator.pushNamed(context, Constant.HOME);

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
            callback: Dashboard(),
            title: Constant.success,
            type: Constant.success
        );

        Navigator.pushNamed(context, Constant.HOME);
        Provider.of<Auth>(context,listen: false).setLoadingStateFun(true);

        Provider.of<Auth>(context,listen: false).setHomePageTabFun(0);


      }
    });

    deleteNote.catchError((value) async {
      Navigator.of(context).pop();
      Provider.of<Auth>(context, listen: false).setLoadingStateFun(false);
      InfoDialog(
          context: context,
          callback: Dashboard(),
          title: Constant.error,
          type: Constant.error
      );
    });

  }
  pageTaped(page) {
    switch ( Provider.of<Auth>(context,listen: false).getHomePageTabFun()) {
      case 0:
        return UpcomingBirthDaysScreen();
        break;
      case 1:
        return LastContact();
        break;
      default:
        return Contacts();
    }
  }

  getTitle(context) {
    if (Provider.of<Auth>(context,listen: false).getHomePageTabFun() == 0)
      return "Upcoming Birthdays";
    else if (Provider.of<Auth>(context,listen: false).getHomePageTabFun()  == 1)
      return "Last Contact";
    else
      return "Contacts";
  }

  void onTabTapped(int index) {
    Provider.of<Auth>(context,listen: false).setHomePageTabFun(index);
  }
  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      appBar:  SearchBar(
        defaultBar: AppBar(
          title: Text(getTitle(context),style: TextStyle(color: Colors.white),),
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
//        onQueryChanged: queryChanged,
      ),
      drawer: Container(
        width: getWidth(context)*0.75,
        height: getHeight(context),
        child: SideDrawer(),
      ),
      body: Container(
        child: Center(
          child: pageTaped(Provider.of<Auth>(context).getHomePageTabFun()),
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: Provider.of<Auth>(context).getHomePageTabFun() ,

        selectedItemColor: PRIMARY_COLOR,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.event),
            title: new Text('Birthdays'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.contact_mail),
            title: new Text('last contact'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.contacts),
            title: new Text('Contacts'),
          )
        ],
        onTap: onTabTapped,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          Navigator.push(context, SlideLeftRoute(page: AddNewPersonScreen())),
        },
        backgroundColor: PRIMARY_COLOR,
        child: Icon(
          Icons.add,
          color: lightBG,
        ),
      ),
    );


  }




}