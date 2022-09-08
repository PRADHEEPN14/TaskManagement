import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class GoogleRepository{
  static Future<dynamic>GoogleLogin(String email,displayName)
  async{
    try{
      var dio =Dio();
      var response = await dio.post("path",data:{"email":email,"fullname":displayName});
      
    }catch(e){
      print(e);

    }
    
  }
}