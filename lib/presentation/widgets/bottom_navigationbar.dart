import 'package:bloc_auth/presentation/Home/home_page.dart';
import 'package:bloc_auth/presentation/SearchPage/searchpage.dart';
import 'package:bloc_auth/presentation/Task/task_page.dart';
import 'package:bloc_auth/presentation/TaskList/task_list.dart';
import 'package:bloc_auth/presentation/Timesheet/timetrackerpage.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../preference_helper.dart';

class BottomNaviagate extends StatefulWidget {
  int? screenindex;
  BottomNaviagate({Key? key, this.screenindex}) : super(key: key);

  @override
  State<BottomNaviagate> createState() => _BottomNaviagateState();
}

class _BottomNaviagateState extends State<BottomNaviagate> {

int? user_roleId;

// <<<<<<<<< GetuserId from LoginPage function here...>>>>>>>>
  getUserRoleId() async {
    user_roleId = await PreferenceHelper.getUserRoleId();

    print("user_roleIdD--$user_roleId");
  }
// <<<<<<<<< End here...>>>>>>>>>>

  @override
  initState() {
    super.initState();
     getUserRoleId();
    _selectedIndex = widget.screenindex == null ? 0 : widget.screenindex!;// send the index of the page route with bottomNavigationbar
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      if(index==2){
        _selectedIndex = user_roleId! <3 ? index =3 : index ;
      }else{
      _selectedIndex = index;

      }
      print('screen$_selectedIndex');
    });
  }

  static List<Widget> _pages = <Widget>[
    TaskList(),
    TaskPage(screenindex: 1),
    Searchpage(),
    Timetracker()
  ];

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages.elementAt(_selectedIndex),
      bottomNavigationBar: Container(
        color: Colors.deepPurple,
          // decoration: BoxDecoration(
      // border: Border.all(color: Colors.black)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 8),
          child: GNav(
            // backgroundColor: Colors.deepPurple,
            color: Colors.white,
            activeColor: Colors.white,
            tabBackgroundColor: Colors.black,
            gap: 5,
            selectedIndex: _selectedIndex,
            onTabChange: (index) {
              _onItemTapped(index);
              print('indextab$index');
            },
            padding: EdgeInsets.all(12),
            tabs:[
            GButton(icon: Icons.home_outlined,
            text: "Home",),
            GButton(icon: Icons.library_books_rounded,
            text: "Task",),
          //  user_roleId! <3 ?
            GButton(icon:Icons.people_alt,
            text: "UserList",)
            // :GButton(icon: Icons.dynamic_feed_outlined,
            // text: "Timesheet",)
          ]),
        ),
      ),
    );
  }
}
