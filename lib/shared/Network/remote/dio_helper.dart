import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class DioHelper {
  static Dio dio ;
  static init(){
    dio=Dio(
        BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
       receiveDataWhenStatusError: true,

        // connectTimeout: 5000,
        // receiveTimeout: 3000
      ),
    );
  }

  static Future<Response> getData({@required String Url,  Map<String, dynamic> Quary, String lang ='en', String token})async {
   dio.options.headers={
     'Content-Type':'application/json',
     'lang':lang ,
     'Authorization':token,
   };

   return await dio.get(Url,queryParameters: Quary);
  }

  static Future<Response>postData({@required String Url,Map<String,dynamic>Quary,@required Map<String,dynamic>data,String lang='en',String token,})
  async {
   dio.options.headers={
     'Content-Type':'application/json',
     'lang':lang ,
     'Authorization':token,};
    return await dio.post(Url,queryParameters: Quary,data: data);
  }


  static Future<Response>putData({@required String Url,Map<String,dynamic>Quary,@required Map<String,dynamic>data,String lang='en',String token,})
  async {
    dio.options.headers={
      'Content-Type':'application/json',
      'lang':lang ,
      'Authorization':token,};
    return await dio.put(Url,queryParameters: Quary,data: data);
  }

}




