import 'package:flutter/material.dart';


class BottomNaviagate extends StatefulWidget {
  const BottomNaviagate({Key? key}) : super(key: key);

  @override
  State<BottomNaviagate> createState() => _BottomNaviagateState();
}

class _BottomNaviagateState extends State<BottomNaviagate> {
  int _selectvalue=0;
  @override
  Widget build(BuildContext context) {
    return Container(
      
      
      child: BottomNavigationBar(
        
        backgroundColor: Color(0xFFF44141),
        mouseCursor: MouseCursor.defer,
        selectedItemColor: Colors.white,
        selectedLabelStyle: TextStyle(color: Colors.black),
        elevation: 20,
        items: [
          
        BottomNavigationBarItem(
          
          
          icon: Icon(Icons.add_card,color: Color(0xFF0412AC),size: 30,),label: "Task",backgroundColor: Colors.orangeAccent ),
            BottomNavigationBarItem(
              icon: Icon(Icons.view_list_sharp,color: Color(0xFF1406AF),size: 30,),label: "Task list",backgroundColor: Colors.orangeAccent,)
      ]),
    );
  }
}