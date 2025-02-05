import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/cache_helper.dart';

import '../../group_chat/pages/grid_group_chat_screen.dart';
import '../../my_chats/pages/all_chats_screen.dart';
import '../../register/models/user_model.dart';
import 'home_states.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(IntialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> screens = [
    const MyChatsScreen(),
    GroupChatScreen(),
  ];
  List<String> title = [
    'Chats',
    'Groups',
  ];

  void changeBottomNavBar(int index) {
    if (index == 0) {

    }
    if (index == 1) {}
    currentIndex = index;
    emit(ChangeBottomNavState());
    getUserData();
  }

  List<UserModel> users = [];

  void getAllUsers() {
    users = [];
    emit(GetAllUsersLoadingState());
    FirebaseFirestore.instance.collection('users').get().then((value) {
      for (var element in value.docs) {
        if (element.data()['uId'] != CacheHelper.getData(key: 'uId')) {
          users.add(UserModel.fromJson(element.data()));
        }
      }
      emit(GetAllUsersSuccessState());
    }).catchError((error) {
      emit(GetAllUsersFailureState(errorMessage: error.toString()));
    });
  }

  File? profileImage;
  final picker = ImagePicker();

  Future<void> getProfileImageByGallery() async {
    XFile? imageFileProfile =
        await picker.pickImage(source: ImageSource.gallery);
    if (imageFileProfile == null) return;

    profileImage = File(imageFileProfile.path);
    emit(ProfileImagePickedByGallerySuccessState());
  }

  Future<void> getProfileImageByCam() async {
    XFile? imageFileProfile =
        await picker.pickImage(source: ImageSource.camera);
    if (imageFileProfile == null) return;
    profileImage = File(imageFileProfile.path);
    emit(ProfileImagePickedByCamSuccessState());
  }

  //upload image to firebase storage
  // then have the url to send it to firebase firestore in the update func

  void updateUserImages() {
    emit(UpdateUserImageLoadingState());
    if (profileImage != null) {
      uploadProfileImage();
    }
  }

  void uploadProfileImage() {
    FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage?.path ?? "").pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        CacheHelper.saveData(key: 'imagePath', value: profileImage!.path);


        updateUser(image: value);

        emit(ProfileUpLoadImagePickedByGallerySuccessState());
      }).catchError((error) {
        emit(ProfileUpLoadImagePickedByGalleryErrorState());
      });
    }).catchError((error) {
      emit(ProfileUpLoadImagePickedByGalleryErrorState());
    });
  }

  void updateUser({
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
      getUserData();
    }).catchError((error) {
      emit(UpdateUserDataErrorState(error.toString()));
    });
  }

  UserModel? model;

  void getUserData() {
    // emit(GetUserLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(CacheHelper.getData(key: 'uId'))
        .get()
        .then((value) {

      model = UserModel.fromJson(value.data()!);
      CacheHelper.saveData(key: 'uId', value: model!.uId);
      CacheHelper.saveData(key: 'userColor', value: model!.userBubbleColorId);
      CacheHelper.saveData(key: 'email', value: model!.email);
      CacheHelper.saveData(key: 'name', value: model!.name);
      CacheHelper.saveData(key: 'userImage', value: model!.userImage);

    }).catchError((error) {
      debugPrint(error.toString());
    });
  }


}
