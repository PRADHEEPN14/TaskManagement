import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ProfileRepository{
  static Future<dynamic>Profile(
    String email,userRole,mobilenum,Apikey,
  )async{
    try{
      var dio =Dio();

    // response
    var response = await dio.post("",data:{"email":email,"userRole":userRole,"mobilenum":mobilenum,"Apikey":Apikey});
    print(response);




    }catch(e){
      print(e);
    }
  }
}