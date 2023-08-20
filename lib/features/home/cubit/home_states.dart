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
