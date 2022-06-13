import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:salaa_app/layout/Bloc/states.dart';
import 'package:salaa_app/models/CategoriesDetailsModel/CategoriesDetailsModel.dart';
import 'package:salaa_app/models/Change_Card/ChangeCartModel.dart';
import 'package:salaa_app/models/cartmodel/CartModel.dart';
import 'package:salaa_app/models/contactUs/ContactUsModel.dart';
import 'package:salaa_app/models/prodect_details/ProductDetailsModel.dart';
import 'package:salaa_app/models/profileModel/ProfileModel.dart';
import 'package:salaa_app/models/categroy_model/categroy_model.dart';

import 'package:salaa_app/shared/Network/end_point/end_point.dart';
import 'package:salaa_app/models/categroy_model/categroy_model.dart';
import 'package:salaa_app/models/change_favorites_model/change_favorites_model.dart';
import 'package:salaa_app/models/favorites_model/favorites_model.dart';
import 'package:salaa_app/models/home_model/home_model.dart';
import 'package:salaa_app/models/login_model/login_model.dart';
import 'package:salaa_app/modules/cart_screen/cart_screen.dart';
import 'package:salaa_app/modules/CategoriesScreens/CategoriesScreen/cateogries_screen.dart';
import 'package:salaa_app/modules/favorites_screen/favorites_screen.dart';
import 'package:salaa_app/shared/Constans/constans.dart';
import 'package:salaa_app/shared/Network/end_point/end_point.dart';
import 'package:salaa_app/shared/Network/remote/dio_helper.dart';

import '../../models/SettingModel/SettingsModel.dart';
import '../../models/home_model/home_model.dart';
import '../../models/login_model/login_model.dart';
import '../../models/userDataModel/UserDateModel.dart';
import '../../modules/SettingScreens/screens/profile_screen/profile.dart';
import '../../modules/SettingScreens/setting_Home_Screen.dart';
import '../../modules/homeData_screen/homeData_screen.dart';
import '../../shared/Styles/theme/cubit/cubit.dart';

class AppCubit extends Cubit<AppStates>
{
  AppCubit() : super(InitialAppStates());
  static  AppCubit get(context) => BlocProvider.of(context);

  //Dark Mode
  bool IsDark=false;
  void ChangeAppMode(){
    IsDark = !IsDark;
    emit(AppChangeModeStates());
  }

  List<IconData> bottomsIcons = [
    Icons.home_outlined,
    Icons.widgets_outlined,
    Icons.favorite_border,
    Icons.settings_outlined,
    //Icons.home
  ];
  // FancyBottomNavigation

  List<BottomNavigationBarItem> bottomNavigation= const [
    BottomNavigationBarItem(
        icon: Icon(Icons.home), label: 'Home'),
    BottomNavigationBarItem(
        icon: Icon(Icons.category), label: 'Cateogries'),
    BottomNavigationBarItem(
        icon: Icon(Icons.favorite), label: 'Favorite'),
    BottomNavigationBarItem(
        icon: Icon(Icons.add_shopping_cart), label: 'Cart'),
    BottomNavigationBarItem(
        icon: Icon(Icons.settings), label: 'Settings'),
  ];

  List<Widget> Screen = [
    ProdectScreen(),
    CateogriesScreen(),
    FavoritesScreen(),
     Setting(),
    CartScreen(),
  ];

  //BottomNavBarState
  int CurrentIndex = 0;
  void ChangeIndex(int index,{context}){
    CurrentIndex=index;
    emit(AppChangeBottomNavBarStates());
  }


//Select Favorite Product
  Map<int,dynamic> FavoriteList={};
  ChangeIconeFavoriteModel changeIconeFavoriteModel;
  void ChangeIconFavorites({@required int ProductId}){
    FavoriteList[ProductId] = !FavoriteList[ProductId];
    emit(LoadingsChangeFavoritesStates());
    DioHelper.postData(
      Url: FAVORITES,
      data:{
        'product_id':ProductId,
      },
      token: token,
    ).then((value) {
      changeIconeFavoriteModel=  ChangeIconeFavoriteModel.fromJson(value.data);
      print(value.data);
      if(!changeIconeFavoriteModel.status)
      {
        FavoriteList[ProductId] = !FavoriteList[ProductId];
      }
      else{
        getFavoritesData();
      }

      emit(SuccessChangeFavoritesSuccessState(changeIconeFavoriteModel));
    }).catchError((error){
      FavoriteList[ProductId] = !FavoriteList[ProductId];
      print(error.toString());
      emit(ErrorChangeFavoritesStates(error.toString()));
    });
  }

//Move Favorite Product in Favorite Screen
  FavoritesModel favoritesModelDataModel;
  void getFavoritesData(){
    emit(LoadingGetFavoritesStates());
    DioHelper.getData(
      Url: FAVORITES,
      token: token,
    ).then((value) {
      favoritesModelDataModel = FavoritesModel.fromJson(value.data);
      printFullText(value.data.toString());
      print('get Favorite token${token}');


      emit(SuccessGetFavoritesState());


    }).catchError((error){
      print(error.toString());
      emit(ErrorGetFavoritesStates(error.toString()));


    });

  }

//Select Cart Product
  Map<int,bool> CartList={};
  ChangeCartsModel changeCartsModel;
  void ChangeCart({@required int ProductId}){
    emit(LoadingsChangeCartStates());
    DioHelper.postData(
      Url: CART,
      data:{
        'product_id':ProductId,
      },
      token: token,
    ).then((value) {
      changeCartsModel=  ChangeCartsModel.fromJson(value.data);
      print(value.data);
        getCartData();
      getProductsDetails(id: ProductId);


      emit(SuccessChangeCartSuccessState(changeCartsModel));
    }).catchError((error){
      CartList[ProductId] = !CartList[ProductId];
      print(error.toString());
      emit(ErrorChangeCartStates(error.toString()));
    });
  }
//product details
  ProductDetailsmodel productDetailsmodel  ;
  void getProductsDetails ({@required int id})async{
    await DioHelper.getData(Url:  "products/$id" ,token: token).then((value){
      productDetailsmodel =ProductDetailsmodel.fromJson(value.data);
      emit(SucessGetDetailsProductStates());
    }).catchError((erroe){
      emit(ErrorGetDetailsProductStates());
    });
  }

//Move Cart Product in Favorite Screen
  CartModel cartModel;
  void getCartData(){
    emit(LoadingGetCartStates());
    DioHelper.getData(
      Url: CART,
      token: token,
    ).then((value) {
      cartModel = CartModel.fromJson(value.data);
      printFullText(value.data.toString());
      print('get cart token${token}');

      emit(SuccessGetCartState());

    }).catchError((error){
      print(error.toString());
      emit(ErrorGetCartStates(error.toString()));


    });

  }


  //Plus and mins product in cart
  int quantity = 1;

  void plusQuantity(CartModel model, index) {
    quantity = model.data.cartItems[index].quantity;
    quantity++;
    emit(ShopPlusQuantityState());
  }

  void minusQuantity(CartModel model, index) {
    quantity = model.data.cartItems[index].quantity;
    if (quantity > 1) quantity--;
    emit(ShopMinusQuantityState());
  }


//calculte price
  void updateCartData({@ required String id, int quantity,
  }) {
    emit(ShopLoadingCountCartsState());
    DioHelper.putData(
      Url: '${UPDATECARTS + id}',
      data: {
        'quantity': quantity,
      },
      token: token,
    ).then((value) {
      emit(ShopSuccessCountCartsState());
      getCartData();
    }).catchError((error) {
      printFullText('ERROR UPDATE CARTS DATA' + error.toString());
      emit(ShopErrorCountCartsState());
    });
  }



//Get Product and Banner Data at Home
  HomeModel homeModel;
  void getHomeData(){
    emit(LoadingHomeDataStates());
    DioHelper.getData(
      Url: HOME,
      token: token,
    ).then((value) {
      homeModel =HomeModel.fromJson(value.data);
      homeModel.data.products.forEach((element) {
        FavoriteList.addAll({element.id: element.inFavorites});
      });
      print('FavoriteList :  ${FavoriteList.toString()}');

        getFavoritesData();


      emit(SuccessHomeDataStates());


    }).catchError((error){
      print(error.toString());
      emit(ErrorHomeDataStates(error.toString()));


    });

  }

//Get Gategories Data at Home

  CategoriesDataModel categoriesDataModel;
  void getCategoriesData(){
    emit(LoadingCategoriesDataStates());
    DioHelper.getData(
      Url: Get_CATEGORY,
      token: token,
    ).then((value) {
      categoriesDataModel = CategoriesDataModel.fromJson(value.data);
      printFullText(categoriesDataModel.toString());

      emit(SuccessCategoriesDataStates());


    }).catchError((error){
      print(error.toString());
      emit(ErrorCategoriesDataStates(error.toString()));


    });

  }

  //CarouselSlider
  int indexCarouselSider = 0;
  void ChangeindexCarouselSider(int index) {
    indexCarouselSider = index;
    emit(SuccessCategoriesDataStates());
  }



//CategoriesDetails
  CategoryDetailModel categoryDetailModel;
  void getCategoriesDetails({int categoryId}) {
    emit(LoadingCategoriesDetailsStates());
    DioHelper.getData(
      Url:'${Get_CATEGORY_Details+ categoryId.toString()}',
      token: token
    ).then(
          (value) {
        categoryDetailModel = CategoryDetailModel.fromJson(value.data);
        categoryDetailModel.data.productData.forEach((element) {
          FavoriteList.addAll({element.id: element.inFavorites});
        });
        print('SUCCESS Categroy DETAILS' + categoryDetailModel.data.productData.toString());
        getFavoritesData();
        emit(SuccessCategoriesDetailsStates());
      },
    ).catchError(
          (error) {
        emit(ErrorCategoriesDetailsStates(error.toString()));
        printFullText('ERROR PRODUCT DETAILS' + error.toString());
      },
    );
  }

//Setting About Us
  SettingsModel settingsModel;

  void getSettings() {
    emit(ShopLoadingGetSettingsState());
    DioHelper.getData(
        Url: SETTINGS,
        token: token
    ).then((value) {
      settingsModel = SettingsModel.fromJson(value.data);
      emit(ShopSuccessGetSettingsState());
      print("abut as ${settingsModel.data.about}");
    }).catchError((error) {
      //printFullText('ERROR SETTINGS ' + error.toString());
      emit(ShopErrorGetSettingsState(error.toString()));
    });
  }


//Contact Us
  ContactUsModel contactUsModel;

  void getContctUs() async{
   // emit(LoadingGetContactUsState());
     await DioHelper.getData(
      Url: CONTACT,
      token: token
    ).then((value) {
      contactUsModel = ContactUsModel.fromJson(value.data);
      emit(SuccessGetContactUsState());
    }).catchError((error) {
      emit(ErrorGetContactUsState());
    });
  }


}

