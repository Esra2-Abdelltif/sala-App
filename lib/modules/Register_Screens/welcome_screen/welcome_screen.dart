import 'package:flutter/material.dart';
import 'package:salaa_app/modules/Register_Screens/login_screen/login_screen.dart';
import 'package:salaa_app/modules/Register_Screens/signup_screen/signup_screen.dart';
import 'package:salaa_app/shared/compoenets/components.dart';
import '../../../shared/Constans/constans.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image:AssetImage('assets/images/salalogo.png'),height: 250,width: 250),
              Text('Shopping Now',
                style: TextStyle(fontSize: 30, color: Colors.black54, fontWeight: FontWeight.w600),),
              Text('Welcome to Application',
                  style:TextStyle(fontWeight: FontWeight.w300,color: Color(0xFF8D8E98),)),
              SizedBox(
                height: 20,),
              SizedBox(
                height: 10,),
              defultMaterialButton(height: 50, width: 300,text: 'LOGIN',
                function:(){
                  NavigateTo(router: LoginScreen(),context: context);

                },
              ),
              SizedBox(
                height: 20,),

              defultMaterialButton(height: 50, width: 300,text: 'SIGNUP',backColor:Colors.grey[100],ColorText: Colors.black,
                function:(){
                  NavigateTo(router:SignupScreen(),context: context);

                },
              ),

            ],
          ),
        ),
      ),
    );

  }
}
