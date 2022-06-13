import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:salaa_app/modules/favorites_screen/favorites_screen.dart';
import 'package:salaa_app/modules/search_screen/search_screen.dart';

import 'package:salaa_app/shared/Constans/constans.dart';
import 'package:salaa_app/shared/Styles/colors.dart';
import 'package:salaa_app/shared/Styles/theme/cubit/cubit.dart';
import 'package:salaa_app/layout/Bloc/cubit.dart';
import 'package:salaa_app/layout/Bloc/states.dart';
import 'package:salaa_app/shared/compoenets/widgets.dart';
import '../../modules/cart_screen/cart_screen.dart';


class HomeLayout extends StatelessWidget {

  var ScaffoldKey = GlobalKey<ScaffoldState>();
  var FormKey = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {


    return BlocConsumer<AppCubit,AppStates>(
        listener: (BuildContext context,AppStates state)
        {
        },
        builder: (BuildContext context ,AppStates state)
        {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            key: ScaffoldKey,
            appBar: AppBar(

                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 15,
                      backgroundImage: AssetImage('assets/images/shopping app logo1.png',),
                    ),
                    SizedBox(
                      width: 10,),
                    Text('Salaa ',style: TextStyle( fontFamily: 'Pacifico',color: defultColor,fontSize: 24))
                  ],
                ),
                actions: [
                  IconButton(
                      onPressed: (){
                        NavigateTo(router: SearchScreen(),context: context);
                      }, icon: Icon(Icons.search ,color: defultColor,size: 30,)),
                ]),
            body: cubit.Screen[cubit.CurrentIndex],
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                NavigateTo(router: CartScreen(),context: context);
              },
              child: Icon(Icons.shopping_cart),
              backgroundColor: defultColor,
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: BottomNavigationBarwidget(context,bgcolor: ThemeAppCubit.get(context).IsDark ? Colors.white:HexColor('333739') ,),
            //
            // bottomNavigationBar: BottomNavigationBar(
            //   items: cubit.bottomNavigation,
            //   currentIndex: cubit.CurrentIndex,
            //   onTap: (index) {
            //     cubit.ChangeIndex(index);
            //   },
            // ),



          );
        }

    );
  }
}
