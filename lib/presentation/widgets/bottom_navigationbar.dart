import 'package:bloc_auth/presentation/Home/home_page.dart';
import 'package:bloc_auth/presentation/Task/task_page.dart';
import 'package:bloc_auth/presentation/TaskList/task_list.dart';
import 'package:flutter/material.dart';


class BottomNaviagate extends StatefulWidget {
  const BottomNaviagate({Key? key}) : super(key: key);

  @override
  State<BottomNaviagate> createState() => _BottomNaviagateState();
}

class _BottomNaviagateState extends State<BottomNaviagate> {

  int _selectedIndex = 0;


  void _onItemTapped(int index) {
  setState(() {
    _selectedIndex = index;
  });
}
static const List<Widget> _pages = <Widget>[
HomePage(),
TaskPage(),
TaskList(),






];
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: _pages.elementAt(_selectedIndex),
      
      bottomNavigationBar:
        BottomNavigationBar(
          // showUnselectedLabels: false,
          showSelectedLabels: true,
          selectedItemColor: Colors.white,
          backgroundColor:Colors.redAccent,
          selectedIconTheme:const IconThemeData(color: Colors.white),
          selectedLabelStyle:const TextStyle(color: Colors.red),
          selectedFontSize: 15,
          elevation: 10,
          
    items: const <BottomNavigationBarItem>[
     
      BottomNavigationBarItem(
        icon: Icon(Icons.home_filled),
        label: 'Home',
        
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.add_task),
        label: 'Task',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.list_sharp),
        label: 'TaskList',
      ),
     
    ],
     currentIndex:_selectedIndex,
           onTap: _onItemTapped,
    
      ),
      
    );
    
  }
}

