import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:salaa_app/models/Change_Card/ChangeCartModel.dart';
import 'package:salaa_app/models/profileModel/ProfileModel.dart';
import 'package:salaa_app/models/login_model/login_model.dart';
import 'package:salaa_app/models/secrch_model/SearchModel.dart';
import 'package:salaa_app/models/userDataModel/UserDateModel.dart';

import '../../models/SettingModel/SettingsModel.dart';
import '../../models/change_favorites_model/change_favorites_model.dart';

@immutable
abstract class AppStates
{
  const AppStates();
}

class InitialAppStates extends AppStates{}
//Change App Mode
class AppChangeModeStates extends AppStates{}

//Change between BottomNavBar
class AppChangeBottomNavBarStates extends AppStates{}

//CarouselSlide of banner
class ChangeIndexCarouselSliderState extends AppStates{}

//Get Product and Banner Data at Home
class LoadingHomeDataStates extends AppStates{}
class SuccessHomeDataStates extends AppStates{}
class ErrorHomeDataStates extends AppStates{
  final String error;
  ErrorHomeDataStates(this.error);
}

//category screen
class LoadingCategoriesDataStates extends AppStates{}
class SuccessCategoriesDataStates extends AppStates{}
class ErrorCategoriesDataStates extends AppStates{
  final String error;
  ErrorCategoriesDataStates(this.error);
}

//select favorite product
class LoadingsChangeFavoritesStates extends AppStates{}
class SuccessChangeFavoritesSuccessState extends AppStates{
  ChangeIconeFavoriteModel  changeIconeFavoriteModel;

  SuccessChangeFavoritesSuccessState(this.changeIconeFavoriteModel);
}
class ErrorChangeFavoritesStates extends AppStates{
  final String error;
  ErrorChangeFavoritesStates(this.error);
}



//favorite screen
class LoadingGetFavoritesStates extends AppStates{}
class SuccessGetFavoritesState extends AppStates{}
class ErrorGetFavoritesStates extends AppStates{
  final String error;
  ErrorGetFavoritesStates(this.error);
}


//select Cart product
class LoadingsChangeCartStates extends AppStates{}
class SuccessChangeCartSuccessState extends AppStates{
  ChangeCartsModel  changeCartsModel;

  SuccessChangeCartSuccessState(this.changeCartsModel);
}
class ErrorChangeCartStates extends AppStates{
  final String error;
  ErrorChangeCartStates(this.error);
}

//product details
class SucessGetDetailsProductStates extends AppStates {}
class ErrorGetDetailsProductStates extends AppStates {}


//Cart screen
class LoadingGetCartStates extends AppStates{}
class SuccessGetCartState extends AppStates{}
class ErrorGetCartStates extends AppStates{
  final String error;
  ErrorGetCartStates(this.error);
}
//Plus and mins product in cart
class ShopPlusQuantityState extends AppStates {}
class ShopMinusQuantityState extends AppStates{}
//calculte price
class ShopLoadingCountCartsState extends AppStates {}
class ShopSuccessCountCartsState extends AppStates {}
class ShopErrorCountCartsState extends AppStates {}




//About Us
class ShopLoadingGetSettingsState extends AppStates {}
class ShopSuccessGetSettingsState extends AppStates{}
class ShopErrorGetSettingsState extends AppStates {
  final String error;
  ShopErrorGetSettingsState(this.error);
}



//CategoryDetails screen
class LoadingCategoriesDetailsStates extends AppStates{}
class SuccessCategoriesDetailsStates extends AppStates{}
class ErrorCategoriesDetailsStates extends AppStates{
  final String error;
  ErrorCategoriesDetailsStates(this.error);
}



//contact US
class LoadingGetContactUsState extends AppStates {}

class SuccessGetContactUsState extends AppStates {}

class ErrorGetContactUsState extends AppStates {}
