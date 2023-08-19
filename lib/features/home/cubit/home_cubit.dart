import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/cache_helper.dart';
import '../../layout/group_chat/pages/grid_group_chat_screen.dart';
import '../../layout/my_chats/pages/all_chats_screen.dart';
import '../../layout/settings/pages/settings_screen.dart';
import '../../register/models/user_model.dart';
import 'home_states.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(IntialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> Screens = [MyChatsScreen(), GroupChatScreen(), SettingsScreen()];
  List<String> title = [
    'Chats',
    'Groups',
    'Settings',
  ];

  void ChangebottomNavBar(int index) {
    if (index == 0) {
      GetAllUsers();
    }
    if (index == 1) {
      GetUserData();
    }
    currentIndex = index;
    emit(ChangeBottomNavState());
  }

  UserModel? model;

  void GetUserData() {
    emit(GetUserLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(CacheHelper.getData(key: 'uId'))
        .get()
        .then((value) {
      print(value.data());

      model = UserModel.fromJson(value.data()!);
      CacheHelper.saveData(key: 'uId', value: model!.uId);
      print('TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT');
      print("user uId is : ${CacheHelper.getData(key: 'uId')}");
      print('TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT');
      print(r"$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$");
      emit(GetUserSuccessState(userModel: model));
      print(model!.name);
      print(r"$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$");
    }).catchError((error) {
      print(error.toString());
      emit(GetUserFailureState(errorMessage: error.toString()));
    });
  }

  List<UserModel> users = [];

  void GetAllUsers() {
    users = [];
    emit(GetAllUsersLoadingState());
    FirebaseFirestore.instance.collection('users').get().then((value) {
      value.docs.forEach((element) {
        if (element.data()['uId'] != model!.uId) {
          users.add(UserModel.fromJson(element.data()));
        }
      });
      emit(GetAllUsersSuccessState());
    }).catchError((error) {
      emit(GetAllUsersFailureState(errorMessage: error.toString()));
      print(error.toString());
    });
  }
}
