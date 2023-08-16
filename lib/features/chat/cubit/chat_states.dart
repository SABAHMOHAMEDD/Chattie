import '../../register/models/user_model.dart';

abstract class ChatStates {}

class GetUserInitState extends ChatStates {}

class GetUserLoadingState extends ChatStates {}

class GetUserSuccessState extends ChatStates {
  UserModel? userModel;

  GetUserSuccessState({required this.userModel});
}

class GetUserFailureState extends ChatStates {
  String? errorMessage;

  GetUserFailureState({required this.errorMessage});
}
