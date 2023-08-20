import 'package:chat_tharwat/core/cache_helper.dart';
import 'package:chat_tharwat/features/layout/my_chats/cubit/private_chats_cubit.dart';
import 'package:chat_tharwat/features/layout/my_chats/cubit/private_chats_states.dart';
import 'package:chat_tharwat/features/register/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constance/constants.dart';
import '../../../../core/widgets/chat_bubble.dart';

class PrivateChatScreen extends StatelessWidget {
  static const routeName = "PrivateChatScreen";

  final TextEditingController messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    var userModel = ModalRoute.of(context)!.settings.arguments as UserModel;

    return Builder(
      builder: (context) {
        PrivateChatsCubit.get(context)
            .GetMessages(receiverId: CacheHelper.getData(key: 'userId'));

        return Scaffold(
            backgroundColor: KprimaryColor,
            appBar: AppBar(
              toolbarHeight: 100,
              leading: Padding(
                padding: const EdgeInsets.only(left: 30),
                child: IconButton(
                  color: Colors.white,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_ios),
                ),
              ),
              backgroundColor: Colors.blueGrey,
              automaticallyImplyLeading: false,
              centerTitle: true,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    userModel.name ?? "",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            body: Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(45),
                      topRight: Radius.circular(45))),
              child: Column(
                children: [
                  Expanded(
                      child:
                          BlocConsumer<PrivateChatsCubit, PrivateChatsStates>(
                    listener: (context, stats) {},
                    builder: (context, stats) {
                      return ListView.builder(
                          controller: scrollController,
                          itemCount:
                              PrivateChatsCubit.get(context).messages.length,
                          shrinkWrap: false,
                          itemBuilder: (context, index) {
                            var messages =
                                PrivateChatsCubit.get(context).messages;
                            print('yyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
                            print(uId);
                            print('yyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');

                            return CacheHelper.getData(key: 'uId') ==
                                    messages[index].senderId
                                ? ChatBubble(
                                    message: messages[index].message ?? "",
                                  )
                                : ChatBubbleFriend(
                                    message: messages[index].message ?? "",
                                    userBubbleColor: Colors.grey.shade200,
                                    isPrivateChat: true,
                                  );
                          });
                    },
                  )),
                  Container(
                    height: 70,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 8),
                      child: TextField(
                        onSubmitted: (message) {
                          messageController.clear();
                        },
                        controller: messageController,
                        //   maxLines: null,
                        textInputAction: TextInputAction.newline,
                        keyboardType: TextInputType.multiline,
                        cursorColor: Colors.blueGrey,
                        style: const TextStyle(color: Colors.blueGrey),
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: () {
                                  print(
                                      'meeeeeeeeeeee llllllllllllllllllllllllllllllllllllllllllllllll');
                                  print(CacheHelper.getData(key: 'uId'));
                                  print(
                                      'other oneeeeeee llllllllllllllllllllllllllllllllllllllllllllllll');
                                  print(CacheHelper.getData(key: 'userId'));

                                  PrivateChatsCubit.get(context)
                                      .sendPrivateMessage(
                                          receiverId: CacheHelper.getData(
                                              key: 'userId'),
                                          dateTime: DateTime.now().toString(),
                                          message: messageController.text,
                                          senderId:
                                              CacheHelper.getData(key: 'uId'));

                                  messageController.clear();
                                  scrollController.jumpTo(scrollController
                                      .position.maxScrollExtent);
                                  scrollController.animateTo(
                                    scrollController.position.maxScrollExtent,
                                    duration: const Duration(milliseconds: 100),
                                    curve: Curves.easeIn,
                                  );
                                },
                                icon: const Icon(Icons.send,
                                    color: Colors.blueGrey)),
                            hintText: "Send a message",
                            hintStyle: const TextStyle(color: Colors.blueGrey),
                            focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(18),
                                )),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(18),
                                ),
                                borderSide:
                                    BorderSide(color: Colors.grey.shade300)),
                            border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(18),
                                ),
                                borderSide: BorderSide(color: Colors.white))),
                      ),
                    ),
                  )
                ],
              ),
            ));
      },
    );
  }
}
