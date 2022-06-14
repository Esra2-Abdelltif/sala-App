

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salaa_app/layout/Bloc/cubit.dart';
import 'package:salaa_app/layout/Bloc/states.dart';
import 'package:salaa_app/models/contactUs/ContactUsModel.dart';
import 'package:salaa_app/shared/Constans/constans.dart';
import 'package:salaa_app/shared/Styles/colors.dart';
import 'package:salaa_app/shared/compoenets/components.dart';

import '../WebView_Screen/WebViewScreen.dart';


class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=> AppCubit()..getContctUs(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(

            appBar: AppBar(
              title: Text('Contact Us',),
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: defultColor,
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
              centerTitle: true,
            ),
            body: state is ShopLoadingGetSettingsState
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Container(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [

                              SizedBox(
                                height: 40.0,
                              ),
                              Container(
                                child: ListView.separated(
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) =>buildContcts(
                                    AppCubit.get(context).contactUsModel.data.data[index], index,context,
                                  ),
                                  separatorBuilder: (context, index) => SizedBox(
                                    height: 20.0,
                                  ),
                                  itemCount: 5,
                                   //    .contactUsModel.data.data.length,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
          );
        },
      ),
    );
  }
}

List<String> Website = ['Facebook', 'Instigram', 'Twitter', 'Gmail', 'Phone'];
Widget buildContcts(ContactData model, index,context)=> InkWell(
  onTap: (){
    NavigateTo(router: WebVeiwScreen(model.value),context: context);
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
        Image(
          image: NetworkImage(
            model.image,
          ),
          color: defultColor,
          width: 40.0,
          height: 40.0,
        ),
        SizedBox(width: 15),
        Text(Website[index]),
        Spacer(),
        Icon(
          Icons.navigate_next,
          color:defultColor ,
          size: 30,
        ),
      ],)
  ),
);

