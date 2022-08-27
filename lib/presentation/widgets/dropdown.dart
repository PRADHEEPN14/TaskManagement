import 'package:flutter/material.dart';

class DropdownRole extends StatefulWidget {
  const DropdownRole({Key? key}) : super(key: key);

  @override
  State<DropdownRole> createState() => _DropdownRoleState();
}

class _DropdownRoleState extends State<DropdownRole> {
  String _selectvalue ="select role";

List<DropdownMenuItem<String>> get dropdownItems{
  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(child: Text("Angular"),value: "Angular"),
    DropdownMenuItem(child: Text("Flutter"),value: "Flutter"),
    DropdownMenuItem(child: Text("Backend-devloper"),value: "Backend-devloper"),
    DropdownMenuItem(child: Text("Tester"),value: "Tester"),
    DropdownMenuItem(child: Text("React"),value: "React"),


  ];
  return menuItems;
}


  @override
  Widget build(BuildContext context) {
    return DropdownButton(items: dropdownItems, 
    onChanged: (String? Value){
      setState(() {
        _selectvalue = Value!;
      }
      );
    },
    value: _selectvalue);
    
  }
}