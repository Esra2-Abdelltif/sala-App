import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salaa_app/models/secrch_model/SearchModel.dart';
import 'package:salaa_app/modules/search_screen/bloc/cubit.dart';
import 'package:salaa_app/modules/search_screen/bloc/states.dart';
import 'package:salaa_app/shared/Styles/colors.dart';
import 'package:salaa_app/shared/compoenets/widgets.dart';

import '../../layout/Bloc/cubit.dart';
import '../../models/favorites_model/favorites_model.dart';

class SearchScreen extends StatelessWidget {

  var Searchcontroller = TextEditingController();
  var formkey =GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit,SearchStates>(
        listener: (BuildContext context,SearchStates state)
        {

        },
        builder:  (BuildContext context,SearchStates state){
         // var list =SearchCubit.get(context).SearchProduct("text");
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formkey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextFormField(
                        style: Theme.of(context).textTheme.bodyText1,
                        validator: (value){
                          if(value.isEmpty)
                            return 'Search must be not empty';
                          return null;
                        },
                        onFieldSubmitted: (String text){
                          SearchCubit.get(context).SearchProduct(text);

                        },
                        onSaved:(String text){
                         Searchcontroller = text as TextEditingController;
                        },
                        onChanged: (String text){
                          SearchCubit.get(context).SearchProduct(text);
                        },
                        controller: Searchcontroller,
                        keyboardType: TextInputType.text,

                        decoration: InputDecoration(
                          fillColor:  Color(0xFF8D8E98),
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: defultColor),),
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color:  Color(0xFF8D8E98) ),),
                          labelText: 'Search',
                          hintText: 'Search',
                          hintStyle: Theme.of(context).textTheme.bodyText2,
                          labelStyle: TextStyle(color:defultColor),
                          prefixIcon: Icon(Icons.search, color: defultColor),
                          border: OutlineInputBorder(),
                        )

                    ),
                  ),
                  SizedBox(height: 10,),
                  if(state is SearchLoadingStates)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: LinearProgressIndicator(),
                    ),
                  if(state is SearchSuccessStates)
                  Expanded(child: ConditionalBuilder(
                    builder: (context) =>ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemBuilder:(context,index)=>  BuildListItem(SearchCubit.get(context).model.data.data[index],context ,IsoldPrice: false,BuildIcon: false, ),
                        itemCount: SearchCubit.get(context).model.data.data.length),
                    condition:state is! SearchLoadingStates,


                  )),

                ],
              ),
            ),);
        },
      ),
    );
  }


}
