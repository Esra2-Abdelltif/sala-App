import 'package:salaa_app/models/userDataModel/UserDateModel.dart';

abstract class ProfileStates
{
  const ProfileStates();
}
class InitialProfileStates extends ProfileStates{}

class ProfileLoadingStates extends ProfileStates{}
class ProfileSuccessStates extends ProfileStates{}
class ProfileErrorStates extends ProfileStates{
  final String error;
  ProfileErrorStates(this.error);
}


//UPDATE Profile
class UpdateProfileLoadingStates extends ProfileStates{}
class UpdateProfileSuccessState extends ProfileStates{
  final UserDateModel userDateModel;

  UpdateProfileSuccessState(this.userDateModel);
}
class UpdateProfileErrorStates extends ProfileStates{
  final String error;
  UpdateProfileErrorStates(this.error);
}