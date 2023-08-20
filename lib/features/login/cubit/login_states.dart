import '../../register/models/user_model.dart';

abstract class LoginStates {}

class LoginInitState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {}

class LoginFailureState extends LoginStates {
  String? errorMessage;

  LoginFailureState({required this.errorMessage});
}

class GetUserLoadingState extends LoginStates {}

class GetUserSuccessState extends LoginStates {
  UserModel? userModel;

  GetUserSuccessState({required this.userModel});
}

class GetUserFailureState extends LoginStates {
  String? errorMessage;

  GetUserFailureState({required this.errorMessage});
}
