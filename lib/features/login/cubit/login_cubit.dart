import 'package:chat_tharwat/features/login/cubit/login_states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/cache_helper.dart';

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

        // GetUserData();
        emit(LoginSuccessState());
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
}
