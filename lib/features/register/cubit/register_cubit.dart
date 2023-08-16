import 'dart:math';

import 'package:chat_tharwat/features/register/cubit/register_states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/user_model.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitState());

  static RegisterCubit get(context) => BlocProvider.of(context);
  Random random = Random();

  void registerUser(String? email, String? password, String? name) async {
    try {
      emit(RegisterLoadingState());

      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email!,
        password: password!,
      )
          .then((value) {
        int randomNumber = random.nextInt(4);

        createUser(
          name: name!,
          email: email,
          uId: value.user!.uid,
          userBubbleColorId: randomNumber,
          userImage:
              'https://img.freepik.com/free-photo/young-student-woman-with-backpack-bag-holding-hand-with-thumb-up-gesture-isolated-white-wall_231208-11498.jpg?w=996&t=st=1669296316~exp=1669296916~hmac=783161709f71002b0e0825e73eea54c12d0d9a7157be9658d3b3fe3d05c51215',
        );
        // CacheHelper.saveData(key: 'uId', value: value.user!.uid);
        // print("user uId is : ${value.user!.uid}");
        emit(RegisterSuccessState());
      });
    } on FirebaseAuthException catch (ex) {
      if (ex.code == 'weak-password') {
        emit(RegisterFailureState(
            errorMessage: 'The password provided is too weak.'));
      } else if (ex.code == 'email-already-in-use') {
        emit(RegisterFailureState(
            errorMessage: 'The account already exists for that email'));
      }
    } catch (ex) {
      emit(RegisterFailureState(errorMessage: ex.toString()));
    }
  }

  void createUser({
    required String name,
    required String email,
    required String uId,
    required int userBubbleColorId,
    required String userImage,
  }) {
    try {
      emit(CreateUserLoadingState());
      UserModel model = UserModel(
        name: name,
        email: email,
        uId: uId,
        userBubbleColorId: userBubbleColorId,
        userImage:
            'https://img.freepik.com/free-photo/young-student-woman-with-backpack-bag-holding-hand-with-thumb-up-gesture-isolated-white-wall_231208-11498.jpg?w=996&t=st=1669296316~exp=1669296916~hmac=783161709f71002b0e0825e73eea54c12d0d9a7157be9658d3b3fe3d05c51215',
      );
      FirebaseFirestore.instance
          .collection('users')
          .doc(uId)
          .set(model.toJson())
          .then((value) {})
          .catchError((error) {
        print(error.toString());
      });
      emit(CreateUserSuccessState());
    } on FirebaseAuthException catch (ex) {
      emit(CreateUserFailureState(errorMessage: ex.code));
    } catch (ex) {
      emit(CreateUserFailureState(errorMessage: ex.toString()));
    }
  }
}
