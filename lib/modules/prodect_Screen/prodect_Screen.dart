import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:salaa_app/models/categroy_model/categroy_model.dart';
import 'package:salaa_app/models/home_model/home_model.dart';
import 'package:salaa_app/layout/Bloc/cubit.dart';
import 'package:salaa_app/layout/Bloc/states.dart';
import 'package:salaa_app/shared/Styles/colors.dart';
import 'package:salaa_app/shared/Styles/size_config.dart';
import 'package:salaa_app/shared/compoenets/components.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../shared/Network/local/cacheHelper.dart';

class ProdectScreen extends StatelessWidget {
  const ProdectScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double width = SizeConfig.screenW;
    return Scaffold(
      body: BlocConsumer<AppCubit,AppStates>(
        listener: (BuildContext context,AppStates state)
        {
          if( state is InitialAppStates) print('loading AppShop ');
          if(state is SuccessChangeFavoritesSuccessState)
          {
            if(!state.changeIconeFavoriteModel.status)
            {
              showError(massage: state.changeIconeFavoriteModel.message ,
                  state: ToastState.ERROR,
                  gravity: ToastGravity.BOTTOM,
                  toastLength: Toast.LENGTH_LONG);
            }
          }
        },

        builder: (BuildContext context ,AppStates state) {
          AppCubit cubit = AppCubit.get(context);
          var productmodel=AppCubit.get(context).homeModel;
          var categorymodel=AppCubit.get(context).categoriesDataModel;


          return ConditionalBuilder(
            condition:cubit.homeModel !=null && cubit.categoriesDataModel !=null,
            fallback: (context)=>  const Center(
             // ignore: unnecessary_const
             child: const CircularProgressIndicator(),
            ),
            builder: (context) => SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Banner Slider
                  CarouselSlider(
                    options: CarouselOptions(
                      // height:double.infinity ,
                      initialPage: 0, //frist image
                      enableInfiniteScroll: true , //scroll lw7dh
                      reverse: false,//يقلب في تجاه واحد
                      aspectRatio: 16/9,
                      viewportFraction: 0.9,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 3),
                      autoPlayAnimationDuration: const Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastLinearToSlowEaseIn,
                      enlargeCenterPage: true,
                      onPageChanged: ((index, reason)=> AppCubit.get(context).ChangeindexCarouselSider(index)),
                      scrollDirection: Axis.horizontal,
                    ),
                    items:productmodel.data.banners.map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Image(image:NetworkImage('${i.image}'),width: double.infinity,fit: BoxFit.cover, );
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Center(child: AnimatedSmoothIndicator(
                    effect: const ExpandingDotsEffect(
                      activeDotColor: defultColor,
                      dotColor: Colors.grey,
                      dotHeight: 15,
                      dotWidth: 15,
                      expansionFactor: 3,
                      spacing: 10,
                    ),
                    count:AppCubit.get(context).homeModel.data.banners.length,
                    activeIndex:AppCubit.get(context).indexCarouselSider,
                  ) ),
                  const SizedBox(
                    height: 30,
                  ),
                  //buildCategory(categorymodel,context),
                  buildCategories(categorymodel,context),
                  buildProductItem(productmodel,context),

                ],),
            ),

          );

        },
      )

    );
  }

  Widget buildProductItem(HomeModel modelHome,BuildContext context)=> SingleChildScrollView(

        child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
    children: [
        //Banner Slider
        const Padding(
          padding: EdgeInsets.only(left: 15),
          child: Text('Product',style: TextStyle(fontSize: 30,color: defultColor)),
        ),
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
                children: List.generate(modelHome.data.products.length, (index) =>Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: (){
                          print('details');
                          // NavigateToProductsDetails(context ,data.id!);
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
                                          AppCubit.get(context).ChangeIconFavorites(ProductId: modelHome.data.products[index].id);
                                          },
                                        icon: (AppCubit.get(context).FavoriteList[AppCubit.get(context).homeModel.data.products[index].id])?const Icon( Icons.favorite ,size: 30,) :const Icon(Icons.favorite_border)  ,
                                        color: (AppCubit.get(context).FavoriteList[AppCubit.get(context).homeModel.data.products[index].id])? Colors.red : Colors.grey ,
                                      )
                                        ]
                                ),
                                Stack(
                                  alignment: Alignment.bottomRight,
                                  children: [
                                    Hero(
                                      tag: "${modelHome.data.products[index].id}",
                                       child: Image(
                                         image: NetworkImage("${modelHome.data.products[index].image}"),
                                         height:200, width: 200,
                                       ),
  ),
                                    (modelHome.data.products[index].discount !=0)?const Text("DISCOUNT",style: TextStyle(
                                      backgroundColor: Colors.red, color: Colors.white,
                                      fontSize: 13,),):const SizedBox(),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 3),
                                  child: Text("${modelHome.data.products[index].name}",
                                    overflow: TextOverflow.ellipsis,maxLines: 2,style:const TextStyle(color: Colors.black,height: 1.2, fontSize: 15.0,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 3),
                                  child: Row(
                                    children: [
                                      Text("${modelHome.data.products[index].price.round()}\$" ,
                                        style: const TextStyle(
                                            color: defultColor,
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      const SizedBox(width: 5,),
                                      (modelHome.data.products[index].discount !=0)? Text("${modelHome.data.products[index].oldPrice.round()}" ,
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



  Widget buildCategory(CategoriesDataModel categroyModel,BuildContext context,)=> Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 15),
        child: Row(
          children: [
            const Text('Category',style: const TextStyle(fontSize: 30,color: defultColor)),
            const Spacer(),
            IconButton(onPressed:(){
              AppCubit.get(context).ChangeIndex(1);
            }, icon:const Icon(Icons.apps_sharp,color: defultColor,size: 30,) )
          ],
        ),
      ),
      InkWell(
        onTap: (){
          //NavigateTo(router:,context: context);
          },
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            width: double.infinity,
            height:MediaQuery.of(context).size.height/5,
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemBuilder:(context ,index ){
                  return Container(
                    color: Colors.white,
                    child: Stack(
                      alignment: Alignment.bottomLeft,
                      children: [
                        Image(image: NetworkImage("${categroyModel.categoriesData.data[index].image}"),
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width/2,
                    ),
                        Container(
                         width: MediaQuery.of(context).size.width/2,
                          color: Colors.black.withOpacity(0.8) ,
                          child: Text(" ${categroyModel.categoriesData.data[index].name}",style: const TextStyle(
                              color:Colors.white,
                              fontSize: 18,
                              fontFamily: "Font1",

                          ),),
                        ),

                      ],
                    ),
                  );
                } ,
                separatorBuilder:(context ,index )=> SizedBox(width: 15,child: Container()),
                itemCount:categroyModel.categoriesData.data.length),
          ),
        ),
      ),
    ],
  );


  Widget buildCategories(CategoriesDataModel categroyModel,BuildContext context,)=> Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 15),
        child: Row(
          children: [
            const Text('Category',
                style: const TextStyle(fontSize: 30,color: defultColor)),
            const Spacer(),
            InkWell(onTap: (){
              AppCubit.get(context).ChangeIndex(1);
              },
                child: const Text('see all  ',style: const TextStyle(color: defultColor))),

          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          height: 60,
         // height:MediaQuery.of(context).size.height/5,
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemBuilder:(context ,index ){
                return InkWell(
                  onTap: (){

                  },

                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width: 1,
                        color: defultColor
                    ),
                      
                    ),

                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(" ${categroyModel.categoriesData.data[index].name}"),
                    ),
                  ),
                );
              } ,
              separatorBuilder:(context ,index )=> SizedBox(width: 15,child: Container()),
              itemCount:categroyModel.categoriesData.data.length),
        ),
      ),
    ],
  );
}
