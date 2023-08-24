import 'package:another_flushbar/flushbar.dart';
import 'package:chat_tharwat/features/layout/group_chat/cubit/group_chat_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/cache_helper.dart';
import '../../../../core/check_internet_connection/cubit/internet_cubit.dart';
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
    Size screenSize = MediaQuery.of(context).size;

    return Builder(
      builder: (context) {
        GroupChatCubit.get(context).getGroupMessages(collectionName);

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
                  icon: const Icon(Icons.arrow_back_ios),
                ),
              ),
              backgroundColor: KSecondryColor,
              automaticallyImplyLeading: false,
              centerTitle: true,
              title: Text(
                collectionName,
                style: const TextStyle(color: KPrimaryColor),
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
                            reverse: true,
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
                            controller: messagecontroller,
                            //   maxLines: null,
                            textInputAction: TextInputAction.newline,
                            keyboardType: TextInputType.multiline,
                            cursorColor: KPrimaryColor,
                            style: const TextStyle(color: KPrimaryColor),
                            decoration: InputDecoration(
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      if (state is ConnectedState) {
                                        GroupChatCubit.get(context)
                                            .sendGroupMessages(
                                          userName:
                                              CacheHelper.getData(key: 'name'),
                                          CollectionName: collectionName,
                                          message: messagecontroller.text,
                                          uId: CacheHelper.getData(key: 'uId'),
                                          userColor: CacheHelper.getData(
                                              key: 'userColor'),
                                        );

                                        messagecontroller.clear();
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
                                    icon: Icon(Icons.send,
                                        color: KPrimaryColor.withOpacity(.8))),
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
