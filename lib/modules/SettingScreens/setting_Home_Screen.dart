// ignore_for_file: non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:salaa_app/layout/Bloc/cubit.dart';
import 'package:salaa_app/layout/Bloc/states.dart';
import 'package:salaa_app/models/login_model/login_model.dart';
import 'package:salaa_app/modules/SettingScreens/screens/Payments_Screen/Payments_Screen.dart';
import 'package:salaa_app/modules/SettingScreens/screens/Terms_Screen/Terms.dart';
import 'package:salaa_app/modules/SettingScreens/screens/about_screen/aboutScreen.dart';
import 'package:salaa_app/modules/SettingScreens/screens/contactus_Screen/ContactUs.dart';
import 'package:salaa_app/modules/SettingScreens/screens/profile_screen/bloc/cubit.dart';
import 'package:salaa_app/modules/cart_screen/cart_screen.dart';
import 'package:salaa_app/modules/SettingScreens/screens/profile_screen/profile.dart';
import 'package:salaa_app/shared/Styles/colors.dart';
import 'package:salaa_app/shared/Styles/theme/cubit/cubit.dart';
import 'package:salaa_app/shared/Styles/theme/cubit/states.dart';
import 'package:salaa_app/shared/compoenets/components.dart';

import '../../shared/Constans/constans.dart';
import '../Register_Screens/welcome_screen/welcome_screen.dart';


class Setting extends StatefulWidget {
  const Setting({ Key key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  String dropdownValue = 'USD';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: ((context) => AppCubit()),
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (BuildContext context,AppStates state)
        {
        },

        builder: (BuildContext context ,AppStates state) {
          AppCubit cubit = AppCubit.get(context);
          //var GetUserData=ProfileCubit.get(context).profileModel.data;

          return Scaffold(
            body:SingleChildScrollView(
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // GetUserName(GetUserData),
                      SizedBox(
                        height: 15,
                      ),
                      //Account Setting
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text('Account Setting',
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
                            height: 60,
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
                      // Payments
                      InkWell(
                        onTap: (){
                          NavigateTo(context: context,router: PaymentsScreen());

                        },
                        child: Container(
                            height: 60,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(25),
                              // color: Colors.grey[100],
                              border: Border.all(
                                  width: 1,
                                  color:Colors.grey[100]
                              ),),
                            child: Row(children: [
                              SizedBox(width: 10),
                              Icon(Icons.payment ,color: defultColor,size: 40),
                              SizedBox(width: 15),
                              Text('Payments',
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
                      //Currency
                      Container(
                          height: 60,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(25),
                            // color: Colors.grey[100],
                            border: Border.all(
                                width: 1,
                                color:Colors.grey[100]
                            ),),
                          child: Row(children: [
                            SizedBox(width: 10),
                            Icon(Icons.monetization_on_outlined ,color: defultColor,size: 40),
                            SizedBox(width: 15),
                            Text('Currency',
                              style: Theme.of(context).textTheme.bodyText2,),
                            Spacer(),
                            DropdownButton<String>(
                              value: dropdownValue,
                              elevation: 16,
                              style: const TextStyle(color: defultColor),
                              onChanged: (String newValue) {
                                setState(() {
                                  dropdownValue = newValue;
                                });
                              },
                              items: <String>['USD','EGP', 'EUR',  'AED']
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            )
                          ],)
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      MyDivider(margin: 20),
                      SizedBox(
                        height: 24,
                      ),
                      // General Setting
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text('General Setting',
                            style: TextStyle(color: Color(0xFF8D8E98), fontSize: 18)
                        ),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      //Dark mode
                      Container(
                          height: 60,
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
                      MyDivider(margin: 20),
                      SizedBox(
                        height: 24,
                      ),
                      //support setting
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text('Support',
                            style: TextStyle(color: Color(0xFF8D8E98), fontSize: 18)
                        ),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      //contact us
                      InkWell(
                        onTap: (){
                          NavigateTo(context: context,router: ContactUsScreen());
                        },
                        child: Container(
                            height: 60,
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
                     //ABOUT US
                      InkWell(
                        onTap: (){
                          // Navigator.pop(context);

                          NavigateTo(context: context,router:AboutUsScreen());
                        },
                        child: Container(
                            height: 60,
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
                      //terms
                      InkWell(
                        onTap: (){
                          // Navigator.pop(context);

                          NavigateTo(context: context,router:TermsScreen());
                        },
                        child: Container(
                            height: 60,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(25),
                              border: Border.all(
                                  width: 1,
                                  color:Colors.grey[300]
                              ),),
                            child: Row(children: [
                              SizedBox(width: 10),
                              Icon(Icons.sticky_note_2 ,color: defultColor,size: 40),
                              SizedBox(width: 15),
                              Text('Terms of Service'),
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
                      MyDivider(margin: 20,),
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
                            height: 60,
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
            ),
          );

        },
      ),
    );

  }
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

