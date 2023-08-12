import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.blueGrey,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(28),
                bottomRight: Radius.circular(28),
                topLeft: Radius.circular(28))),
        margin: const EdgeInsets.only(top: 15, left: 15, right: 10),
        child: const Padding(
          padding: EdgeInsets.symmetric(vertical: 15),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'hello its mefsfad ',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
