import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salaa_app/layout/Bloc/states.dart';
import 'package:salaa_app/models/CategoriesDetailsModel/CategoriesDetailsModel.dart';
import 'package:salaa_app/modules/product_details/ProductsDetails.dart';
import 'package:salaa_app/shared/Constans/constans.dart';
import 'package:salaa_app/shared/Styles/colors.dart';
import 'package:salaa_app/shared/Styles/size_config.dart';
import 'package:salaa_app/shared/compoenets/widgets.dart';

import '../../../layout/Bloc/cubit.dart';


class CategoryDetailsScreen extends StatelessWidget {
  final String categoryName;
  CategoryDetailsScreen(this.categoryName);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double width = SizeConfig.screenW;
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        var productsmodel=AppCubit.get(context).categoryDetailModel;
        return Scaffold(
          appBar: AppBar(
            title: Text(categoryName),
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
            condition: productsmodel !=null,
            fallback: (context)=>  const Center(
              child: const CircularProgressIndicator(),
            ),
            builder: (context) => SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  buildProductItem(productsmodel,context),

                ],),
            ),

          )
        );
      },
    );
  }

  Widget buildProductItem(CategoryDetailModel model,BuildContext context)=> SingleChildScrollView(

    child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                child: GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: 1.0,
                    mainAxisSpacing: 1.0,
                    childAspectRatio: 1/2,
                    children: List.generate(model.data.productData.length, (index) =>Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: (){
                                NavigateTo(context: context,router:  ProductsDetails(productsId:model.data.productData[index].id,));

                              },
                              child: Container(
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(25),
                                  border: Border.all(width: 2, color:Colors.grey[300]),
                                  color: Colors.white,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children:
                                    [
                                      Row(
                                          children: [
                                            const Spacer(),
                                            IconButton(
                                              onPressed: (){
                                                //print(modelHome.data.products[index].id);
                                                AppCubit.get(context).ChangeIconFavorites(ProductId: model.data.productData[index].id);
                                              },
                                              icon: (AppCubit.get(context).FavoriteList[model.data.productData[index].id])?const Icon( Icons.favorite ,size: 30,) :const Icon(Icons.favorite_border)  ,
                                              color: (AppCubit.get(context).FavoriteList[model.data.productData[index].id])? Colors.red : Colors.grey ,
                                            )
                                          ]
                                      ),
                                      Stack(
                                        alignment: Alignment.bottomRight,
                                        children: [
                                          Hero(
                                            tag: "${model.data.productData[index].id}",
                                            child: Image(
                                              image: NetworkImage("${model.data.productData[index].image}"),
                                              height:200, width: 200,
                                            ),
                                          ),
                                          (model.data.productData[index].discount !=0)?const Text("DISCOUNT",style: TextStyle(
                                            backgroundColor: Colors.red, color: Colors.white,
                                            fontSize: 13,),):const SizedBox(),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 3),
                                        child: Text("${model.data.productData[index].name}",
                                          overflow: TextOverflow.ellipsis,maxLines: 2,style:const TextStyle(color: Colors.black,height: 1.2, fontSize: 15.0,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 3),
                                        child: Row(
                                          children: [
                                            Text("${model.data.productData[index].price.round()}\$" ,
                                              style: const TextStyle(
                                                  color: defultColor,
                                                  fontSize: 15.0,
                                                  fontWeight: FontWeight.bold
                                              ),
                                            ),
                                            const SizedBox(width: 5,),
                                            (model.data.productData[index].discount !=0)? Text("${model.data.productData[index].oldPrice.round()}" ,
                                              style: const TextStyle(color: Colors.grey,
                                                  fontSize: 15.0,
                                                  decoration: TextDecoration.lineThrough
                                              ),) : const SizedBox() ,
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                    ),
                    )
                )
            ),
          )
        ]

    ),
  );

}

