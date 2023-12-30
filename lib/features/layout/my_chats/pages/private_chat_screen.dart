import 'package:another_flushbar/flushbar.dart';
import 'package:chat_tharwat/core/cache_helper.dart';
import 'package:chat_tharwat/features/layout/my_chats/cubit/private_chats_cubit.dart';
import 'package:chat_tharwat/features/layout/my_chats/cubit/private_chats_states.dart';
import 'package:chat_tharwat/features/register/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/check_internet_connection/cubit/internet_cubit.dart';
import '../../../../core/constance/constants.dart';
import '../../../../core/widgets/chat_bubble.dart';

class PrivateChatScreen extends StatelessWidget {
  final TextEditingController messageController = TextEditingController();

  final ScrollController scrollController = ScrollController();
  static const routeName = "PrivateChatScreen";

  @override
  Widget build(BuildContext context) {
    var userModel = ModalRoute.of(context)!.settings.arguments as UserModel;
    Size screenSize = MediaQuery.of(context).size;

    return Builder(
      builder: (context) {
        PrivateChatsCubit.get(context).GetMessages(receiverId: userModel.uId);
        return Scaffold(
            backgroundColor: KSecondryColor,
            appBar: AppBar(
              scrolledUnderElevation: 0,
              elevation: 0,
              toolbarHeight: screenSize.height / 9,
              leading: Padding(
                padding: const EdgeInsets.only(left: 30),
                child: IconButton(
                  color: KPrimaryColor,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_ios),
                ),
              ),
              backgroundColor: KSecondryColor,
              automaticallyImplyLeading: false,
              centerTitle: true,
              title: Text(
                userModel.name ?? "",
                style: TextStyle(color: KPrimaryColor),
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
                  Expanded(child: Builder(
                    builder: (context) {
                      return BlocConsumer<PrivateChatsCubit,
                          PrivateChatsStates>(
                        listener: (context, stats) {},
                        builder: (context, stats) {
                          var messages =
                              PrivateChatsCubit.get(context).messages;
                          return ListView.builder(
                              reverse: true,
                              controller: scrollController,
                              itemCount: PrivateChatsCubit.get(context)
                                  .messages
                                  .length,
                              shrinkWrap: false,
                              itemBuilder: (context, index) {
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
                      );
                    },
                  )),
                  Container(
                    height: 70,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 8),
                      child: BlocConsumer<InternetCubit, InternetState>(
                        listener: (context, state) {
                          if (state is NotConnectedState) {
                            Flushbar(
                              flushbarStyle: FlushbarStyle.FLOATING,
                              flushbarPosition: FlushbarPosition.TOP,
                              borderRadius: BorderRadius.circular(25),
                              margin: const EdgeInsets.all(25),
                              message: state.message,
                              duration: const Duration(seconds: 3),
                              backgroundColor: Colors.red.shade400,
                            ).show(context);
                          } else if (state is ConnectedState) {
                            Flushbar(
                              flushbarStyle: FlushbarStyle.FLOATING,
                              margin: const EdgeInsets.all(25),
                              flushbarPosition: FlushbarPosition.TOP,
                              borderRadius: BorderRadius.circular(25),
                              message: state.message,
                              duration: const Duration(seconds: 3),
                              backgroundColor: Colors.green.shade400,
                            ).show(context);
                          }
                        },
                        builder: (context, state) {
                          return TextField(
                            controller: messageController,
                            //   maxLines: null,
                            textInputAction: TextInputAction.newline,
                            keyboardType: TextInputType.multiline,
                            cursorColor: KPrimaryColor,
                            style: TextStyle(color: KPrimaryColor),

                            decoration: InputDecoration(
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      print(
                                          'meeeeeeeeeeee llllllllllllllllllllllllllllllllllllllllllllllll');
                                      print(CacheHelper.getData(key: 'uId'));
                                      print(
                                          'other oneeeeeee llllllllllllllllllllllllllllllllllllllllllllllll');
                                      print(CacheHelper.getData(key: 'userId'));

                                      if (state is ConnectedState) {
                                        PrivateChatsCubit.get(context)
                                            .sendPrivateMessage(
                                                receiverId: CacheHelper.getData(
                                                    key: 'userId'),
                                                dateTime:
                                                    DateTime.now().toString(),
                                                message: messageController.text,
                                                senderId: CacheHelper.getData(
                                                    key: 'uId'));

                                        messageController.clear();
                                      } else if (state is NotConnectedState) {
                                        Flushbar(
                                          flushbarStyle: FlushbarStyle.FLOATING,
                                          margin: EdgeInsets.all(25),
                                          flushbarPosition:
                                              FlushbarPosition.TOP,
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          message: state.message,
                                          duration: Duration(seconds: 3),
                                          backgroundColor: Colors.red.shade400,
                                        ).show(context);
                                      }

                                      scrollController.animateTo(
                                        0,
                                        duration:
                                            const Duration(milliseconds: 500),
                                        curve: Curves.easeIn,
                                      );
                                    },
                                    icon: const Icon(Icons.send,
                                        color: KPrimaryColor)),
                                hintText: "Send a message",
                                hintStyle: TextStyle(
                                    color: KPrimaryColor.withOpacity(.8),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400),
                                focusedBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: KSecondryColor),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(18),
                                    )),
                                enabledBorder: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(18),
                                    ),
                                    borderSide:
                                        BorderSide(color: KSecondryColor)),
                                border: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(18),
                                    ),
                                    borderSide:
                                        BorderSide(color: Colors.white))),
                          );
                        },
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
