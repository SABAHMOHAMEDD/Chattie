import 'package:chat_tharwat/features/chat/models/messages_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../core/constance/constants.dart';
import '../../../core/widgets/chat_bubble.dart';

class ChatScreen extends StatefulWidget {
  static const routeName = "HomeScreen";

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController messagecontroller = TextEditingController();
  final ScrollController scrollController = ScrollController();

  final Stream<QuerySnapshot> messagesStream = FirebaseFirestore.instance
      .collection(KMessagesCollection)
      .orderBy(kCreatedAt)
      .snapshots();

  @override
  void dispose() {
    scrollController.dispose();

    messagecontroller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings!.arguments;

    CollectionReference messeges =
        FirebaseFirestore.instance.collection(KMessagesCollection);

    return StreamBuilder<QuerySnapshot>(
      stream: messagesStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        } else if (snapshot.hasData) {
          List<MessagesModel> messageslist = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            messageslist.add(MessagesModel.fromJason(snapshot.data!.docs[i]));
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
              appBar: AppBar(
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
                      "Chat",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        controller: scrollController,
                        itemCount: messageslist.length,
                        shrinkWrap: false,
                        itemBuilder: (context, index) {
                          return messageslist[index].id == email
                              ? ChatBubble(
                                  message: messageslist[index].message ?? "",
                                )
                              : ChatBubbleFriend(
                                  message: messageslist[index].message ?? "");
                        }),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: TextField(
                      onSubmitted: (message) {
                        messeges.add({'message': message});
                        messagecontroller.clear();
                      },
                      controller: messagecontroller,
                      maxLines: null,
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
                                  'id': email
                                });
                                messagecontroller.clear();

                                scrollController.jumpTo(
                                    scrollController.position.maxScrollExtent);
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
                              borderSide: BorderSide(color: Colors.blueGrey),
                              borderRadius: BorderRadius.all(
                                Radius.circular(18),
                              )),
                          enabledBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(18),
                              ),
                              borderSide: BorderSide(color: Colors.blueGrey)),
                          border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(18),
                              ),
                              borderSide: BorderSide(color: Colors.white))),
                    ),
                  )
                ],
              ));
        }

        return const Scaffold(
            body: Center(
                child: CircularProgressIndicator(
          color: KprimaryColor,
        )));
      },
    );
  }
}
