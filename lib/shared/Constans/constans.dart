import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:salaa_app/shared/Network/local/cacheHelper.dart';
import 'package:salaa_app/shared/Styles/theme/cubit/cubit.dart';

//abullah.ali@gmail.com
dynamic onBoarding =CacheHelper.getDate(key: 'onBoarding');
dynamic shoptoken =CacheHelper.getDate(key:'token');
String toke='';
String token='1E8FUbLpcK2G1keQ0AgpbJEJQpFn6n8luRZJ9qN9BkNspYzWsZecQWOu2LZORCcFDShJvI';
void NavigateTo({context,router})=>  Navigator.push(context,MaterialPageRoute(builder: (context) => router));
Future NavigateAndFinsh ({BuildContext context,router})=> Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => router), (Route<dynamic> route) => false);
//using for boarding screen after login or signup
void Onsubmit({context,router}){
  CacheHelper.saveDate(key:'onBoarding', value: true).then((value) =>
      NavigateAndFinsh(router:router,context: context)
  );
}

void LogOut({context,router}){
  print(shoptoken);
  print(token);
  CacheHelper.sharedPreferences.remove('token').then((value) {
    if(value ){
      NavigateAndFinsh(context: context,router: router);
    }

  });
}


void printFullText(String text){

final pattern = RegExp('.{1,800}');

    pattern.allMatches (text). forEach((match) => print(match.group(0)));

}


void Colorbackground(Colors RightColor,context)
{

  if(ThemeAppCubit.get(context).IsDark ) {
    RightColor= HexColor('333739') as Colors;

  }
  else{
    RightColor= Colors.white as Colors;
  }

}
