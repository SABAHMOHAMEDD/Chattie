import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  String? hintText;
  bool obscureText = false;
  Color? hintTextColor;
  Function(String)? onchanged;
  String? validatemsg;
  String? Function(String?)? validator;

  CustomTextFormField(
      {this.hintText,
      this.hintTextColor,
      this.onchanged,
      this.validator,
      this.obscureText = false,
      this.validatemsg});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: TextFormField(
        obscureText: obscureText,
        validator: validator,
        onChanged: onchanged,
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
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
                borderSide: BorderSide(color: Colors.white))),
      ),
    );
  }
}
