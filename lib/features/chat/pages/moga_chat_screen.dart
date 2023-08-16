import 'package:chat_tharwat/features/chat/cubit/chat_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constance/constants.dart';
import '../../../core/widgets/chat_bubble.dart';
import '../cubit/chat_states.dart';
import '../models/messages_model.dart';

class MogaChatScreen extends StatefulWidget {
  static const routeName = "MogaChatScreen";

  @override
  State<MogaChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<MogaChatScreen> {
  final TextEditingController messagecontroller = TextEditingController();
  final ScrollController scrollController = ScrollController();

  final Stream<QuerySnapshot> messagesStream = FirebaseFirestore.instance
      .collection(MogaCollection)
      .orderBy(kCreatedAt)
      .snapshots();

  void dispose() {
    scrollController.dispose();

    messagecontroller.dispose();

    super.dispose();
  }

  @override
  void initState() {
    ChatCubit.get(context).GetUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference messeges =
        FirebaseFirestore.instance.collection(MogaCollection);

    return BlocConsumer<ChatCubit, ChatStates>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is GetUserSuccessState) {
          return StreamBuilder<QuerySnapshot>(
            stream: messagesStream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              } else if (snapshot.hasData) {
                List<MessagesModel> messageslist = [];
                for (int i = 0; i < snapshot.data!.docs.length; i++) {
                  messageslist
                      .add(MessagesModel.fromJason(snapshot.data!.docs[i]));
                }

                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (messageslist.isNotEmpty) {
                    scrollController.animateTo(
                      scrollController.position.maxScrollExtent,
                      duration: Duration(milliseconds: 100),
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
                            "Moga",
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
                            child: ListView.builder(
                                controller: scrollController,
                                itemCount: messageslist.length,
                                shrinkWrap: false,
                                itemBuilder: (context, index) {
                                  return messageslist[index].id ==
                                          ChatCubit.get(context).model!.uId
                                      ? ChatBubble(
                                          message:
                                              messageslist[index].message ?? "",
                                          userName:
                                              messageslist[index].userName ??
                                                  "",
                                        )
                                      : ChatBubbleFriend(
                                          message:
                                              messageslist[index].message ?? "",
                                          userName:
                                              messageslist[index].userName ??
                                                  "",
                                          userBubbleColor: userBubbleColor(
                                              messageslist[index].userColor ??
                                                  0),
                                        );
                                }),
                          ),
                          Container(
                            height: 70,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 8),
                              child: TextField(
                                onSubmitted: (message) {
                                  messeges.add({'message': message});
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
                                          messeges.add({
                                            'message': messagecontroller.text,
                                            'createdAt': DateTime.now(),
                                            'id': ChatCubit.get(context)
                                                .model!
                                                .uId,
                                            'userName': ChatCubit.get(context)
                                                    .model!
                                                    .name ??
                                                "",
                                            'userColor': ChatCubit.get(context)
                                                .model!
                                                .userBubbleColorId
                                          });
                                          messagecontroller.clear();

                                          scrollController.jumpTo(
                                              scrollController
                                                  .position.maxScrollExtent);
                                          scrollController.animateTo(
                                            scrollController
                                                .position.maxScrollExtent,
                                            duration: const Duration(
                                                milliseconds: 100),
                                            curve: Curves.easeIn,
                                          );
                                        },
                                        icon: const Icon(Icons.send,
                                            color: Colors.blueGrey)),
                                    hintText: "Send a message",
                                    hintStyle:
                                        const TextStyle(color: Colors.blueGrey),
                                    focusedBorder: const OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.blueGrey),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(18),
                                        )),
                                    enabledBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(18),
                                        ),
                                        borderSide:
                                            BorderSide(color: Colors.blueGrey)),
                                    border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(18),
                                        ),
                                        borderSide:
                                            BorderSide(color: Colors.white))),
                              ),
                            ),
                          )
                        ],
                      ),
                    ));
              }

              return const Scaffold(
                  body: Center(
                      child: CircularProgressIndicator(
                color: KprimaryColor,
              )));
            },
          );
        } else {
          return Scaffold(
              body: Center(
                  child: CircularProgressIndicator(
            color: KprimaryColor,
          )));
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
