import 'package:bloc_auth/presentation/Home/home_page.dart';
import 'package:bloc_auth/presentation/Task/task_page.dart';
import 'package:bloc_auth/presentation/TaskList/task_list.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNaviagate extends StatefulWidget {
  int? screenindex;
  BottomNaviagate({Key? key, this.screenindex}) : super(key: key);

  @override
  State<BottomNaviagate> createState() => _BottomNaviagateState();
}

class _BottomNaviagateState extends State<BottomNaviagate> {
  @override
  initState() {
    super.initState();
    _selectedIndex = widget.screenindex == null ? 0 : widget.screenindex!;// send the index of the page route with bottomNavigationbar
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      print(_selectedIndex);
    });
  }

  static const List<Widget> _pages = <Widget>[
    HomePage(),
    TaskPage(screenindex: 1),
    TaskList(),
  ];

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages.elementAt(_selectedIndex),
      bottomNavigationBar: Container(
        color: Colors.deepPurple,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 8),
          child: GNav(
            backgroundColor: Colors.deepPurple,
            color: Colors.white,
            activeColor: Colors.white,
            tabBackgroundColor: Colors.orange.shade700,
            gap: 15,
            selectedIndex: _selectedIndex,
            onTabChange: (index) {
              _onItemTapped(index);
              print(index);
            },
            padding: EdgeInsets.all(12),
            tabs:[
            GButton(icon: Icons.home,
            text: "Home",),
            GButton(icon: Icons.post_add_rounded,
            text: "Task",),
            GButton(icon: Icons.format_line_spacing_outlined,
            text: "TaskList",)
          ]),
        ),
      ),
    );
  }
}
