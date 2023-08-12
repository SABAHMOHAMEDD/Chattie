import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  String buttonText;
  VoidCallback? onTap;
  Color? textColor;

  CustomButton({required this.buttonText, this.onTap, this.textColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: MaterialButton(
        onPressed: onTap,
        child: Text(
          buttonText,
          style: TextStyle(color: textColor),
        ),
      ),
    );
  }
}
