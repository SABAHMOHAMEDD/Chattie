import 'package:chat_tharwat/core/constance/constants.dart';
import 'package:chat_tharwat/features/chat/pages/chat_screen.dart';
import 'package:chat_tharwat/features/login/pages/login_screen.dart';
import 'package:chat_tharwat/features/register/cubit/register_cubit.dart';
import 'package:chat_tharwat/features/register/pages/register_screen.dart';
import 'package:chat_tharwat/features/splash/pages/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/cache_helper.dart';
import 'core/notification_helper.dart';
import 'features/chat/cubit/chat_cubit.dart';
import 'features/chats_grid/pages/chat_grid_screen.dart';
import 'features/login/cubit/login_cubit.dart';
import 'firebase_options.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Firebase.initializeApp();
  NotificationHelper().showNotificationHeadUp(message);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await CacheHelper.init();
  final String? uId = CacheHelper.getData(key: 'uId');
  print(uId);

  runApp(const MyApp());
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom]);
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  NotificationHelper notiHelper = NotificationHelper();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // request permisiion //getToken
    notiHelper.requestPermissionAndGetToken();

    // create local notification settings and info
    notiHelper.configLocalNotification();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (context) => RegisterCubit()),
        BlocProvider(create: (context) => ChatCubit()..GetUserData()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          LoginScreen.routeName: (context) => LoginScreen(),
          RegisterScreen.routeName: (context) => RegisterScreen(),
          ChatScreen.routeName: (context) => ChatScreen(),
          SplashScreen.routeName: (context) => SplashScreen(),
          ChatGridScreen.routeName: (context) => ChatGridScreen(),
        },
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: KprimaryColor),
          useMaterial3: true,
        ),
        initialRoute: LoginScreen.routeName,
      ),
    );
  }
}
