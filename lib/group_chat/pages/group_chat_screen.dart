import 'package:flutter/material.dart';

import '../../core/constance/constants.dart';
import '../../features/chat/pages/emax_chat_screen.dart';
import '../../features/chat/pages/moga_chat_screen.dart';

class GroupChatScreen extends StatelessWidget {
  static const routeName = "GroupChatScreen";

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 300,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      EmaxChatScreen.routeName,
                    );
                  },
                  child: Container(
                    height: 170,
                    width: 170,
                    decoration: BoxDecoration(
                        color: KprimaryColor.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.white.withOpacity(0.4),
                              blurRadius: 1,
                              offset: Offset(5, 5))
                        ]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                          image: AssetImage("assets/images/coding.png"),
                          height: 75,
                          width: 75,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Text(
                            'Emax Chat',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 15,
                                color: Colors.white.withOpacity(1)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      MogaChatScreen.routeName,
                    );
                  },
                  child: Container(
                    height: 170,
                    width: 170,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.white.withOpacity(0.4),
                              blurRadius: 1,
                              offset: Offset(5, 5))
                        ],
                        color: KprimaryColor.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                          image: AssetImage(
                            "assets/images/socialmedia.png",
                          ),
                          fit: BoxFit.cover,
                          height: 75,
                          width: 75,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Text(
                            'Moga Chat',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 15,
                                color: Colors.white.withOpacity(1)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          SizedBox(
            height: 100,
          ),
        ],
      ),
    );
  }
}
