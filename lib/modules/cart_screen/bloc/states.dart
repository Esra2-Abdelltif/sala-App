import 'package:flutter/cupertino.dart';
import 'package:salaa_app/models/Change_Card/ChangeCartModel.dart';
@immutable
abstract class CartStates
{
  const CartStates();
}
class InitialCartStates extends CartStates{}

//select Cart product
class LoadingsChangeCartStates extends CartStates{}
class SuccessChangeCartSuccessState extends CartStates{
  ChangeCartsModel  changeCartsModel;

  SuccessChangeCartSuccessState(this.changeCartsModel);
}
class ErrorChangeCartStates extends CartStates{
  final String error;
  ErrorChangeCartStates(this.error);
}



//Cart screen
class LoadingGetCartStates extends CartStates{}
class SuccessGetCartState extends CartStates{}
class ErrorGetCartStates extends CartStates{
  final String error;
  ErrorGetCartStates(this.error);
}
//Plus and mins product in cart
class ShopPlusQuantityState extends CartStates {}
class ShopMinusQuantityState extends CartStates{}
//calculte price
class ShopLoadingCountCartsState extends CartStates {}
class ShopSuccessCountCartsState extends CartStates {}
class ShopErrorCountCartsState extends CartStates {}

