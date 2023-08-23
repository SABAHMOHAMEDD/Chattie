import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../../core/constance/constants.dart';
import '../cubit/group_chat_cubit.dart';
import 'emax_chat_screen.dart';

class GroupChatScreen extends StatelessWidget {
  static const routeName = "GroupChatScreen";

  List<String> CollectionName = ['Emax', 'Mojah', 'Flayerhost', 'NDS'];
  List<String> imagePath = [
    'assets/images/chatting.png',
    'assets/images/hiring.png',
    'assets/images/chattingg.png',
    'assets/images/socialmedia.png'
  ];
  List<String> GridTitle = ['Emax', 'Mojah', 'Flayerhost', 'NDS'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 150),
          child: MasonryGridView.builder(
            itemCount: 4,
            mainAxisSpacing: 7,
            crossAxisSpacing: 7,
            itemBuilder: (context, index) {
              return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                  child: InkWell(
                    onTap: () {
                      BlocProvider.of<GroupChatCubit>(context)
                          .getGroupMessages(CollectionName[index]);
                      Navigator.pushNamed(context, EmaxChatScreen.routeName,
                          arguments: CollectionName[index]);
                    },
                    child: Container(
                      height: 170,
                      width: 170,
                      decoration: BoxDecoration(
                          color: KPrimaryColor,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                                color: KPrimaryColor.withOpacity(0.4),
                                blurRadius: 2,
                                offset: const Offset(5, 10))
                          ]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(
                            image: AssetImage(imagePath[index]),
                            height: 85,
                            width: 85,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Text(
                              GridTitle[index],
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                  color: Colors.white.withOpacity(1)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ));
            },
            gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
          ),
        ),
      ),
    );
  }
}
