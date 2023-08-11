import 'package:chat_tharwat/pages/login_screen.dart';
import 'package:flutter/material.dart';

import '../core/widgets/custom_button.dart';
import '../core/widgets/custom_text_field.dart';

class RegisterScreen extends StatelessWidget {
  static const routeName = "RegisterScreen";

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: Colors.blueGrey,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: screenSize.height / 6,
                ),
                const Image(image: AssetImage("assets/images/scholar.png")),
                const Text(
                  "Scholar Chat",
                  style: TextStyle(
                      fontFamily: "Schyler", color: Colors.white, fontSize: 24),
                ),
                SizedBox(
                  height: screenSize.height / 12,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Register',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  hintText: "Email",
                  hintTextColor: Colors.white,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                    hintText: "Password", hintTextColor: Colors.white),
                SizedBox(
                  height: screenSize.height / 35,
                ),
                CustomButton(
                  buttonText: 'Register',
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account?",
                        style: TextStyle(color: Colors.white)),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context, LoginScreen.routeName);
                      },
                      child: Text(
                        ' Login',
                        style: TextStyle(color: Colors.blueGrey.shade100),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
