import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final String userName;

  ChatBubble({required this.message, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.blueGrey.shade400,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(14),
                bottomLeft: Radius.circular(14),
                topLeft: Radius.circular(14))),
        margin: const EdgeInsets.only(top: 15, left: 10, right: 15),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                // Text(
                //   userName!,
                //   style: TextStyle(color: Colors.orangeAccent),
                // ),
                Text(
                  message!,
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ChatBubbleFriend extends StatelessWidget {
  final String message;
  final String userName;
  final Color userBubbleColor;

  ChatBubbleFriend(
      {required this.message,
      required this.userName,
      required this.userBubbleColor});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        decoration: BoxDecoration(
            color: userBubbleColor,
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(14),
                bottomRight: Radius.circular(14),
                topLeft: Radius.circular(14))),
        margin: const EdgeInsets.only(top: 15, left: 15, right: 10),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "~$userName",
                  style: const TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  message,
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
