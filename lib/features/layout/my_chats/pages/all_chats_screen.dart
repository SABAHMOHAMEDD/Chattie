import 'package:chat_tharwat/core/cache_helper.dart';
import 'package:chat_tharwat/core/constance/constants.dart';
import 'package:chat_tharwat/features/home/cubit/home_cubit.dart';
import 'package:chat_tharwat/features/home/cubit/home_states.dart';
import 'package:chat_tharwat/features/layout/my_chats/pages/private_chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../cubit/private_chats_cubit.dart';

class MyChatsScreen extends StatelessWidget {
  const MyChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        HomeCubit.get(context).GetAllUsers();

        return BlocConsumer<HomeCubit, HomeStates>(
          listener: (BuildContext context, state) {},
          builder: (BuildContext context, state) {
            if (state is GetAllUsersSuccessState) {
              return Scaffold(
                  body: ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemCount: HomeCubit.get(context).users.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      BlocProvider.of<PrivateChatsCubit>(context).GetMessages(
                          receiverId: HomeCubit.get(context).users[index].uId);

                      Navigator.pushNamed(context, PrivateChatScreen.routeName,
                          arguments: HomeCubit.get(context).users[index]);
                      print(
                          'oooooooooooooooooooooooooooooooooooooooooooooooooo');
                      CacheHelper.saveData(
                          key: 'userId',
                          value: HomeCubit.get(context).users[index].uId);

                      print(CacheHelper.getData(key: 'userId'));
                      print(
                          'oooooooooooooooooooooooooooooooooooooooooooooooooo');
                    },
                    child: Container(
                      height: 100,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 15),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 28,
                              backgroundImage: NetworkImage(
                                  HomeCubit.get(context)
                                          .users[index]
                                          .userImage ??
                                      ""),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              flex: 6,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text(
                                      HomeCubit.get(context)
                                              .users[index]
                                              .name ??
                                          "",
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 1, color: KSecondryColor.withOpacity(0.5))),
                  );
                },
              ));
            } else {
              return Scaffold(
                body: Center(
                    child: LoadingAnimationWidget.inkDrop(
                  color: KPrimaryColor,
                  size: 35,
                )),
              );
            }
          },
        );
      },
    );
  }
}
