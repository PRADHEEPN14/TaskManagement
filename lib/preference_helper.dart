import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
String? token ='';

class PreferenceHelper {
  
  static clearStorage() async {
    // Delete all
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  static saveToken(String token) async {
    if (token == null) return;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  static saveUserId(int userId) async {
    if (userId == null) return;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('userId', userId);
  }

  static getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? value = prefs.getInt('userId');
    if (value==null) {
      return null;
    } else {
      return value;
    }
  }


  static Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? value = prefs.getString('token');
    if (value!.isEmpty) {
      return null;
    } else {
      return value;
    }
  }

    static Map<String, dynamic> _parseAndDecode(String response) {
    return jsonDecode(response);
  }

  static Future<Map<String, dynamic>> _parseJson(String text) {
    return compute(_parseAndDecode, text);
  }
}

//  static ShareUtils _instance;
//   SharedPreferences ShareSave;
//   factory ShareUtils() => _instance ?? new ShareUtils._();

//   ShareUtils._();

//   void Instatce() async{
//   ShareSave = await SharedPreferences.getInstance();
// }

//   Future<bool> set(key, value) async{
//    return ShareSave.setString(key, value);

//   }

//   Future<String> get(key) async{
//    return ShareSave.getString(key);
//   }
// }
