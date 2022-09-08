import 'package:flutter/material.dart';

Widget MyAppBar(String title){
  return AppBar(
      title:const Center(child:  Text('Update profile')),
            backgroundColor: Colors.deepOrange,
            shape:const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(bottom: Radius.circular(15.0))),
  );
}