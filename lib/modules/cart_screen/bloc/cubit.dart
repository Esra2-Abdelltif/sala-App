// import 'package:flutter/cupertino.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:salaa_app/models/Change_Card/ChangeCartModel.dart';
// import 'package:salaa_app/models/cartmodel/CartModel.dart';
// import 'package:salaa_app/modules/cart_screen/bloc/states.dart';
//
// import '../../../shared/Constans/constans.dart';
// import '../../../shared/Network/end_point/end_point.dart';
// import '../../../shared/Network/remote/dio_helper.dart';
//
// class CartCubit extends Cubit<CartStates> {
//   CartCubit() : super(InitialCartStates());
//
//   static CartCubit get(context) => BlocProvider.of(context);
//
//   Map<int,bool> CartList={};
//   ChangeCartsModel changeCartsModel;
//   void ChangeCart({@required int ProductId}){
//     CartList[ProductId] = !CartList[ProductId];
//     emit(LoadingsChangeCartStates());
//     DioHelper.postData(
//       Url: CART,
//       data:{
//         'product_id':ProductId,
//       },
//       token: token,
//     ).then((value) {
//       changeCartsModel=  ChangeCartsModel.fromJson(value.data);
//       print(value.data);
//       if(!changeCartsModel.status)
//       {
//         CartList[ProductId] = !CartList[ProductId];
//       }
//       else{
//         getCartData();
//       }
//
//       emit(SuccessChangeCartSuccessState(changeCartsModel));
//     }).catchError((error){
//       CartList[ProductId] = !CartList[ProductId];
//       print(error.toString());
//       emit(ErrorChangeCartStates(error.toString()));
//     });
//   }
//
// //Move Cart Product in Favorite Screen
//   CartModel cartModel;
//   void getCartData(){
//     emit(LoadingGetCartStates());
//     DioHelper.getData(
//       Url: CART,
//       token: token,
//     ).then((value) {
//       cartModel = CartModel.fromJson(value.data);
//       printFullText(value.data.toString());
//       print('get cart token${token}');
//
//       emit(SuccessGetCartState());
//
//     }).catchError((error){
//       print(error.toString());
//       emit(ErrorGetCartStates(error.toString()));
//     //
//
//     });
//
//   }
//
//
// //   //Plus and mins product in cart
// //   int quantity = 1;
// //
// //   void plusQuantity(CartModel model, index) {
// //     quantity = model.data.cartItems[index].quantity;
// //     quantity++;
// //     emit(ShopPlusQuantityState());
// //   }
// //
// //   void minusQuantity(CartModel model, index) {
// //     quantity = model.data.cartItems[index].quantity;
// //     if (quantity > 1) quantity--;
// //     emit(ShopMinusQuantityState());
// //   }
// //
// //
// // //calculte price
// //   void updateCartData({@ required String id, int quantity,
// //   }) {
// //     emit(ShopLoadingCountCartsState());
// //     DioHelper.putData(
// //       Url: '${UPDATECARTS + id}',
// //       data: {
// //         'quantity': quantity,
// //       },
// //       token: token,
// //     ).then((value) {
// //       emit(ShopSuccessCountCartsState());
// //       getCartData();
// //     }).catchError((error) {
// //       printFullText('ERROR UPDATE CARTS DATA' + error.toString());
// //       emit(ShopErrorCountCartsState());
// //     });
// //   }
// //
//
// }