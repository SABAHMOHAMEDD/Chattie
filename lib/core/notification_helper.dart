import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationHelper {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  String? deviceToken;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  requestPermissionAndGetToken() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }

    print('User granted permission: ${settings.authorizationStatus}');

    // get device token
    messaging.getToken().then((dToken) {
      deviceToken = dToken;
      print(r"$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$");

      print("device token is${deviceToken}");
      print(r"$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$");
    });

    ///
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {}
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      showNotificationHeadUp(message);

      return;
    });
  }

  showNotificationHeadUp(RemoteMessage message) async {
    BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
        message.notification!.body.toString(),
        htmlFormatBigText: true,
        contentTitle: message.notification!.title.toString(),
        htmlFormatContentTitle: true);

    AndroidNotificationDetails androidPlateformChannelSpecifics =
        AndroidNotificationDetails(
      "try_firbs",
      "try_firbs_channel",
      importance: Importance.max,
      styleInformation: bigTextStyleInformation,
      priority: Priority.high,
      playSound: true,
    );
    if (Platform.isAndroid) {
      const AndroidNotificationChannel channel = AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        importance: Importance.max,
      );
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);
    }
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    NotificationDetails plateformChannelSpecifics = NotificationDetails(
        android: androidPlateformChannelSpecifics,
        iOS: const DarwinNotificationDetails());

    //  خلصنا تعريفات، بنظهرها بقي في  ك هيد اب
    await flutterLocalNotificationsPlugin.show(0, message.data["text"],
        message.data["title"], plateformChannelSpecifics,
        payload: null);
  }

  /////////////////////////////////  local Notification configration

  configLocalNotification({Widget? myScreen}) async {
    const AndroidInitializationSettings androidInitialze =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings iosInitialize =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: androidInitialze,
      iOS: iosInitialize,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      // /// to navigate in foreground mode.....
      //     onDidReceiveNotificationResponse:
      //         (NotificationResponse notificationResponse) async {
      //   final String? payload = notificationResponse.payload;
      //   if (notificationResponse.payload != null) {
      //     debugPrint('notification payload: $payload');
      //   }
      //   await Navigator.push(
      //     navigatorKey.currentState!.context,
      //     MaterialPageRoute<void>(builder: (context) => myScreen),
      //   );
      // }
    );

    /////////////// foreground local
    // FirebaseMessaging.onMessage.listen(showNotificationHeadUp);
  }
}
