import '../../register/models/user_model.dart';

abstract class HomeStates {}

class IntialState extends HomeStates {}

class ChangeBottomNavState extends HomeStates {}

class GetUserInitState extends HomeStates {}

class GetUserLoadingState extends HomeStates {}

class GetUserSuccessState extends HomeStates {
  UserModel? userModel;

  GetUserSuccessState({required this.userModel});
}

class GetUserFailureState extends HomeStates {
  String? errorMessage;

  GetUserFailureState({required this.errorMessage});
}

class GetAllUsersInitState extends HomeStates {}

class GetAllUsersLoadingState extends HomeStates {}

class GetAllUsersSuccessState extends HomeStates {}

class GetAllUsersFailureState extends HomeStates {
  String? errorMessage;

  GetAllUsersFailureState({required this.errorMessage});
}
