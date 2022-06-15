
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salaa_app/layout/Bloc/cubit.dart';
import 'package:salaa_app/shared/Constans/constans.dart';
import 'package:salaa_app/shared/Styles/colors.dart';

import '../../modules/product_details/ProductsDetails.dart';

Widget BuildListItem( model,BuildContext context,{bool IsoldPrice=true, bool BuildIcon=true, bool BuildIconCart =true })=> Padding(
  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
  child: InkWell(
    onTap: (){
      NavigateTo(context: context,router:  ProductsDetails(productsId:model.id,));

    },
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
                      width: 90.0,
                      height: 90.0,
                      //fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              if (model.discount != 0 && IsoldPrice)
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
                    if (model.oldPrice != 0 && IsoldPrice)
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
                    if(BuildIcon )
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
  ),
);

Widget BottomNavigationBarwidget(BuildContext context,{Color bgcolor })=>AnimatedBottomNavigationBar(
  backgroundColor: bgcolor,
  inactiveColor: Color(0xFF8D8E98),
  icons: AppCubit.get(context).bottomsIcons,
  activeIndex: AppCubit.get(context).CurrentIndex,
  onTap: (index) {
    AppCubit.get(context).ChangeIndex(index);
  },
  activeColor: defultColor,
  gapLocation: GapLocation.center,
  notchSmoothness: NotchSmoothness.softEdge,
  leftCornerRadius: 32,
  rightCornerRadius: 32,
);


Widget Square()=>Container(
  width: 50,
  height: 50,
  decoration: BoxDecoration(
    color:defultColor,
  ),
);

