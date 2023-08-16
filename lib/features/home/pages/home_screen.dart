import 'package:chat_tharwat/core/constance/constants.dart';
import 'package:chat_tharwat/features/home/cubit/home_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/icon_broken.dart';
import '../cubit/home_cubit.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = "HomeScreen";

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, states) {},
      builder: (context, states) {
        var cubit = HomeCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              cubit.title[cubit.currentIndex],
              style: TextStyle(color: KprimaryColor),
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: KprimaryColor,
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.ChangebottomNavBar(index);
            },
            items: [
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Chat), label: 'Chats'),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.User1), label: 'Groups'),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Setting), label: 'Settings'),
            ],
          ),
          backgroundColor: KprimaryColor,
          body: cubit.Screens[cubit.currentIndex],
        );
      },
    );
  }
}
