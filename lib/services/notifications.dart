import 'package:flutter_local_notifications/flutter_local_notifications.dart';


   Future<void> showNotification({required FlutterLocalNotificationsPlugin notificationsPlugin ,required String title, required String body}) async {
    // Configure the initialization settings for the plugin
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    // Initialize the plugin
    await notificationsPlugin.initialize(initializationSettings);

    // Configure the notification details
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your_channel_id', // Change this for your app
      'your_channel_name', // Change this for your app
      // 'your_channel_description', // Change this for your app
      importance: Importance.max,
      priority: Priority.high,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    // Display the notification
    await notificationsPlugin.show(
      0, // Unique ID for the notification
      title, // Title of the notification
      body, // Body of the notification
      platformChannelSpecifics,
    );
  }

