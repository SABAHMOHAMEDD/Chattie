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
      // GetAllUsers();
    }
    if (index == 1) {
      //GetUserData();
    }
    currentIndex = index;
    emit(ChangeBottomNavState());
  }

  List<UserModel> users = [];

  void GetAllUsers() {
    users = [];
    emit(GetAllUsersLoadingState());
    FirebaseFirestore.instance.collection('users').get().then((value) {
      value.docs.forEach((element) {
        if (element.data()['uId'] != CacheHelper.getData(key: 'uId')) {
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
