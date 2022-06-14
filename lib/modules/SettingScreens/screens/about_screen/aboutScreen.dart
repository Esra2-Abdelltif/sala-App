import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salaa_app/shared/Styles/colors.dart';

import '../../../../layout/Bloc/cubit.dart';
import '../../../../layout/Bloc/states.dart';


class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, AppStates state) {
        if(state is InitialAppStates) print('intial state');
      },
      builder: (context, AppStates state) {
        AppCubit cubit = AppCubit.get(context);
        var settingmodel=AppCubit.get(context).settingsModel;


        return Scaffold(

          appBar: AppBar(
            title: Text('About Us'),
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new_outlined,
                color: defultColor,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            centerTitle: true,

          ),
          body:ConditionalBuilder(
              condition:AppCubit.get(context).settingsModel !=null,
              fallback: (context)=>  Center(
                child: CircularProgressIndicator(),),
              builder: (context) =>  Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Container(
                    child:Column(
                      children: [
                        Image.asset('assets/images/shopping app logo1.png', width: 202.0, height: 177.0,),
                        SizedBox(
                          height: 35.0,
                        ),
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.grey[200].withOpacity(0.8),
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(30.0),
                                  topLeft: Radius.circular(30.0),
                                ),
                              ),
                              padding: EdgeInsets.only(top: 16.0, right: 16.0, left: 16.0, bottom: MediaQuery.of(context).size.height / 12,),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(AppCubit.get(context).settingsModel.data.about.toString(),style: TextStyle(color: Colors.black)),
                                ],
                              ),)
                        ),
                      ],
                    ),
                  ),
                ),
              ),


          ),

        );
      },
    );
  }
}
