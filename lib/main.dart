import 'package:chat_tharwat/core/constance/constants.dart';
import 'package:chat_tharwat/features/login/pages/login_screen.dart';
import 'package:chat_tharwat/features/register/cubit/register_cubit.dart';
import 'package:chat_tharwat/features/register/pages/register_screen.dart';
import 'package:chat_tharwat/features/splash/pages/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'DailyStepsScreen.dart';
import 'core/bloc_observer.dart';
import 'core/cache_helper.dart';
import 'core/check_internet_connection/cubit/internet_cubit.dart';
import 'core/notification_helper.dart';
import 'features/home/cubit/home_cubit.dart';
import 'features/home/pages/home_screen.dart';
import 'features/layout/group_chat/cubit/group_chat_cubit.dart';
import 'features/layout/group_chat/pages/grid_group_chat_screen.dart';
import 'features/layout/group_chat/pages/group_chat_screen.dart';
import 'features/layout/my_chats/cubit/private_chats_cubit.dart';
import 'features/layout/my_chats/pages/private_chat_screen.dart';
import 'features/layout/profile/pages/profile_screen.dart';
import 'features/login/cubit/login_cubit.dart';
import 'firebase_options.dart';

void main() async {
  Bloc.observer = MyBlocObserver();

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  var token = await FirebaseMessaging.instance.getToken();
  print("ttttttttttttttttttttttttttttt");

  print(token.toString());
  print("ttttttttttttttttttttttttttttt");

  FirebaseMessaging.onMessage.listen((event) {
    print('kkkkkkkkkkkkkkkkkkkkkkkk');
    print(event.data.toString());
    print('kkkkkkkkkkkkkkkkkkkkkkkk');
  });

  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print('*******************************');
    print(event.data.toString());
    print('*******************************');
  });

  await CacheHelper.init();

  final String? uId = CacheHelper.getData(key: 'uId');

  Widget widget;
  if (uId != null) {
    widget = HomeScreen();
  } else {
    widget = SplashScreen();
  }

  // print("AAAAAAAAAAAAAAAAAAAAAAAAAA");
  // print(uId);
  // print("AAAAAAAAAAAAAAAAAAAAAAAAAA");

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

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (context) => HomeCubit()..GetUserData()),
        BlocProvider(create: (context) => RegisterCubit()),
        BlocProvider(create: (context) => PrivateChatsCubit()),
        BlocProvider(create: (context) => GroupChatCubit()),
        BlocProvider(create: (context) => InternetCubit()..checkConnection()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          LoginScreen.routeName: (context) => LoginScreen(),
          RegisterScreen.routeName: (context) => RegisterScreen(),
          EmaxChatScreen.routeName: (context) => EmaxChatScreen(),
          SplashScreen.routeName: (context) => SplashScreen(),
          HomeScreen.routeName: (context) => HomeScreen(),
          ProfileScreen.routeName: (context) => ProfileScreen(),
          GroupChatScreen.routeName: (context) => GroupChatScreen(),
          PrivateChatScreen.routeName: (context) => PrivateChatScreen(),
        },
        theme: ThemeData(
          scaffoldBackgroundColor: KScaffoldColor,
          colorScheme: ColorScheme.fromSeed(seedColor: KPrimaryColor),
          useMaterial3: true,
        ),
        // initialRoute: SplashScreen.routeName,
        home: DailyStepsScreen(),
      ),
    );
  }
}
