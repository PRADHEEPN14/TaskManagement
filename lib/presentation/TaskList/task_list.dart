import 'package:flutter/material.dart';

class TaskList extends StatefulWidget {
  const TaskList({Key? key}) : super(key: key);

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            title: const Center(child:  Text('TaskList')),
            backgroundColor: Colors.deepOrange,
            shape:const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(bottom: Radius.circular(15.0))),
            
          ),
        body: Container(
          width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            // decoration: BoxDecoration(
            //   gradient: LinearGradient(begin:Alignment.topCenter ,end: Alignment.bottomRight,
            //     colors: [Colors.lightBlue,
            //     Color(0xFF61CAFA),
            //     Color(0xFF7463F5)
            //   ])
            // ),
      
            child:const Center(
              child: Text('Its Your Task List Page view:'),
            )
        ),
      ),
    );
      

    
  }
}