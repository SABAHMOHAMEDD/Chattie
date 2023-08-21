import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/cache_helper.dart';
import '../../layout/group_chat/pages/grid_group_chat_screen.dart';
import '../../layout/my_chats/pages/all_chats_screen.dart';
import '../../register/models/user_model.dart';
import 'home_states.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(IntialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> Screens = [
    MyChatsScreen(),
    GroupChatScreen(),
  ];
  List<String> title = [
    'Chats',
    'Groups',
  ];

  void ChangebottomNavBar(int index) {
    if (index == 0) {
      GetUserData();
    }
    if (index == 1) {
      GetUserData();
    }
    currentIndex = index;
    emit(ChangeBottomNavState());
    GetUserData();
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

  File? profileimage;
  final picker = ImagePicker();

  Future<void> getProfileImageByGallery() async {
    XFile? imageFileProfile =
        await picker.pickImage(source: ImageSource.gallery);
    if (imageFileProfile == null) return null;

    profileimage = File(imageFileProfile.path);
    emit(ProfileImagePickedByGallerySuccessState());
  }

  Future<void> getProfileImageByCam() async {
    XFile? imageFileProfile =
        await picker.pickImage(source: ImageSource.camera);
    if (imageFileProfile == null) return;
    profileimage = File(imageFileProfile.path);
    emit(ProfileImagePickedByCamSuccessState());
  }

  //upload image to firebase storage
  // then have the url to send it to firebase firestore in the update func

  void UpdateUserImages() {
    emit(UpdateUserImageLoadingState());
    if (profileimage != null) {
      uploadProfileImage();
    }
  }

  void uploadProfileImage() {
    FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileimage?.path ?? "").pathSegments.last}')
        .putFile(profileimage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        UpdateUser(image: value);

        emit(ProfileUpLoadImagePickedByGallerySuccessState());
        print(value);
      }).catchError((error) {
        emit(ProfileUpLoadImagePickedByGalleryErrorState());
      });
    }).catchError((error) {
      emit(ProfileUpLoadImagePickedByGalleryErrorState());
    });
  }

  void UpdateUser({
    required String? image,
  }) {
    UserModel userModel = UserModel(
        name: CacheHelper.getData(
          key: 'name',
        ),
        email: CacheHelper.getData(
          key: 'email',
        ),
        uId: CacheHelper.getData(
          key: 'uId',
        ),
        userImage: image ??
            CacheHelper.getData(
              key: 'userImage',
            ),
        userBubbleColorId: 0);
    FirebaseFirestore.instance
        .collection('users')
        .doc(CacheHelper.getData(key: 'uId'))
        .update(userModel.toJson())
        .then((value) {
      emit(UpdateUserDataSuccessState());
      GetUserData();
    }).catchError((error) {
      emit(UpdateUserDataErrorState(error.toString()));
    });
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
      CacheHelper.saveData(key: 'email', value: model!.email);
      CacheHelper.saveData(key: 'name', value: model!.name);
      CacheHelper.saveData(key: 'userImage', value: model!.userImage);
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
}
