import 'package:chat_tharwat/features/home/cubit/home_cubit.dart';
import 'package:chat_tharwat/features/home/cubit/home_states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/cache_helper.dart';
import '../../../../core/constance/constants.dart';
import '../../../../core/icon_broken.dart';
import '../../register/models/user_model.dart';

class ProfileScreen extends StatelessWidget {
  static const routeName = "ProfileScreen";

  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var profileImage = HomeCubit.get(context).profileImage;
        var userModel = ModalRoute.of(context)!.settings.arguments as UserModel;

        if (HomeCubit.get(context).model != null) {
          return Scaffold(
            appBar: AppBar(
              leading: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: IconButton(
                  color: KPrimaryColor,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    size: 25,
                  ),
                ),
              ),
              backgroundColor: KSecondryColor,
              actions: [
                IconButton(
                    onPressed: () {
                      HomeCubit.get(context).updateUserImages();
                    },
                    icon: const Icon(
                      IconBroken.Edit,
                      color: KPrimaryColor,
                      size: 25,
                    ))
              ],
            ),
            body: SizedBox(
              width: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (state is UpdateUserImageLoadingState)
                      LinearProgressIndicator(
                        color: KPrimaryColor.withOpacity(0.5),
                      ),
                    SizedBox(
                      height: screenSize.height / 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          CircleAvatar(
                            radius: 80,
                            backgroundColor: KPrimaryColor.withOpacity(.6),
                            child: ConditionalBuilder(
                              condition: profileImage == null,
                              builder: (context) {
                                if (userModel.userImage != null) {
                                  return CircleAvatar(
                                    radius: 76,
                                    backgroundImage:
                                        NetworkImage(userModel.userImage!),
                                  );
                                } else {
                                  return const SizedBox(); // Empty container when userModel.userImage is null
                                }
                              },
                              fallback: (context) {
                                if (profileImage != null) {
                                  return CircleAvatar(
                                    radius: 76,
                                    backgroundImage: FileImage(profileImage),
                                  );
                                } else {
                                  return const SizedBox(); // Empty container when profileImage is null
                                }
                              },
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              HomeCubit.get(context).getProfileImageByGallery();
                            },
                            icon: Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: CircleAvatar(
                                backgroundColor: KPrimaryColor.withOpacity(.6),
                                radius: 15,
                                child: const Icon(
                                  IconBroken.Camera,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Text(
                      CacheHelper.getData(key: 'name'),
                      style: const TextStyle(color: KPrimaryColor, fontSize: 20),
                    ),
                    SizedBox(
                      height: screenSize.height / 3,
                    ),
                    IconButton(
                      onPressed: () {
                        SignOut(context);
                        HomeCubit.get(context).profileImage = null;
                      },
                      icon: Icon(
                        Icons.exit_to_app,
                        size: 45,
                        color: KPrimaryColor.withOpacity(0.8),
                      ),
                    ),
                    Text(
                      'Sign Out',
                      style: TextStyle(color: KPrimaryColor.withOpacity(.8)),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return const Scaffold(body: SizedBox());
        }
      },
    );
  }
}
