import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salaa_app/modules/Register_Screens/welcome_screen/welcome_screen.dart';
import 'package:salaa_app/layout/Bloc/cubit.dart';
import 'package:salaa_app/layout/Bloc/states.dart';
import 'package:salaa_app/modules/SettingScreens/screens/profile_screen/bloc/cubit.dart';
import 'package:salaa_app/modules/SettingScreens/screens/profile_screen/bloc/states.dart';
import 'package:salaa_app/shared/Constans/constans.dart';
import 'package:salaa_app/shared/Constans/constans.dart';
import 'package:salaa_app/shared/Constans/constans.dart';
import 'package:salaa_app/shared/Constans/constans.dart';
import 'package:salaa_app/shared/Constans/constans.dart';
import 'package:salaa_app/shared/compoenets/components.dart';


import '../../../../shared/Constans/constans.dart';
import '../../../../shared/Constans/constans.dart';
import '../../../../shared/Styles/colors.dart';

class UserProfile extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var formkey =GlobalKey<FormState>();
  bool _secirty = true;

  @override
  Widget build(BuildContext context) {


    return BlocConsumer<ProfileCubit ,ProfileStates>(
      listener: (BuildContext context , state){
        if (state is UpdateProfileSuccessState)
          {
              if(state.userDateModel.status){
                showError(massage:  state.userDateModel.message, state: ToastState.SUCCESS);
                ProfileCubit.get(context).getProfileData();
              }else{
          showError(massage:  state.userDateModel.message, state: ToastState.ERROR);
              }
            }


      } ,
      builder: (context ,state) {
        var model = ProfileCubit.get(context).profileModel;

        nameController.text = model.data.name ;
        emailController.text = model.data.email ;
        phoneController.text =model.data.phone;


        return  Scaffold(
          appBar: AppBar(),
            body: ConditionalBuilder(
              condition: ProfileCubit.get(context).profileModel != null,
             builder: (context)=>SingleChildScrollView(
               child: Container(
                 child: Form(
                   key: formkey,
                   child: Column(
                     //mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       if(state is UpdateProfileLoadingStates)
                         LinearProgressIndicator(),
                       Center(child: Text('My Profile',style: TextStyle(color: defultColor,fontSize: 30),)),
                       SizedBox(
                         height:  20,),
                       Center(
                         child: CachedNetworkImage(
                           imageUrl:'${model.data.image}',
                           imageBuilder: (context, imageProvider) => Container(
                             decoration: BoxDecoration(
                               image: DecorationImage(
                                 image: imageProvider,
                                 fit: BoxFit.cover,
                               ),
                             ),
                           ),
                           placeholder: (context, url) => CircularProgressIndicator(),
                           errorWidget: (context, url, error) => Icon(Icons.account_circle,color: defultColor,size: 150),
                         ),
                       ),
                       SizedBox(
                         height:  20,),
                       Padding(
                         padding: const EdgeInsets.symmetric(horizontal: 25,),
                         child: defulutTextFormFild(
                           style: Theme.of(context).textTheme.bodyText2,
                           controller: nameController,
                           type: TextInputType.text,
                           labeltext: 'name',
                           obscureText: !_secirty,
                           prefix: Icon(Icons.person, color: defultColor,),
                           validator: (value) {
                             if (value == null || value.isEmpty) {
                               return 'Please enter some text';
                             }
                             return null;

                           },

                         ),
                       ),
                       SizedBox(
                         height:  20,),
                       Padding(
                         padding: const EdgeInsets.symmetric(horizontal: 25,),
                         child: defulutTextFormFild(
                           style: Theme.of(context).textTheme.bodyText2,
                           controller: emailController,
                           type: TextInputType.emailAddress,
                           labeltext: 'Email Adress',
                           obscureText: !_secirty,
                           prefix: Icon(Icons.email, color: defultColor,),
                           validator: (value) {
                             if (value == null || value.isEmpty) {
                               return 'Please enter some text';
                             }
                             if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)){
                               return 'Please a valid Email';
                             }
                             return null;

                           },

                         ),
                       ),
                       SizedBox(
                         height:  20,),
                       Container(
                         decoration:  BoxDecoration(borderRadius: BorderRadius.circular(50),),

                         child: Padding(
                           padding: const EdgeInsets.symmetric(horizontal: 25,),
                           child: defulutTextFormFild(
                             style: Theme.of(context).textTheme.bodyText2,
                             controller: phoneController,
                             type: TextInputType.phone,
                             labeltext: 'phone',
                             obscureText: !_secirty,
                             prefix: Icon(Icons.email, color: defultColor,),
                             validator: (value) {
                               if (value == null || value.isEmpty) {
                                 return 'Please enter some text';
                               }

                               return null;

                             },

                           ),
                         ),
                       ),
                       SizedBox(
                         height:  20,),

                       Padding(
                         padding: const EdgeInsets.all(30),
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             defultMaterialButton(height: 50, width: 150,text: 'LogOut', function:(){

                               showDialog(context: context, builder: (BuildContext context)  {
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
                               });},),

                             defultMaterialButton(height: 50, width: 150,text: 'Update', function:(){
                               if(formkey.currentState.validate()){
                                 ProfileCubit.get(context).UpdateUserData(
                                     name: nameController.text,
                                     email: emailController.text,
                                     phone: phoneController.text
                                 );
                               }


                               },
                             ),



                           ],
                         ),
                       )









                     ],
                   ),
                 ),
               ),
             ),
              fallback:  (context)=> Center(child: CircularProgressIndicator()),
            )
        );


      },
    );
  }
}
