import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  String buttonText;

  CustomButton({required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: MaterialButton(
        onPressed: () {},
        child: Text(buttonText),
      ),
    );
  }
}
