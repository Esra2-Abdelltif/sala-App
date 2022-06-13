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
                        itemBuilder:(context,index)=>  BuildListItem(SearchCubit.get(context).model.data.data[index],context ,IsoldPrice: false, ),
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

  Widget BuildFavorite( model,BuildContext context)=> Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    child: Container(
      height: 146.0,
      //color: Colors.white,
      padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0, bottom: 8.0),
      //width: 150,
      child: Row(
        children: [
          Stack(
            alignment: AlignmentDirectional.topStart,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 65.0,
                    child: CachedNetworkImage(
                      imageUrl: model.image,
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      width: 95.0,
                      height: 95.0,
                      //fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              if (model.discount != 0)
                Container(
                  color: Colors.red,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Text(
                      'DISCOUNT',
                      style: TextStyle(fontSize: 8.0, color: Colors.white),
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(
            width: 10.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${model.name}",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 14.0, height: 1.3, color: Colors.grey[500]),
                ),
                //Spacer(),
                SizedBox(
                  height: 5.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      '${model.price.toString()}',
                      style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                          color: defultColor),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    if (model.oldPrice != 0)
                      Text(
                        "${model.oldPrice.toString()}",
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    Spacer(),
                    IconButton(
                      onPressed: (){
                        //print(modelHome.data.products[index].id);
                        AppCubit.get(context).ChangeIconFavorites(ProductId: model.id);
                      },
                      //  icon: Icon( Icons.favorite_border_rounded,size: 30,)   ,
                      // color: Colors.red  ,
                      icon: (AppCubit.get(context).FavoriteList[model.id])?const Icon( Icons.favorite ,size: 30,) :const Icon(Icons.favorite_border)  ,
                      color: (AppCubit.get(context).FavoriteList[model.id])? Colors.red : Colors.grey ,
                    ),

                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
