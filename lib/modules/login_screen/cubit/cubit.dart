import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salaa_app/models/login_model/login_model.dart';
import 'package:salaa_app/modules/login_screen/cubit/state.dart';
import 'package:salaa_app/shared/Network/remote/dio_helper.dart';

import '../../../shared/Network/end_point/end_point.dart';

class LoginCubit extends Cubit<LogInStates>
{
  LoginCubit() : super(InitialLogInStates());
  static  LoginCubit get(context) => BlocProvider.of(context);
  //هعمل object من model عشان اعرف acess عليه و اخد منه data
  LoginModel loginModel;

  void UserLogin({@required String email ,@required String password}){
    emit(LoginLoadingState());
    DioHelper.postData(Url: LOGIN,
        data:{
      'email':email,
      'password':password,
    },
    ).then((value) {
     loginModel= LoginModel.fromJson(value.data);

      emit(LoginSuccessState(loginModel));
    }).catchError((error){
      print(error.toString());
      emit(LoginErrorState(error.toString()));
    });
  }

  IconData suffix= Icons.visibility;
  bool secirty = true;
  void ChangePasswordVisibility(){
    secirty =!secirty;
   suffix= secirty ? Icons.visibility : Icons.visibility_off;
   emit(ChangePasswordVisibilityState());


  }

}