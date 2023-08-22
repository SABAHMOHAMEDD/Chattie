import 'package:chat_tharwat/core/constance/constants.dart';
import 'package:chat_tharwat/features/home/cubit/home_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/icon_broken.dart';
import '../../layout/profile/pages/profile_screen.dart';
import '../cubit/home_cubit.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = "HomeScreen";

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, states) {},
      builder: (context, states) {
        var cubit = HomeCubit.get(context);
        HomeCubit.get(context).GetUserData();

        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              cubit.title[cubit.currentIndex],
              style: TextStyle(color: KPrimaryColor),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, ProfileScreen.routeName,
                        arguments: HomeCubit.get(context).model);
                  },
                  icon: const Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: Icon(
                      IconBroken.Profile,
                      color: KPrimaryColor,
                      size: 28,
                    ),
                  ))
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: KPrimaryColor,
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.ChangebottomNavBar(index);
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Chat), label: 'Chats'),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.User1), label: 'Groups'),
            ],
          ),
          backgroundColor: KPrimaryColor,
          body: cubit.Screens[cubit.currentIndex],
        );
      },
    );
  }
}
