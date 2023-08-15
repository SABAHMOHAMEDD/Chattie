abstract class RegisterStates {}

class RegisterInitState extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {}

class RegisterFailureState extends RegisterStates {
  String? errorMessage;

  RegisterFailureState({required this.errorMessage});
}

class CreateUserLoadingState extends RegisterStates {}

class CreateUserSuccessState extends RegisterStates {}

class CreateUserFailureState extends RegisterStates {
  String? errorMessage;

  CreateUserFailureState({required this.errorMessage});
}
