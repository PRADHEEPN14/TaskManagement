


 // <<<<<<<<<<<<<<<<<<<<< sample repo code here..>>>>>>>>>>>>>>>>

class TaskListRepository {
  late String _data;
  Future<void>fetchdata() async{
    await Future.delayed(const Duration(milliseconds: 400));
    _data="Task list Datas Appeard here";
  }
  String get data => _data;

}

 // <<<<<<<<<<<<<<<<<<<<< end here..>>>>>>>>>>>>>>>>