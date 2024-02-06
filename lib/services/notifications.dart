import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:typed_data';
import 'dart:ui';

   Future<void> showNotification({required FlutterLocalNotificationsPlugin notificationsPlugin ,required String title, required String body}) async {
    // Configure the initialization settings for the plugin
    int insistentFlag = 4;
    notificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!
        .requestNotificationsPermission();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    // Initialize the plugin
    await notificationsPlugin.initialize(initializationSettings);

    // Configure the notification details
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      '1', // Change this for your app
      'ChannelName', // Change this for your app
      // 'your_channel_description', // Change this for your app
           importance: Importance.max,
            priority: Priority.high,
            playSound: true,
            enableVibration: true,
             ongoing: true,
            autoCancel: true,
           additionalFlags: Int32List.fromList(<int>[insistentFlag]),
      sound: const RawResourceAndroidNotificationSound('alarm2')
    );
     NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    // Display the notification
    await notificationsPlugin.show(
      1, // Unique ID for the notification
      title, // Title of the notification
      body, // Body of the notification
      platformChannelSpecifics,

    );
  }

