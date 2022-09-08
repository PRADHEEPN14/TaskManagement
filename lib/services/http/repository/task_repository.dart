import 'package:bloc_auth/presentation/TaskList/task_list.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class TaskRepository{
  static Future<dynamic>Profile(
    String starttime,endtime,date,project,task,taskdescription
  )async{
    try{
      var dio =Dio();

    // response
    var response = await dio.post("",data:{"starttime":starttime,"endtime":endtime,"date":date,"project":project,"task":task,"taskdescription":taskdescription});
    print(response);




    }catch(e){
      print(e);
    }
  }
}