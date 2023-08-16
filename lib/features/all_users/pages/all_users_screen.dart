import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/all_users_cubit.dart';
import '../cubit/all_users_states.dart';

class AllUsersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AllUsersCubit, AllUsersCubitStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        if (state is GetAllUsersSuccessState) {
          return Scaffold(
              body: ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemCount: AllUsersCubit.get(context).users.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {},
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
                              AllUsersCubit.get(context)
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
                                  AllUsersCubit.get(context)
                                          .users[index]
                                          .name ??
                                      "",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      color: Colors.black.withOpacity(0.8)),
                                ),
                              ),
                              const SizedBox(
                                height: 3,
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
                    border: Border.all(width: 1, color: Colors.grey.shade200)),
              );
            },
          ));
        } else {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }
}
