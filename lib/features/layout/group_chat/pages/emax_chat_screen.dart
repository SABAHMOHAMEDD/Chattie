import 'package:chat_tharwat/features/home/cubit/home_cubit.dart';
import 'package:chat_tharwat/features/home/cubit/home_states.dart';
import 'package:chat_tharwat/features/layout/group_chat/cubit/group_chat_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../core/constance/constants.dart';
import '../../../../core/widgets/chat_bubble.dart';
import '../cubit/group_chat_cubit.dart';

class EmaxChatScreen extends StatefulWidget {
  static const routeName = "EmaxChatScreen";

  @override
  State<EmaxChatScreen> createState() => _EmaxChatScreenState();
}

class _EmaxChatScreenState extends State<EmaxChatScreen> {
  final TextEditingController messagecontroller = TextEditingController();
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if (state is GetUserSuccessState) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (GroupChatCubit.get(context).emaxMessegesList.isNotEmpty) {
              scrollController.animateTo(
                scrollController.position.maxScrollExtent,
                duration: const Duration(milliseconds: 100),
                curve: Curves.easeInOut,
              );
            }
          });
        }
      },
      builder: (context, state) {
        if (state is GetUserSuccessState) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (GroupChatCubit.get(context).emaxMessegesList.isNotEmpty) {
              scrollController.animateTo(
                scrollController.position.maxScrollExtent,
                duration: const Duration(milliseconds: 100),
                curve: Curves.easeInOut,
              );
            }
          });

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
                title: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      height: 60,
                      image: AssetImage(KLogo),
                      fit: BoxFit.cover,
                    ),
                    Text(
                      "Emax",
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
                      child: BlocBuilder<GroupChatCubit, GroupChatStates>(
                        builder: (context, states) {
                          var messageslist =
                              GroupChatCubit.get(context).emaxMessegesList;
                          return ListView.builder(
                              controller: scrollController,
                              itemCount: messageslist.length,
                              shrinkWrap: false,
                              itemBuilder: (context, index) {
                                print('yyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
                                print(uId);
                                print('yyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');

                                return messageslist[index].id ==
                                        HomeCubit.get(context).model!.uId
                                    ? ChatBubble(
                                        message:
                                            messageslist[index].message ?? "",
                                        userName:
                                            messageslist[index].userName ?? "",
                                      )
                                    : ChatBubbleFriend(
                                        message:
                                            messageslist[index].message ?? "",
                                        userName:
                                            messageslist[index].userName ?? "",
                                        userBubbleColor: userBubbleColor(
                                            messageslist[index].userColor),
                                        isPrivateChat: false,
                                      );
                              });
                        },
                      ),
                    ),
                    Container(
                      height: 70,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 8),
                        child: TextField(
                          onSubmitted: (message) {
                            // mess.add({'message': message});
                            messagecontroller.clear();
                          },
                          controller: messagecontroller,
                          //   maxLines: null,
                          textInputAction: TextInputAction.newline,
                          keyboardType: TextInputType.multiline,
                          cursorColor: Colors.blueGrey,
                          style: const TextStyle(color: Colors.blueGrey),
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    GroupChatCubit.get(context)
                                        .sendEmaxMessages(
                                            messagecontroller.text,
                                            HomeCubit.get(context).model!.uId,
                                            HomeCubit.get(context)
                                                    .model!
                                                    .name ??
                                                "",
                                            HomeCubit.get(context)
                                                    .model!
                                                    .userBubbleColorId ??
                                                0);

                                    messagecontroller.clear();

                                    scrollController.jumpTo(scrollController
                                        .position.maxScrollExtent);
                                    scrollController.animateTo(
                                      scrollController.position.maxScrollExtent,
                                      duration:
                                          const Duration(milliseconds: 100),
                                      curve: Curves.easeIn,
                                    );
                                  },
                                  icon: const Icon(Icons.send,
                                      color: Colors.blueGrey)),
                              hintText: "Send a message",
                              hintStyle:
                                  const TextStyle(color: Colors.blueGrey),
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
        } else {
          return Scaffold(
            body: Center(
                child: LoadingAnimationWidget.inkDrop(
              color: KprimaryColor,
              size: 35,
            )),
          );
        }
      },
    );
  }

  userBubbleColor(int? userBubbleColorId) {
    switch (userBubbleColorId) {
      case 0:
        return Colors.orange.shade200;
      case 1:
        return Colors.blue.shade200;
      case 2:
        return Colors.green.shade200;
      case 3:
        return Colors.pink.shade200;
      default:
        return Colors.blue.shade100;
    }
  }
}
