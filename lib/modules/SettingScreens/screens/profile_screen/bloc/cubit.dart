import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salaa_app/layout/Bloc/states.dart';
import 'package:salaa_app/models/secrch_model/SearchModel.dart';
import 'package:salaa_app/models/userDataModel/UserDateModel.dart';
import 'package:salaa_app/modules/SettingScreens/screens/profile_screen/bloc/states.dart';
import 'package:salaa_app/modules/search_screen/bloc/states.dart';
import 'package:salaa_app/shared/Constans/constans.dart';
import 'package:salaa_app/shared/Network/remote/dio_helper.dart';

import '../../../../../models/profileModel/ProfileModel.dart';
import '../../../../../shared/Network/end_point/end_point.dart';


class ProfileCubit extends Cubit<ProfileStates> {
  ProfileCubit() : super(InitialProfileStates());

  static ProfileCubit get(context) => BlocProvider.of(context);

  ProfileModel profileModel;
  void getProfileData()async
  {
    emit(ProfileLoadingStates());
    await DioHelper.getData(Url: PROFILE, token: token,).then((value) {
      profileModel = ProfileModel.fromJson(value.data);
      printFullText('User Data is  ${profileModel.data.name}');
      emit(ProfileSuccessStates());


    }).catchError((error){
      print(error.toString());
      emit(ProfileErrorStates(error.toString()));


    });

  }
  void UpdateUserData({ @required String name, @required String email, @required String phone,@required String image}){
    emit(UpdateProfileLoadingStates());
    DioHelper.putData(
      Url: UPDATE_PROFILE,

      data: {
        "name": name ,
        "email": email ,
        "phone" : phone,
        "image":image
      },
      token: token,
    ).then((value) {
      userDateModel = UserDateModel.fromJson(value.data);
      emit(UpdateProfileSuccessState(userDateModel));


    }).catchError((error){
      print(error.toString());
      emit(UpdateProfileErrorStates(error.toString()));


    });

  }

}