import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:salaa_app/models/login_model/login_model.dart';

import '../../../../models/userDataModel/UserDateModel.dart';
@immutable
abstract class SignUpStates
{
  const SignUpStates();
}

class InitialSignUpStates extends SignUpStates{}
class SignUpLoadingState extends SignUpStates{}
class SignUpSuccessState extends SignUpStates{
  UserDateModel userDateModel;

  SignUpSuccessState(this.userDateModel);
}
class SignUpErrorState extends SignUpStates{
  final String error;
  SignUpErrorState(this.error);
}
class ChangePasswordVisibilityStates extends SignUpStates{}
