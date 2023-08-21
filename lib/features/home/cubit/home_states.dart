import 'package:chat_tharwat/features/register/models/user_model.dart';

abstract class HomeStates {}

class IntialState extends HomeStates {}

class ChangeBottomNavState extends HomeStates {}

class GetAllUsersInitState extends HomeStates {}

class GetAllUsersLoadingState extends HomeStates {}

class GetAllUsersSuccessState extends HomeStates {}

class GetAllUsersFailureState extends HomeStates {
  String? errorMessage;

  GetAllUsersFailureState({required this.errorMessage});
}

class ProfileImagePickedByGallerySuccessState extends HomeStates {}

class ProfileImagePickedByGalleryErrorState extends HomeStates {}

class ProfileImagePickedByCamSuccessState extends HomeStates {}

class ProfileImagePickedByCamErrorState extends HomeStates {}

class ProfileUpLoadImagePickedByGallerySuccessState extends HomeStates {}

class ProfileUpLoadImagePickedByGalleryErrorState extends HomeStates {}

class ProfileUpLoadImagePickedByCamSuccessState extends HomeStates {}

class ProfileUpLoadImagePickedByCamErrorState extends HomeStates {}

class UpdateUserDataSuccessState extends HomeStates {}

class UpdateUserImageLoadingState extends HomeStates {}

class UpdateUserDataErrorState extends HomeStates {
  String error;

  UpdateUserDataErrorState(this.error);
}

class GetUserLoadingState extends HomeStates {}

class GetUserSuccessState extends HomeStates {
  UserModel? userModel;

  GetUserSuccessState({this.userModel});
}

class GetUserFailureState extends HomeStates {
  String? errorMessage;

  GetUserFailureState({required this.errorMessage});
}
