//
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:conditional_builder/conditional_builder.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:salaa_app/models/login_model/login_model.dart';
// import 'package:salaa_app/models/login_model/login_model.dart';
// import 'package:salaa_app/modules/cart_screen/cart_screen.dart';
// import 'package:salaa_app/modules/favorites_screen/favorites_screen.dart';
// import 'package:salaa_app/modules/welcome_screen/welcome_screen.dart';
// import 'package:salaa_app/layout/Bloc/cubit.dart';
// import 'package:salaa_app/layout/Bloc/states.dart';
// import 'package:salaa_app/shared/Constans/constans.dart';
// import 'package:salaa_app/shared/Styles/colors.dart';
// import 'package:salaa_app/shared/compoenets/components.dart';
//
//
//
// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({Key key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//         body: BlocConsumer<AppCubit,AppStates>(
//           listener: (BuildContext context,AppStates state)
//           {
//             if( state is InitialAppStates) print('loading AppShop ');
//
//           },
//
//           builder: (BuildContext context ,AppStates state) {
//             AppCubit cubit = AppCubit.get(context);
//             var GetUserData=AppCubit.get(context).userModel.data;
//
//
//             return  Column(
//                 children: [
//               Expanded(child: BuildUserProfile(GetUserData,context)),
//
//                   defultMaterialButton(height: 50, width: 200,text: 'LogOut', function:(){
//
//                     showDialog(context: context, builder: (BuildContext context)  {
//                       return AlertDialog(
//                         title: const Text('Log out ? ',style: TextStyle(color: Colors.white, fontSize: 18)),
//                         content: const Text('Do You sure to log out ?',  style: TextStyle(color: Colors.white, fontSize: 18)),
//                         actions: [
//                           TextButton(
//                             onPressed: () => Navigator.pop(context),
//                             child: const Text('Cancel',  style: TextStyle(color: Colors.white, fontSize: 18)),
//                           ),
//                           TextButton(
//                             onPressed: () {
//                               LogOut(context: context,router: WelcomeScreen());
//
//                             },
//                             child: const Text('Log out',  style: TextStyle(color:Colors.white, fontSize: 18)),
//                           ),
//                         ],
//                         elevation: 24,
//                         backgroundColor: defultColor,
//                         // shape: CircleBorder(),
//                       );
//                     });},),
//                   SizedBox(height: 15,),
//
//                 ]);
//
//           },
//         )
//
//
//
//     );
//
//   }
//   Widget BuildUserProfile(UserData getUserData,context)=>Padding(
//     padding: const EdgeInsets.symmetric(horizontal: 15.0),
//     child: Column(
//       children: [
//         Center(child: Text('My Profile',style: TextStyle(color: defultColor,fontSize: 30),)),
//         Center(
//           child: CachedNetworkImage(
//             imageUrl:'${getUserData.image}',
//             imageBuilder: (context, imageProvider) => Container(
//               decoration: BoxDecoration(
//                 image: DecorationImage(
//                   image: imageProvider,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             placeholder: (context, url) => CircularProgressIndicator(),
//             errorWidget: (context, url, error) => Icon(Icons.account_circle,color: defultColor,size: 150),
//           ),
//         ),
//         SizedBox(height: 15,),
//         Container(
//           height: 70,
//             clipBehavior: Clip.antiAliasWithSaveLayer,
//             decoration: BoxDecoration(borderRadius: BorderRadius.circular(25),
//               border: Border.all(
//                   width: 1,
//                   color:Colors.grey[300]
//               ),),
//           child: Row(children: [
//             SizedBox(width: 10),
//             Icon(Icons.person ,color: defultColor,size: 40),
//             SizedBox(width: 15),
//
//             Text(getUserData.name),
//           ],)
//         ),
//         SizedBox(height: 15,),
//         Container(
//             height: 70,
//             clipBehavior: Clip.antiAliasWithSaveLayer,
//             decoration: BoxDecoration(borderRadius: BorderRadius.circular(25),
//               border: Border.all(
//                   width: 1,
//                   color:Colors.grey[300]
//               ),),
//             child: Row(children: [
//               SizedBox(width: 10),
//               Icon(Icons.email ,color: defultColor,size: 40),
//               SizedBox(width: 15),
//
//               Text(getUserData.email),
//             ],)
//         ),
//         SizedBox(height: 15,),
//         Container(
//             height: 70,
//             clipBehavior: Clip.antiAliasWithSaveLayer,
//             decoration: BoxDecoration(borderRadius: BorderRadius.circular(25),
//               border: Border.all(
//                   width: 1,
//                   color:Colors.grey[300]
//               ),),
//             child: Row(children: [
//               SizedBox(width: 10),
//               Icon(Icons.phone ,color: defultColor,size: 40),
//               SizedBox(width: 15),
//
//               Text(getUserData.phone),
//             ],)
//         ),
//         SizedBox(height: 15,),
//         InkWell(
//           onTap: (){
//             Navigator.pop(context);
//             AppCubit.get(context).ChangeIndex(2);
//            // NavigateTo(context: context,router: FavoritesScreen());
//             },
//           child: Container(
//               height: 70,
//               clipBehavior: Clip.antiAliasWithSaveLayer,
//               decoration: BoxDecoration(borderRadius: BorderRadius.circular(25),
//                 border: Border.all(
//                     width: 1,
//                     color:Colors.grey[300]
//                 ),),
//               child: Row(children: [
//                 SizedBox(width: 10),
//                 Icon(Icons.favorite ,color: defultColor,size: 40),
//                 SizedBox(width: 15),
//                 Text('Favorite Prouct'),
//                 Spacer(),
//                 Icon(
//                   Icons.navigate_next,
//                   color:defultColor ,
//                   size: 30,
//                 ),
//               ],)
//           ),
//         ),
//         SizedBox(height: 15,),
//         InkWell(
//           onTap: (){
//             NavigateTo(router: CartScreen(),context: context);
//           },
//           child: Container(
//               height: 70,
//               clipBehavior: Clip.antiAliasWithSaveLayer,
//               decoration: BoxDecoration(borderRadius: BorderRadius.circular(25),
//                 border: Border.all(
//                     width: 1,
//                     color:Colors.grey[300]
//                 ),),
//               child: Row(children: [
//                 SizedBox(width: 10),
//                 Icon(Icons.shopping_cart ,color: defultColor,size: 40),
//                 SizedBox(width: 15),
//                 Text('My Cart'),
//                 Spacer(),
//                 Icon(
//                   Icons.navigate_next,
//                   color:defultColor ,
//                   size: 30,
//                 ),
//               ],)
//           ),
//         ),
//
//
//
//     ],),
//   );
// }
