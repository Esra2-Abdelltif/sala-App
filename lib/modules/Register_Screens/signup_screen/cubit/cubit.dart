import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salaa_app/models/login_model/login_model.dart';
import 'package:salaa_app/modules/Register_Screens/login_screen/cubit/state.dart';
import 'package:salaa_app/modules/Register_Screens/signup_screen/cubit/state.dart';
import 'package:salaa_app/shared/Constans/constans.dart';
import 'package:salaa_app/shared/Network/remote/dio_helper.dart';

import '../../../../models/userDataModel/UserDateModel.dart';
import '../../../../shared/Network/end_point/end_point.dart';

class SignUpCubit extends Cubit<SignUpStates>
{
  SignUpCubit() : super(InitialSignUpStates());
  static  SignUpCubit get(context) => BlocProvider.of(context);
  //هعمل object من model عشان اعرف acess عليه و اخد منه data
  LoginModel loginModel;

  void UserSignUp({@required String email ,@required String password,@required String name ,@required String phone}){
    emit(SignUpLoadingState());
    DioHelper.postData(Url:  REGISTER,
        data:{
      'email':email,
      'password':password,
       'name':name,
      'phone':phone
    },
    ).then((value) {
      userDateModel= UserDateModel.fromJson(value.data);
      print( userDateModel.message);
      emit(SignUpSuccessState(userDateModel));
    }).catchError((error){
      print(error.toString());
      emit(SignUpErrorState(error.toString()));
    });
  }

  IconData suffix= Icons.visibility;
  bool secirty = true;
  void ChangePasswordVisibility(){
    secirty =!secirty;
    suffix= secirty ? Icons.visibility : Icons.visibility_off;
    emit(ChangePasswordVisibilityStates());


  }
}