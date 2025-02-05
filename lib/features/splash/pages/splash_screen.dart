import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:chat_tharwat/features/login/pages/login_screen.dart';
import 'package:flutter/material.dart';

import '../../../core/constance/constants.dart';

class SplashScreen extends StatelessWidget {
  static const routeName = "SplashScreen";

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splashIconSize: 150,
      backgroundColor: KPrimaryColor.withOpacity(0.9),
      splash: const Column(
        children: [
          Image(
            image: AssetImage(KLogo),
            height: 100,
            width: 100,
          ),
          Text(
            "Chattie",
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
