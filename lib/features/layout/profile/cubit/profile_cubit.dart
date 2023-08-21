// import 'dart:io';
//
// import 'package:chat_tharwat/features/layout/profile/cubit/profile_states.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:image_picker/image_picker.dart';
//
// import '../../../../core/cache_helper.dart';
// import '../../../register/models/user_model.dart';
//
// class ProfileCubit extends Cubit<ProfileStates> {
//   ProfileCubit() : super(IntialState()); // need initial state in the super
//
//   static ProfileCubit get(context) => BlocProvider.of(context);
//
//
//   UserModel? model;
//
//   void GetUserData() {
//     emit(GetUserLoadingState());
//     FirebaseFirestore.instance
//         .collection('users')
//         .doc(CacheHelper.getData(key: 'uId'))
//         .get()
//         .then((value) {
//       emit(GetUserSuccessState());
//
//       print(value.data());
//
//       model = UserModel.fromJson(value.data()!);
//       CacheHelper.saveData(key: 'uId', value: model!.uId);
//       CacheHelper.saveData(key: 'email', value: model!.email);
//       CacheHelper.saveData(key: 'name', value: model!.name);
//       CacheHelper.saveData(key: 'userImage', value: model!.userImage);
//       print('TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT');
//       print("user uId is : ${CacheHelper.getData(key: 'uId')}");
//       print('TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT');
//       print(r"$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$");
//       print(model!.name);
//       print(r"$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$");
//     }).catchError((error) {
//       print(error.toString());
//       emit(GetUserFailureState(errorMessage: error.toString()));
//     });
//   }
// }
