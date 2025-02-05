import '../models/group_messages_model.dart';

abstract class GroupChatStates {}

class GroupChatInit extends GroupChatStates {}

class EmaxGroupChatSuccessState extends GroupChatStates {
  List<MessagesModel> MessegesList;

  EmaxGroupChatSuccessState({required this.MessegesList});
}

class MogaGroupChatSuccessState extends GroupChatStates {
  List<MessagesModel> MessegesList;

  MogaGroupChatSuccessState({required this.MessegesList});
}
