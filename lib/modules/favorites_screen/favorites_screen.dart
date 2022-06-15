import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salaa_app/models/favorites_model/favorites_model.dart';
import 'package:salaa_app/layout/Bloc/cubit.dart';
import 'package:salaa_app/layout/Bloc/states.dart';
import 'package:salaa_app/shared/Styles/colors.dart';
import 'package:salaa_app/shared/compoenets/components.dart';
import 'package:salaa_app/shared/compoenets/widgets.dart';

class FavoritesScreen extends StatelessWidget {


  const FavoritesScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
        listener: (BuildContext context,AppStates state)
        {
          if(state is InitialAppStates) print('intial state');
          if (state is SuccessChangeFavoritesSuccessState) {
            if (state.changeIconeFavoriteModel.status) {
              showError(massage:  state.changeIconeFavoriteModel.message, state: ToastState.SUCCESS,);
            } else {
              showError(massage:  state.changeIconeFavoriteModel.message, state: ToastState.ERROR);
            }
          }
        },

        builder: (BuildContext context ,AppStates state) {
          AppCubit cubit =AppCubit.get(context);
          var favoritecubit = AppCubit.get(context).favoritesModelDataModel ;

          return Scaffold(
            body: AppCubit.get(context).favoritesModelDataModel == null ?
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0 ),
              child: Center(
                  child: const CircularProgressIndicator(),),
            ) : AppCubit.get(context).favoritesModelDataModel.data.data.isEmpty ?
            Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,

              children: [
                Text ('Your Favorite  list is empty .',style: TextStyle(color: defultColor,fontSize: 20),),
                SizedBox(height: 60,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    BounceInDown(duration: Duration(seconds: 3),child: Square() ),
                    BounceInUp(duration: Duration(seconds: 3),child: Square() ),
                    BounceInLeft(duration: Duration(seconds: 3),child: Square() ),
                    BounceInRight(duration: Duration(seconds: 3),child: Square() ),

                  ],
                ),


              ],
            ))
                : ListView.separated(
                itemBuilder: ((context, index) => BuildListItem( AppCubit.get(context).favoritesModelDataModel.data.data[index].product,context)),
                separatorBuilder: ((context, index) => MyDivider(margin: 20)),
                itemCount: AppCubit.get(context).favoritesModelDataModel.data.data.length));
        }


    );


  }


}
