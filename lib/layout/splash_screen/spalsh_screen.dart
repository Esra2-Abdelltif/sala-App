import 'dart:ui';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:salaa_app/layout/home_layout/home_layout.dart';
import 'package:salaa_app/modules/on_boarding_screen/on_boardin_screen.dart';
import 'package:salaa_app/shared/Constans/constans.dart';
import 'package:salaa_app/shared/Network/local/cacheHelper.dart';

import '../../modules/Register_Screens/welcome_screen/welcome_screen.dart';
class SplashSCreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Widget RightScreen;
    if(onBoarding !=null)
    {
      if(shoptoken!=null){
        RightScreen= HomeLayout();
      }
      else{
        RightScreen =WelcomeScreen();}
    }
    else{
      RightScreen = OnBoardinScreen();
    }
    return  AnimatedSplashScreen(
      duration: 400,
      splash: Column(children: [
        Image.asset('assets/images/shopping app logo1.png',width: 150,height: 140),
        SizedBox(height: 15,),
        Text('Sala App',style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold,color: Colors.black54),)
      ]),
      nextScreen:OnBoardinScreen(),
      splashIconSize: 250,
      splashTransition: SplashTransition.slideTransition,


    );

  }
}
