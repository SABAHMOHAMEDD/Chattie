import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../register/models/user_model.dart';
import 'all_users_states.dart';

class AllUsersCubit extends Cubit<AllUsersCubitStates> {
  AllUsersCubit() : super(GetAllUsersInitState());

  static AllUsersCubit get(context) => BlocProvider.of(context);

  List<UserModel> users = [];

  void GetAllUsers() {
    emit(GetAllUsersLoadingState());
    FirebaseFirestore.instance.collection('users').get().then((value) {
      value.docs.forEach((element) {
        users.add(UserModel.fromJson(element.data()));
      });
      emit(GetAllUsersSuccessState());
    }).catchError((error) {
      emit(GetAllUsersFailureState(errorMessage: error.toString()));
      print(error.toString());
    });
  }
}
