import 'package:flutter_bloc/flutter_bloc.dart';

import 'chat_states.dart';

class ChatCubit extends Cubit<ChatStates> {
  ChatCubit() : super(GetMessaeInitState());

  static ChatCubit get(context) => BlocProvider.of(context);


}
