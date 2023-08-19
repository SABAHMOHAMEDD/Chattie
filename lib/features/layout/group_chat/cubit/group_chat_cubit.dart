import 'package:chat_tharwat/features/layout/group_chat/models/group_messages_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constance/constants.dart';
import 'group_chat_states.dart';

class GroupChatCubit extends Cubit<GroupChatStates> {
  GroupChatCubit() : super(GroupChatInit());

  static GroupChatCubit get(context) => BlocProvider.of(context);

  CollectionReference mogaMesseges =
      FirebaseFirestore.instance.collection(MogaCollection);

  void sendMogaMessages(
      String? message, String? uId, String? userName, int? userColor) {
    try {
      mogaMesseges.add({
        'message': message,
        'createdAt': DateTime.now(),
        'id': uId,
        'userName': userName,
        'userColor': userColor
      });
    } on Exception catch (ex) {
      print(ex.toString());
    }
  }

  List<MessagesModel> mogaMessegesList = [];

  void getMogaMessages() {
    try {
      FirebaseFirestore.instance
          .collection(MogaCollection)
          .orderBy(kCreatedAt)
          .snapshots()
          .listen((event) {
        event.docs.forEach((element) {
          mogaMessegesList.add(MessagesModel.fromJason(element.data()));
          emit(MogaGroupChatSuccessState(MessegesList: mogaMessegesList));
        });
      });
    } on Exception catch (ex) {
      print(ex.toString());
    }
  }

  CollectionReference emaxMesseges =
      FirebaseFirestore.instance.collection(emaxCollection);

  void sendEmaxMessages(
      String? message, String? uId, String? userName, int? userColor) {
    try {
      emaxMesseges.add({
        'message': message,
        'createdAt': DateTime.now(),
        'id': uId,
        'userName': userName,
        'userColor': userColor
      });
    } on Exception catch (ex) {
      print(ex.toString());
    }
  }

  List<MessagesModel> emaxMessegesList = [];

  void getEmaxMessages() {
    emaxMessegesList = [];
    try {
      emaxMesseges.orderBy(kCreatedAt).snapshots().listen((event) {
        emaxMessegesList = [];

        event.docs.forEach((element) {
          emaxMessegesList.add(MessagesModel.fromJason(element.data()));

          emit(EmaxGroupChatSuccessState(MessegesList: emaxMessegesList));
          print(r'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$');
        });
      });
    } on Exception catch (ex) {
      print(ex.toString());
    }
  }
}
