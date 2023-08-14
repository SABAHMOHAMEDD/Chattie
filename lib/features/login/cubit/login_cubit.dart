import 'package:chat_tharwat/features/login/cubit/login_states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitState());

  void loginUser(String? email, String? password) async {
    try {
      emit(LoginLoadingState());
      UserCredential user =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email!,
        password: password!,
      );
      emit(LoginSuccessState());
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
