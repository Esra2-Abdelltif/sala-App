import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
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


//profile
class LoadingGetUserDataStates extends AppStates{}
class SuccessGeUserDataState extends AppStates{
  final  UserDateModel userDateModel;

  SuccessGeUserDataState(this.userDateModel);
}
class ErrorGetUserDataStates extends AppStates{
  final String error;
  ErrorGetUserDataStates(this.error);
}

//UPDATE Profile
class LoadingUpdateUserDataStates extends AppStates{}
class SuccessUpdateDataState extends AppStates{
  final UserDateModel userDateModel;

  SuccessUpdateDataState(this.userDateModel);
}
class ErrorUpdateUserDataStates extends AppStates{
  final String error;
  ErrorUpdateUserDataStates(this.error);
}


//About Us
class ShopLoadingGetSettingsState extends AppStates {}
class ShopSuccessGetSettingsState extends AppStates{}
class ShopErrorGetSettingsState extends AppStates {
  final String error;
  ShopErrorGetSettingsState(this.error);
}






