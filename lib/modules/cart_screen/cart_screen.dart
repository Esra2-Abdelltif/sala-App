import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:salaa_app/layout/Bloc/cubit.dart';
import 'package:salaa_app/layout/Bloc/states.dart';
import 'package:salaa_app/models/cartmodel/CartModel.dart';
import 'package:salaa_app/shared/Styles/colors.dart';
import 'package:salaa_app/shared/Styles/theme/cubit/cubit.dart';
import 'package:salaa_app/shared/compoenets/components.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=> AppCubit()..getCartData(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(title:Text( "Cart")),
            body: AppCubit.get(context).cartModel == null ?
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: Center(
                  child: LinearProgressIndicator()),
            ) : AppCubit.get(context).cartModel.data.cartItems.isEmpty ? Center(child: Text ('Your Cart list is empty .'))
                : Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 1,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 16.0,
                      right: 16.0,
                      left: 16.0,
                      bottom: MediaQuery.of(context).size.height / 8,
                    ),
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListView.separated(
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) => buildCarts(
                              AppCubit.get(context).cartModel.data.cartItems[index], context, index,),
                            separatorBuilder: (context, index) =>
                               MyDivider(),
                            itemCount: AppCubit.get(context).cartModel.data.cartItems.length,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                buildTotalPrice(
                    AppCubit.get(context).cartModel.data, context),
              ],
            ),
          );
        },
      ),
    );
  }


  Widget buildCarts(CartItems model, context, index,) => Container(
    height: 146.0,
    padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0, bottom: 8.0),
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
                    imageUrl: model.product.image,
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
            if (model.product.discount != 0)
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
                model.product.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 15.0, height: 1.3, color: Colors.grey[500]),
              ),
              SizedBox(
                height: 5.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    ' ${model.product.price}',
                    style: TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.bold,
                        color: defultColor),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  if (model.product.discount != 0)
                    Text(
                      model.product.oldPrice.toString(),
                      style: TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),

                ],
              ),

              Row(
                //mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Spacer(),
                    // Container(
                    //   width: 40,
                    //   height: 40,
                    //   child: FloatingActionButton(
                    //     onPressed: () {
                    //       AppCubit.get(context).plusQuantity(AppCubit.get(context).cartModel, index);
                    //       AppCubit.get(context).updateCartData(id: AppCubit.get(context).cartModel.data.cartItems[index].id.toString(), quantity: AppCubit.get(context).quantity,);
                    //     },
                    //     child:
                    //     Center(
                    //       child: Text('+',
                    //         style:
                    //         TextStyle(
                    //           fontSize: 22,
                    //           fontStyle: FontStyle.italic,
                    //           fontWeight: FontWeight.w500,
                    //         ),),
                    //     ),


                      //),
                    //),

                    //Button بعمل زرار جاهز بشكل الدائره
                    RawMaterialButton(
                      elevation: 2.0,
                      shape: CircleBorder(),
                      fillColor: defultColor,
                      onPressed: () {
                        AppCubit.get(context).plusQuantity(AppCubit.get(context).cartModel, index);
                        AppCubit.get(context).updateCartData(id: AppCubit.get(context).cartModel.data.cartItems[index].id.toString(), quantity: AppCubit.get(context).quantity,);
                      },
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 20.0,
                      ),
                      constraints: BoxConstraints.tightFor(
                        width: 40.0,
                        height: 40.0,
                      ),
                    ),
                    SizedBox(width: 8,),
                    Text((AppCubit.get(context).cartModel.data.cartItems[index].quantity.toString()), style: TextStyle(fontSize: 23.0),),
                    SizedBox(width: 8,),
                    RawMaterialButton(
                      elevation: 2.0,
                      shape: CircleBorder(),
                      fillColor: defultColor,
                      onPressed: () {
                        AppCubit.get(context).minusQuantity(
                            AppCubit.get(context).cartModel, index);
                        AppCubit.get(context).updateCartData(
                          id: AppCubit.get(context).cartModel.data.cartItems[index].id.toString(), quantity:AppCubit.get(context).quantity,
                        );
                      },
                      child: Icon(
                        Icons.remove,
                        color: Colors.white,
                        size: 20.0,
                      ),
                      constraints: BoxConstraints.tightFor(
                        width: 40.0,
                        height: 40.0,
                      ),
                    ),

                    IconButton(onPressed:() {
                      AppCubit.get(context).ChangeCart(ProductId: model.product.id);
                    }, icon:Icon( Icons.delete,color: Colors.red,size: 40,) )


                  ]),
            ],
          ),
        ),
      ],
    ),
  );

  Widget buildTotalPrice( model, context) => Container(
    //color: Colors.white,
    width: double.infinity,
    //height: 85.0,
    decoration: BoxDecoration(
     color: ThemeAppCubit.get(context).IsDark ? Colors.white :HexColor('333739'),
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
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Total',
                style: TextStyle(

                ),
              ),
              Text(
                '\$ ${model.total}',
                style: TextStyle(
                  color: defultColor,
                  fontSize: 20.0,
                  height: 1.2,
                  fontWeight: FontWeight.w900,
                  //backgroundColor: Colors.yellow,
                ),
              ),

            ],
          ),
          Spacer(),
          InkWell(
            onTap: () {

            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.0),
                  color:defultColor),
              width: 165.0,
              height: 46,
              padding: EdgeInsets.only(
                  top: 8.0, bottom: 8.0, right: 8.0, left: 24.0),
              child: Row(
                children: [
                  Text(
                    'Check Out',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 14.0,
                    ),
                  ),
                  Spacer(),
                  CircleAvatar(
                    radius: 15.0,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: defultColor,
                      size: 18.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );

}
