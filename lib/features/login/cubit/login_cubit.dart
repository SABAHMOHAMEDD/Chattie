import 'package:chat_tharwat/features/login/cubit/login_states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/cache_helper.dart';
import '../../register/models/user_model.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitState());

  static LoginCubit get(context) => BlocProvider.of(context);

  void loginUser(String? email, String? password) async {
    try {
      emit(LoginLoadingState());

      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: email!,
        password: password!,
      )
          .then((value) {
        CacheHelper.saveData(key: 'uId', value: value.user!.uid);
        print('TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT');
        print(CacheHelper.getData(key: 'uId'));

        //  print("user uId is : ${value.user!.uid}");
        print('TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT');

        emit(LoginSuccessState());

        GetUserData();
      });
    } on FirebaseAuthException catch (ex) {
      if (ex.code == 'user-not-found') {
        emit(LoginFailureState(errorMessage: "No user found for that email"));
      } else if (ex.code == 'wrong-password') {
        emit(LoginFailureState(
            errorMessage: "Wrong password provided for that user"));
      }
    } on Exception catch (ex) {
      emit(LoginFailureState(errorMessage: ex.toString()));
    }
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
}
