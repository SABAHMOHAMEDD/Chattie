import 'package:chat_tharwat/features/home/cubit/home_cubit.dart';
import 'package:chat_tharwat/features/home/cubit/home_states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/cache_helper.dart';
import '../../../../core/constance/constants.dart';
import '../../../../core/icon_broken.dart';
import '../../../register/models/user_model.dart';

class ProfileScreen extends StatelessWidget {
  static const routeName = "ProfileScreen";

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},

      builder: (context, state) {
        var profileImage = HomeCubit.get(context).profileimage;
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
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: 25,
                  ),
                ),
              ),
              backgroundColor: KSecondryColor,
              actions: [
                IconButton(
                    onPressed: () {
                      HomeCubit.get(context).UpdateUserImages();
                    },
                    icon: Icon(
                      IconBroken.Edit,
                      color: KPrimaryColor,
                      size: 25,
                    ))
              ],
            ),
            body: Container(
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
                      height: 70,
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
                                  return SizedBox(); // Empty container when userModel.userImage is null
                                }
                              },
                              fallback: (context) {
                                if (profileImage != null) {
                                  return CircleAvatar(
                                    radius: 76,
                                    backgroundImage: FileImage(profileImage!),
                                  );
                                } else {
                                  return SizedBox(); // Empty container when profileImage is null
                                }
                              },
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              HomeCubit.get(context).getProfileImageByGallery();
                            },
                            icon: Padding(
                              padding: EdgeInsets.all(1.0),
                              child: CircleAvatar(
                                backgroundColor: KPrimaryColor.withOpacity(.6),
                                radius: 15,
                                child: Icon(
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
                      style: TextStyle(color: KPrimaryColor, fontSize: 20),
                    ),
                    SizedBox(
                      height: 350,
                    ),
                    IconButton(
                      onPressed: () {
                        HomeCubit.get(context).clearProfileImageCache();
                        SignOut(context);
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
                    const SizedBox(
                      height: 100,
                    )
                    // Remaining code...
                  ],
                ),
              ),
            ),
          );
        } else {
          return Scaffold(body: SizedBox());
        }
      },
      // builder: (context, state) {
      //   var profileImage = HomeCubit.get(context).profileimage;
      //   var userModel = ModalRoute.of(context)!.settings.arguments as UserModel;
      //
      //   if (HomeCubit.get(context).model != null) {
      //     return Scaffold(
      //       appBar: AppBar(
      //         actions: [
      //           IconButton(
      //               onPressed: () {
      //                 HomeCubit.get(context).UpdateUserImages();
      //               },
      //               icon: Icon(IconBroken.Edit))
      //         ],
      //       ),
      //       backgroundColor: Colors.white,
      //       body: Container(
      //         width: double.infinity,
      //         child: SingleChildScrollView(
      //           child: Column(
      //             mainAxisAlignment: MainAxisAlignment.center,
      //             crossAxisAlignment: CrossAxisAlignment.center,
      //             children: [
      //               if (state is UpdateUserImageLoadingState)
      //                 LinearProgressIndicator(
      //                   color: KPrimaryColor.withOpacity(0.5),
      //                 ),
      //               Padding(
      //                 padding: const EdgeInsets.all(10.0),
      //                 child: Stack(
      //                   alignment: AlignmentDirectional.bottomEnd,
      //                   children: [
      //                     SizedBox(
      //                       height: 100,
      //                     ),
      //                     CircleAvatar(
      //                         radius: 80,
      //                         backgroundColor: KPrimaryColor.withOpacity(.6),
      //                         child: ConditionalBuilder(
      //                           condition: profileImage == null,
      //                           builder: (context) {
      //                             print(
      //                                 'mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm');
      //                             print(userModel.userImage!);
      //                             print(
      //                                 'mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm');
      //
      //                             return CircleAvatar(
      //                                 radius: 76,
      //                                 backgroundImage:
      //                                     NetworkImage(userModel.userImage!));
      //                           },
      //                           fallback: (context) {
      //                             print(
      //                                 'mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm');
      //                             print(profileImage!);
      //                             print(
      //                                 'mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm');
      //                             return CircleAvatar(
      //                                 radius: 76,
      //                                 backgroundImage:
      //                                     FileImage(profileImage!));
      //                           },
      //                         )),
      //                     IconButton(
      //                       onPressed: () {
      //                         HomeCubit.get(context).getProfileImageByGallery();
      //                       },
      //                       icon: Padding(
      //                         padding: EdgeInsets.all(1.0),
      //                         child: CircleAvatar(
      //                             backgroundColor: Colors.grey.withOpacity(0.5),
      //                             radius: 15,
      //                             child: Icon(
      //                               IconBroken.Camera,
      //                               color: Colors.white,
      //                             )),
      //                       ),
      //                     )
      //                   ],
      //                 ),
      //               ),
      //               SizedBox(
      //                 height: 10,
      //               ),
      //               Text(
      //                 CacheHelper.getData(key: 'name'),
      //                 style: TextStyle(color: KPrimaryColor, fontSize: 20),
      //               ),
      //               SizedBox(
      //                 height: 350,
      //               ),
      //               IconButton(
      //                 onPressed: () {
      //                   HomeCubit.get(context).clearProfileImageCache();
      //                   SignOut(context);
      //                 },
      //                 icon: Icon(
      //                   Icons.exit_to_app,
      //                   size: 45,
      //                   color: KPrimaryColor.withOpacity(0.8),
      //                 ),
      //               ),
      //               Text(
      //                 'Sign Out',
      //                 style: TextStyle(color: KPrimaryColor.withOpacity(.8)),
      //               ),
      //               const SizedBox(
      //                 height: 100,
      //               )
      //             ],
      //           ),
      //         ),
      //       ),
      //     );
      //   } else {
      //     return Scaffold(body: SizedBox());
      //   }
      // },
    );
  }
}
