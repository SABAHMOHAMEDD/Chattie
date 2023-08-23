import 'package:chat_tharwat/features/layout/group_chat/cubit/group_chat_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/cache_helper.dart';
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
  List<String> CollectionName = ['Emax', 'Mojah', 'Flayerhost', 'NDS'];

  @override
  Widget build(BuildContext context) {
    var collectionName = ModalRoute.of(context)!.settings.arguments as String;

    return Builder(
      builder: (context) {
        GroupChatCubit.get(context).getGroupMessages(collectionName);

        return Scaffold(
            backgroundColor: KSecondryColor,
            appBar: AppBar(
              scrolledUnderElevation: 0,
              elevation: 0,
              toolbarHeight: 100,
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
                collectionName,
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
                  Expanded(
                    child: BlocBuilder<GroupChatCubit, GroupChatStates>(
                      builder: (context, states) {
                        var messageslist =
                            GroupChatCubit.get(context).groupMessegesList;
                        return ListView.builder(
                            controller: scrollController,
                            itemCount: messageslist.length,
                            shrinkWrap: false,
                            itemBuilder: (context, index) {
                              print('yyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
                              print(uId);
                              print('yyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');

                              return messageslist[index].id ==
                                      CacheHelper.getData(key: 'uId')
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
                        cursorColor: KPrimaryColor,
                        style: const TextStyle(color: KPrimaryColor),
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: () {
                                  GroupChatCubit.get(context).sendGroupMessages(
                                    userName: CacheHelper.getData(key: 'name'),
                                    CollectionName: collectionName,
                                    message: messagecontroller.text,
                                    uId: CacheHelper.getData(key: 'uId'),
                                    userColor:
                                        CacheHelper.getData(key: 'userColor'),
                                  );

                                  messagecontroller.clear();

                                  scrollController.jumpTo(scrollController
                                      .position.maxScrollExtent);
                                  scrollController.animateTo(
                                    scrollController.position.maxScrollExtent,
                                    duration: const Duration(milliseconds: 100),
                                    curve: Curves.easeIn,
                                  );
                                },
                                icon: const Icon(Icons.send,
                                    color: KPrimaryColor)),
                            hintText: "Send a message",
                            hintStyle: const TextStyle(color: KPrimaryColor),
                            focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: KSecondryColor),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(18),
                                )),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(18),
                                ),
                                borderSide: BorderSide(color: KSecondryColor)),
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
      case 4:
        return Colors.red.shade200;
      case 5:
        return Colors.pinkAccent.shade100;
      case 6:
        return Colors.deepOrangeAccent.shade200;
      case 7:
        return Colors.blueAccent.shade100;
      case 8:
        return Colors.teal.shade200;
      case 9:
        return Colors.lightGreen.shade300;
      case 10:
        return Colors.brown.shade200;
      case 11:
        return Colors.cyan.shade200;
      case 12:
        return Colors.deepPurple.shade200;
      case 13:
        return Colors.green.shade200;
      case 14:
        return Colors.indigo.shade200;
      case 15:
        return Colors.teal.shade300;
      default:
        return KPrimaryColor;
    }
  }
}
