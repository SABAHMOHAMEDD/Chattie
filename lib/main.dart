import 'package:chat_tharwat/core/constance/constants.dart';
import 'package:chat_tharwat/features/chat/pages/emax_chat_screen.dart';
import 'package:chat_tharwat/features/login/pages/login_screen.dart';
import 'package:chat_tharwat/features/register/cubit/register_cubit.dart';
import 'package:chat_tharwat/features/register/pages/register_screen.dart';
import 'package:chat_tharwat/features/splash/pages/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/bloc_observer.dart';
import 'core/cache_helper.dart';
import 'core/notification_helper.dart';
import 'features/all_users/cubit/all_users_cubit.dart';
import 'features/all_users/pages/all_users_screen.dart';
import 'features/chat/cubit/chat_cubit.dart';
import 'features/chat/pages/moga_chat_screen.dart';
import 'features/chats_grid/pages/chat_grid_screen.dart';
import 'features/login/cubit/login_cubit.dart';
import 'features/settings/pages/settings_screen.dart';
import 'firebase_options.dart';

// @pragma('vm:entry-point')
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   await Firebase.initializeApp();
//   NotificationHelper().showNotificationHeadUp(message);
// }

void main() async {
  Bloc.observer = MyBlocObserver();

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await CacheHelper.init();
  //CacheHelper.removeData(key: 'uId');

  final String? uId = CacheHelper.getData(key: 'uId');

  Widget widget;
  if (uId != null) {
    widget = ChatGridScreen();
  } else {
    widget = LoginScreen();
  }

  print("AAAAAAAAAAAAAAAAAAAAAAAAAA");
  print(uId);
  print("AAAAAAAAAAAAAAAAAAAAAAAAAA");

  runApp(MyApp(widget));
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom]);
}

class MyApp extends StatefulWidget {
  Widget startWidget;

  MyApp(this.startWidget);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  NotificationHelper notiHelper = NotificationHelper();

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   // request permisiion //getToken
  //   notiHelper.requestPermissionAndGetToken();
  //
  //   // create local notification settings and info
  //   notiHelper.configLocalNotification();
  // }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (context) => RegisterCubit()),
        BlocProvider(create: (context) => ChatCubit()..GetUserData()),
        BlocProvider(create: (context) => AllUsersCubit()..GetAllUsers()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          LoginScreen.routeName: (context) => LoginScreen(),
          RegisterScreen.routeName: (context) => RegisterScreen(),
          EmaxChatScreen.routeName: (context) => EmaxChatScreen(),
          SplashScreen.routeName: (context) => SplashScreen(),
          ChatGridScreen.routeName: (context) => ChatGridScreen(),
          MogaChatScreen.routeName: (context) => MogaChatScreen(),
          SettingsScreen.routeName: (context) => SettingsScreen(),
        },
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: KprimaryColor),
          useMaterial3: true,
        ),
        // initialRoute: SplashScreen.routeName,
        //home: widget.startWidget,
        home: AllUsersScreen(),
      ),
    );
  }
}
