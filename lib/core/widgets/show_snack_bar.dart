import 'package:chat_tharwat/core/constance/constants.dart';
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      elevation: 0,
      backgroundColor: KPrimaryColor.withOpacity(.7),
      duration: Duration(seconds: 1),
      content: Text(
        message,
        style: TextStyle(color: Colors.white),
      )));
}
