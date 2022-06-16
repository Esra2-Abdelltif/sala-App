import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:salaa_app/layout/Bloc/cubit.dart';
import 'package:salaa_app/layout/Bloc/states.dart';
import 'package:salaa_app/models/home_model/home_model.dart';
import 'package:salaa_app/models/prodect_details/ProductDetailsModel.dart';
import 'package:salaa_app/modules/cart_screen/cart_screen.dart';
import 'package:salaa_app/shared/Constans/constans.dart';
import 'package:salaa_app/shared/Styles/colors.dart';
import 'package:salaa_app/shared/Styles/theme/cubit/cubit.dart';
import 'package:salaa_app/shared/compoenets/components.dart';

import '../../shared/compoenets/widgets.dart';

class ProductsDetails extends StatefulWidget {
  int productsId ;
  ProductsDetails({@required this.productsId});

  @override
  State<ProductsDetails> createState() => _ProductsDetailsState();
}

class _ProductsDetailsState extends State<ProductsDetails> {
  // int index;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>AppCubit(),
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context, state) {

          if (state is SuccessChangeCartSuccessState) {
            if (state.changeCartsModel.status) {
              showError(massage:  state.changeCartsModel.message, state: ToastState.SUCCESS,);
            } else {
              showError(massage:  state.changeCartsModel.message, state: ToastState.ERROR);
            }
          }
        } ,
        builder: (context, state) {
          AppCubit cubit =AppCubit.get(context);
          cubit.getProductsDetails(id: widget.productsId);
          // var prductmodel = AppCubit.get(context).productDetailsmodel.data;
          return Scaffold(
            appBar: AppBar(
              title: Text("Products Details"),
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
                condition:cubit.productDetailsmodel != null,
                fallback: (context)=>  const Center(
                  child: const CircularProgressIndicator(),
                ),
                builder: (context) => Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    SingleChildScrollView(
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        child:SingleChildScrollView(
                          child: Column(
                            children: [
                              Hero(
                                tag: "${cubit.productDetailsmodel.data.id}",
                                child: Stack(
                                  alignment: Alignment.bottomRight,
                                  children: [
                                    Image(
                                      image: NetworkImage("${cubit.productDetailsmodel.data.image}"),
                                      height: MediaQuery.of(context).size.height / 3,
                                    ),
                                    (cubit.productDetailsmodel?.data.discount != 0)?Text("DISCOUNT",style: TextStyle(
                                        color: Colors.white,
                                        backgroundColor: Colors.red,
                                        fontSize: 15
                                    ),):SizedBox(),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
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
                                      Text(cubit.productDetailsmodel.data.name, style: TextStyle(fontSize: 18.0, ),
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,),


                                      SizedBox(height: 10,),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            '\$${cubit.productDetailsmodel.data.price}',
                                            style: TextStyle(
                                              fontSize: 17.0,
                                              color: defultColor,
                                              //fontWeight: FontWeight.w900,
                                            ),
                                          ),

                                          SizedBox(
                                            width: 15.0,
                                          ),
                                          if ( cubit.productDetailsmodel.data.discount != 0)
                                            Text(
                                              '\$ ${ cubit.productDetailsmodel.data.oldPrice}',
                                              style: TextStyle(
                                                fontSize: 13.0,
                                                //fontWeight: FontWeight.w900,
                                                color: Colors.grey[800],
                                                decoration:
                                                TextDecoration.lineThrough,
                                              ),
                                            ),
                                          SizedBox(
                                            width: 8.0,
                                          ),
                                          Spacer(),
                                          if ( cubit.productDetailsmodel.data.discount != 0)
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10.0, vertical: 4.0),
                                              decoration: BoxDecoration(
                                                color: defultColor,
                                                borderRadius:
                                                BorderRadius.circular(18.0),
                                              ),
                                              child: Text(
                                                '${ cubit.productDetailsmodel.data.discount}% Off',
                                                style: TextStyle(
                                                  fontSize: 13.0,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                      SizedBox(height: 15,),
                                      MyDivider(margin: 10),
                                      SizedBox(height: 15,),
                                      Text('Description',
                                        style: TextStyle(fontSize: 18.0,),
                                      ),
                                      Text(
                                        cubit.productDetailsmodel.data.description,
                                        style: TextStyle(color: Colors.grey[800]),
                                      ),
                                      SizedBox(
                                        height: 15.0,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),




                            ],
                          ),
                        ) ,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(40.0),topRight:Radius.circular(40.0)),
                        color: ThemeAppCubit.get(context).IsDark ? HexColor('333739'):Colors.white ,
                        boxShadow: [
                          BoxShadow(blurRadius: 1, color: Color(0xFF8D8E98),spreadRadius: 0.1),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 14.0, left: 25, bottom: 15.0, right: 20.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Spacer(),
                            InkWell(
                              onTap: () {
                                cubit.ChangeCart(ProductId: cubit.productDetailsmodel.data.id);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color:defultColor),
                                width: 250.0,
                                height: 46,
                                padding: EdgeInsets.only(
                                    top: 8.0, bottom: 8.0, right: 8.0, left: 24.0),
                                child: Center(
                                  child: Text(
                                    (cubit.productDetailsmodel.data.inCart.toString() == "true")?
                                    "REROME FROM SALA" :"ADD TO SALA",
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17,),),
                                ),
                              ),
                            ),
                            Spacer(),
                          ],
                        ),
                      ),
                    ),

                  ],
                )

            ),


          );

        },

      ),
    );

  }

}