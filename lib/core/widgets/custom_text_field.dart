import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  String? hintText;
  Color? hintTextColor;

  CustomTextField({this.hintText, this.hintTextColor});

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(color: Colors.white),
      cursorColor: Colors.blueGrey.shade100,
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: hintTextColor),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              )),
          enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
              borderSide: BorderSide(color: Colors.white)),
          border: InputBorder.none),
    );
  }
}
