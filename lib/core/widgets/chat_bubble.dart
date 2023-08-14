import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;

  ChatBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.blueGrey.shade400,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(16),
                bottomLeft: Radius.circular(16),
                topLeft: Radius.circular(16))),
        margin: const EdgeInsets.only(top: 15, left: 15, right: 10),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              message!,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}

class ChatBubbleFriend extends StatelessWidget {
  final String message;

  ChatBubbleFriend({required this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.red.shade300,
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(16),
                bottomRight: Radius.circular(16),
                topLeft: Radius.circular(16))),
        margin: const EdgeInsets.only(top: 15, left: 15, right: 10),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              message!,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
