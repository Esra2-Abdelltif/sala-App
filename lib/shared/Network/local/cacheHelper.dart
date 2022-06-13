import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences sharedPreferences;


  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }
  static Future<bool> putDate({@required String key ,@required bool value}) async {
   return await sharedPreferences.setBool(key, value);
  }

  static dynamic getDate({@required String key }) {
    return  sharedPreferences.get(key);
  }

  static Future<bool> saveDate({@required String key ,@required dynamic value}) async{
    if(value is int ) return await sharedPreferences.setInt(key, value);
    if(value is bool ) return await sharedPreferences.setBool(key, value);
    if(value is String ) return await sharedPreferences.setString(key, value);
    return await sharedPreferences.setDouble(key, value);




  }

  //LogOut
  static Future<bool> removeData({@required String key }) async{
   return await sharedPreferences.remove(key);

}
}

