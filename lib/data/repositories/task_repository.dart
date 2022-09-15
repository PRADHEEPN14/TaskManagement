import 'dart:ffi';

// <<<<<<<<<<<<<<<<<<<<< sample repo code here..>>>>>>>>>>>>>>>>

class TaskPageRepository{
  late String _data;
  Future<void>fetchdata()async{
    await Future.delayed(Duration(milliseconds: 500));
    _data = "Task page list UI";

  }
  String get data => _data;
}

 // <<<<<<<<<<<<<<<<<<<<< end here..>>>>>>>>>>>>>>>>