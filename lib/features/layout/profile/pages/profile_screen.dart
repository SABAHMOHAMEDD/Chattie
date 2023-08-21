import 'package:chat_tharwat/features/home/cubit/home_cubit.dart';
import 'package:chat_tharwat/features/home/cubit/home_states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/cache_helper.dart';
import '../../../../core/constance/constants.dart';
import '../../../../core/icon_broken.dart';

class ProfileScreen extends StatelessWidget {
  static const routeName = "SettingsScreen";

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var profileImage = HomeCubit.get(context).profileimage;

        if (HomeCubit.get(context).model != null) {
          return Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                    onPressed: () {
                      HomeCubit.get(context).UpdateUserImages();
                    },
                    icon: Icon(IconBroken.Edit))
              ],
            ),
            backgroundColor: Colors.white,
            body: Container(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (state is UpdateUserImageLoadingState)
                    LinearProgressIndicator(
                      color: KprimaryColor.withOpacity(0.5),
                    ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        CircleAvatar(
                            radius: 80,
                            backgroundColor: KprimaryColor.withOpacity(.6),
                            child: ConditionalBuilder(
                              condition: profileImage == null,
                              builder: (context) => CircleAvatar(
                                  radius: 76,
                                  backgroundImage:
                                      NetworkImage(CacheHelper.getData(
                                    key: 'userImage',
                                  ))),
                              fallback: (context) => CircleAvatar(
                                  radius: 76,
                                  backgroundImage: FileImage(profileImage!)),
                            )),
                        IconButton(
                          onPressed: () {
                            HomeCubit.get(context).getProfileImageByGallery();
                          },
                          icon: Padding(
                            padding: EdgeInsets.all(1.0),
                            child: CircleAvatar(
                                backgroundColor: Colors.grey.withOpacity(0.5),
                                radius: 15,
                                child: Icon(
                                  IconBroken.Camera,
                                  color: Colors.white,
                                )),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    CacheHelper.getData(key: 'name'),
                    style: TextStyle(color: KprimaryColor, fontSize: 20),
                  ),
                  SizedBox(
                    height: 350,
                  ),
                  IconButton(
                    onPressed: () {
                      SignOut(context);
                    },
                    icon: Icon(
                      Icons.exit_to_app,
                      size: 45,
                      color: KprimaryColor.withOpacity(0.8),
                    ),
                  ),
                  Text(
                    'Sign Out',
                    style: TextStyle(color: KprimaryColor.withOpacity(.8)),
                  ),
                  const SizedBox(
                    height: 100,
                  )
                ],
              ),
            ),
          );
        } else {
          return Scaffold(body: SizedBox());
        }
      },
    );
  }
}
