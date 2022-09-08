import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ProfileRepository{
  static Future<dynamic>Profile(
    String userRole,mobilenum,Apikey,
  )async{
    try{
      var dio =Dio();

    // response
    var response = await dio.post("",data:{"userRole":userRole,"mobilenum":mobilenum,"Apikey":Apikey});
    print(response);




    }catch(e){
      print(e);
    }
  }
}