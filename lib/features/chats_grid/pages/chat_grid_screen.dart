import 'package:chat_tharwat/core/constance/constants.dart';
import 'package:chat_tharwat/features/chat/pages/emax_chat_screen.dart';
import 'package:flutter/material.dart';

import '../../chat/pages/moga_chat_screen.dart';

class ChatGridScreen extends StatelessWidget {
  static const routeName = "ChatGridScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: Container(
      //   padding: EdgeInsets.only(left: 40, bottom: 10, top: 10, right: 40),
      //   height: 60,
      //   decoration: BoxDecoration(color: Colors.white, boxShadow: [
      //     BoxShadow(
      //         offset: Offset(10, -10),
      //         blurRadius: 35,
      //         color: Colors.white.withOpacity(.2))
      //   ]),
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     children: [
      //       IconButton(
      //         onPressed: () {},
      //         icon: Icon(Icons.home,color: KprimaryColor,),
      //       ), IconButton(
      //         onPressed: () {},
      //         icon: Icon(Icons.message,color: KprimaryColor,),
      //       ),
      //       IconButton(
      //         onPressed: () {},
      //         icon: Icon(Icons.group,color: KprimaryColor,),
      //       ),
      //       IconButton(
      //         onPressed: () {},
      //         icon: Icon(Icons.settings,color: KprimaryColor,),
      //       )
      //     ],
      //   ),
      // ),

      backgroundColor: KprimaryColor,
      body: Container(
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
                          color: Colors.white,
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
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Emax Chat',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                      color: Colors.black54),
                                ),
                                Container(
                                  width: 15,
                                  height: 15,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade50,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: const Icon(
                                    Icons.chat,
                                    color: KprimaryColor,
                                  ),
                                ),
                              ],
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
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12)),
                      child: Column(
                        //  crossAxisAlignment: CrossAxisAlignment.center,
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
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Moga Chat',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                      color: Colors.black54),
                                ),
                                Container(
                                  width: 15,
                                  height: 15,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade50,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: const Icon(
                                    Icons.chat,
                                    color: KprimaryColor,
                                  ),
                                ),
                              ],
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
            IconButton(
              onPressed: () {
                SignOut(context);
              },
              icon: Icon(
                Icons.exit_to_app,
                size: 45,
                color: Colors.white.withOpacity(0.9),
              ),
            ),
            Text(
              'Sign Out',
              style: TextStyle(color: Colors.white.withOpacity(.9)),
            ),
            SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }
}
