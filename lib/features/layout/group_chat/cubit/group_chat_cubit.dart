import 'package:chat_tharwat/features/layout/group_chat/models/group_messages_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constance/constants.dart';
import 'group_chat_states.dart';

class GroupChatCubit extends Cubit<GroupChatStates> {
  GroupChatCubit() : super(GroupChatInit());

  static GroupChatCubit get(context) => BlocProvider.of(context);

  void sendGroupMessages(
      {required String CollectionName,
      String? message,
      String? uId,
      String? userName,
      int? userColor}) {
    CollectionReference emaxMesseges =
        FirebaseFirestore.instance.collection(CollectionName);
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

  List<MessagesModel> groupMessegesList = [];

  void getGroupMessages(String CollectionName) {
    CollectionReference emaxMesseges =
        FirebaseFirestore.instance.collection(CollectionName);
    groupMessegesList = [];
    try {
      emaxMesseges.orderBy(kCreatedAt).snapshots().listen((event) {
        groupMessegesList = [];

        event.docs.forEach((element) {
          groupMessegesList.add(MessagesModel.fromJason(element.data()));

          emit(EmaxGroupChatSuccessState(MessegesList: groupMessegesList));
          print(r'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$');
        });
      });
    } on Exception catch (ex) {
      print(ex.toString());
    }
  }
}
