abstract class AllUsersCubitStates {}

class GetAllUsersInitState extends AllUsersCubitStates {}

class GetAllUsersLoadingState extends AllUsersCubitStates {}

class GetAllUsersSuccessState extends AllUsersCubitStates {}

class GetAllUsersFailureState extends AllUsersCubitStates {
  String? errorMessage;

  GetAllUsersFailureState({required this.errorMessage});
}
