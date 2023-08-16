import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/cache_helper.dart';
import '../../register/models/user_model.dart';
import 'chat_states.dart';

class ChatCubit extends Cubit<ChatStates> {
  ChatCubit() : super(GetUserInitState());

  static ChatCubit get(context) => BlocProvider.of(context);

  UserModel? model;

  void GetUserData() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(CacheHelper.getData(key: 'uId'))
        .get()
        .then((value) {
      print(value.data());

      model = UserModel.fromJson(value.data()!);
      CacheHelper.saveData(key: 'uId', value: model!.uId);
      print('TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT');
      print("user uId is : ${model!.uId}");
      print('TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT');
      print(r"$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$");
      emit(GetUserSuccessState(userModel: model));
      print(model!.name);
      print(r"$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$");
    }).catchError((error) {
      print(error.toString());
    });
  }
}
