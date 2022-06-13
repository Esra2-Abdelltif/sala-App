import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:salaa_app/models/login_model/login_model.dart';

import '../../../../models/userDataModel/UserDateModel.dart';

@immutable
abstract class LogInStates
{
  const LogInStates();
}

class InitialLogInStates extends LogInStates{}
class LoginLoadingState extends LogInStates{}
class LoginSuccessState extends LogInStates{
   UserDateModel userDateModel;

  LoginSuccessState(this.userDateModel);
}
class LoginErrorState extends LogInStates{
  final String error;
  LoginErrorState(this.error);
}
class ChangePasswordVisibilityState extends LogInStates{}
