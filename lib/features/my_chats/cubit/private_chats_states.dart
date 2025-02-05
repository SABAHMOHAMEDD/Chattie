
import '../models/private_message_model.dart';

abstract class PrivateChatsStates {}

class MyChatsInitStates extends PrivateChatsStates {}

class SendMessageSuccessStates extends PrivateChatsStates {}

class SendMessageFailurStates extends PrivateChatsStates {}

class GetMessageLoadingStates extends PrivateChatsStates {}

class GetMessageSuccessStates extends PrivateChatsStates {
  List<PrivateMessageModel> MessegesList;

  GetMessageSuccessStates({required this.MessegesList});
}

class GetMessageFailurStates extends PrivateChatsStates {}
