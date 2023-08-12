import 'package:flutter/material.dart';

import '../core/constance/constance.dart';
import '../core/widgets/chat_bubble.dart';

class ChatScreen extends StatefulWidget {
  static const routeName = "HomeScreen";

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                height: 60,
                image: AssetImage(Kphoto),
                fit: BoxFit.cover,
              ),
              const Text(
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
                  shrinkWrap: false,
                  itemBuilder: (context, index) {
                    return ChatBubble();
                  }),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: TextField(
                controller: _textEditingController,
                maxLines: null,
                // Allows multiple lines
                // onEditingComplete: () {
                //   // Append a newline character when editing is complete
                //   _textEditingController.text += '\n';
                // },

                textInputAction: TextInputAction.newline,
                keyboardType: TextInputType.multiline,
                cursorColor: Colors.blueGrey,
                style: const TextStyle(color: Colors.blueGrey),
                decoration: const InputDecoration(
                    suffixIcon: Icon(
                      Icons.send,
                      color: Colors.blueGrey,
                    ),
                    hintText: "Send a message",
                    hintStyle: TextStyle(color: Colors.blueGrey),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueGrey),
                        borderRadius: BorderRadius.all(
                          Radius.circular(18),
                        )),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(18),
                        ),
                        borderSide: BorderSide(color: Colors.blueGrey)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(18),
                        ),
                        borderSide: BorderSide(color: Colors.white))),
              ),
            )
          ],
        ));
  }
}
