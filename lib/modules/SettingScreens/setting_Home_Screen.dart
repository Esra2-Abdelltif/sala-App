// ignore_for_file: non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:salaa_app/layout/Bloc/cubit.dart';
import 'package:salaa_app/layout/Bloc/states.dart';
import 'package:salaa_app/models/login_model/login_model.dart';
import 'package:salaa_app/modules/SettingScreens/screens/ContactUsPage/ContactUs.dart';
import 'package:salaa_app/modules/SettingScreens/screens/about_screen/aboutScreen.dart';
import 'package:salaa_app/modules/SettingScreens/screens/profile_screen/bloc/cubit.dart';
import 'package:salaa_app/modules/cart_screen/cart_screen.dart';
import 'package:salaa_app/modules/SettingScreens/screens/profile_screen/profile.dart';
import 'package:salaa_app/shared/Styles/colors.dart';
import 'package:salaa_app/shared/Styles/theme/cubit/cubit.dart';
import 'package:salaa_app/shared/Styles/theme/cubit/states.dart';

import '../../shared/Constans/constans.dart';
import '../Register_Screens/welcome_screen/welcome_screen.dart';


class Setting extends StatelessWidget {
  const Setting({ Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (BuildContext context,AppStates state)
      {
      },

      builder: (BuildContext context ,AppStates state) {
        AppCubit cubit = AppCubit.get(context);
        //var GetUserData=AppCubit.get(context).userModel.data;

        return Scaffold(
          body:Column(children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // GetUserName(GetUserData),
                  SizedBox(
                    height: 15,
                  ),
                  //General Setting
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text('General Setting',
                        style: TextStyle(color: Color(0xFF8D8E98), fontSize: 18)
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  //Profile
                  InkWell(
                    onTap: (){
                      NavigateTo(context: context,router: UserProfile());
                      ProfileCubit.get(context).getProfileData();
                    },
                    child: Container(
                        height: 70,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(25),
                          // color: Colors.grey[100],
                          border: Border.all(
                              width: 1,
                              color:Colors.grey[100]
                          ),),
                        child: Row(children: [
                          SizedBox(width: 10),
                          Icon(Icons.person ,color: defultColor,size: 40),
                          SizedBox(width: 15),
                          Text('Profile',
                            style: Theme.of(context).textTheme.bodyText2,),
                          Spacer(),
                          Icon(
                            Icons.navigate_next,
                            color:defultColor ,
                            size: 30,
                          ),
                        ],)
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  //Dark mode
                  Container(
                      height: 70,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(25),
                        //color: Colors.grey[100],
                        border: Border.all(
                            width: 1,
                            color:Colors.grey[100]
                        ),),
                      child: Row(children: [
                        SizedBox(width: 10),
                        Icon(Icons.brightness_2,color: defultColor,size: 40),
                        SizedBox(width: 15),
                        Text('Dark Mode',
                          style: Theme.of(context).textTheme.bodyText2,),
                        Spacer(),
                        SwitchTheme(),
                      ],)
                  ),
                  SizedBox(
                    height: 24,
                  ),
                 //ABOUT US
                  InkWell(
                    onTap: (){
                      // Navigator.pop(context);

                      NavigateTo(context: context,router:AboutUsScreen());
                    },
                    child: Container(
                        height: 70,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                              width: 1,
                              color:Colors.grey[300]
                          ),),
                        child: Row(children: [
                          SizedBox(width: 10),
                          Icon(Icons.info ,color: defultColor,size: 40),
                          SizedBox(width: 15),
                          Text('About Us'),
                          Spacer(),
                          Icon(
                            Icons.navigate_next,
                            color:defultColor ,
                            size: 30,
                          ),
                        ],)
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  //FavoritesScreen
                  InkWell(
                    onTap: (){
                     // Navigator.pop(context);
                      AppCubit.get(context).ChangeIndex(2);
                      // NavigateTo(context: context,router: FavoritesScreen());
                    },
                    child: Container(
                        height: 70,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                              width: 1,
                              color:Colors.grey[300]
                          ),),
                        child: Row(children: [
                          SizedBox(width: 10),
                          Icon(Icons.favorite ,color: defultColor,size: 40),
                          SizedBox(width: 15),
                          Text('Favorite Prouct'),
                          Spacer(),
                          Icon(
                            Icons.navigate_next,
                            color:defultColor ,
                            size: 30,
                          ),
                        ],)
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  //Cart
                  InkWell(
                    onTap: (){
                      NavigateTo(context: context,router: ContactUsScreen());
                    },
                    child: Container(
                        height: 70,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                              width: 1,
                              color:Colors.grey[300]
                          ),),
                        child: Row(children: [
                          SizedBox(width: 10),
                          Icon(Icons.contact_phone_rounded ,color: defultColor,size: 40),
                          SizedBox(width: 15),
                          Text('Contact US '),
                          Spacer(),
                          Icon(
                            Icons.navigate_next,
                            color:defultColor ,
                            size: 30,
                          ),
                        ],)
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  //LogOut
                  InkWell(
                    onTap: (){
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Log out ? ',style: TextStyle(color: Colors.white, fontSize: 18)),
                              content: const Text('Do You sure to log out ?',  style: TextStyle(color: Colors.white, fontSize: 18)),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('Cancel',  style: TextStyle(color: Colors.white, fontSize: 18)),
                                ),
                                TextButton(
                                  onPressed: () {
                                    LogOut(context: context,router: WelcomeScreen());

                                  },
                                  child: const Text('Log out',  style: TextStyle(color:Colors.white, fontSize: 18)),
                                ),
                              ],
                              elevation: 24,
                              backgroundColor: defultColor,
                              // shape: CircleBorder(),
                            );
                          }
                      );
                    },
                    child: Container(
                        height: 70,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(25),
                          // color: Colors.grey[100],
                          border: Border.all(
                            width: 1,
                            color: Colors.grey[100],
                          ),),
                        child: Row(children: [
                          SizedBox(width: 10),
                          Icon(Icons.logout ,color: defultColor,size: 40),
                          SizedBox(width: 15),
                          Text('Log Out',
                            style: Theme.of(context).textTheme.bodyText2,),
                          Spacer(),
                          Icon(
                            Icons.navigate_next,
                            color:defultColor ,
                            size: 30,
                          ),
                        ],)
                    ),
                  ),

                ],
              ),
            )
          ]),
        );

      },
    );

  }

  // Widget GetUserName(UserData getUserData)=>   Column(
  //   crossAxisAlignment: CrossAxisAlignment.start,
  //   children: [
  //     Padding(
  //       padding: const EdgeInsets.symmetric(horizontal: 12),
  //       child: Row(
  //         children: [
  //           Text('Hello ${getUserData.name.split(" ").elementAt(0)} ..💖 🥰 😄 😋',
  //               style: TextStyle( fontSize: 22)
  //           ),
  //
  //         ],
  //       ),
  //     ),
  //
  //   ],
  // );

}
class SwitchTheme extends StatelessWidget {
  const SwitchTheme({Key key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ThemeAppCubit, ThemeAppStates>(
      listener: (BuildContext context, ThemeAppStates state) {
        if(state is AppChangeModeState ){
        };
      },
      builder: (BuildContext context,  ThemeAppStates state) {
        return CupertinoSwitch(
          value: ThemeAppCubit.get(context).IsDark,
          activeColor: Theme.of(context).primaryColor,
          onChanged: (value) {
            ThemeAppCubit.get(context).ChangeAppMode();

          },
        );
      },
    );
  }
}

