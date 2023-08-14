import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:chat_tharwat/features/login/pages/login_screen.dart';
import 'package:flutter/material.dart';

import '../../../core/constance/constants.dart';

class SplashScreen extends StatelessWidget {
  static const routeName = "SplashScreen";

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splashIconSize: 200,
      backgroundColor: KprimaryColor,
      splash: Column(
        children: [
          Image(image: AssetImage(KLogo)),
          const Text(
            "Scholar Chat",
            style: TextStyle(
                fontFamily: "Schyler", color: Colors.white, fontSize: 24),
          ),
        ],
      ),
      nextScreen: LoginScreen(),
      splashTransition: SplashTransition.sizeTransition,

      //pageTransitionType: PageTransitionType.downToUp,
    );
  }
}
