import 'package:floodsystem/const.dart';
import 'package:floodsystem/models/river.dart';
import 'package:floodsystem/models/riverdetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class DetailsScreen extends StatefulWidget {
  static const String routename = 'DetailsScreen';
  const DetailsScreen({super.key,

  });

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {

   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as RiverDetails;
    var textStyle = TextStyle(fontWeight: FontWeight.bold);
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text("Info",style: TextStyle(fontSize: headersize),),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(regularpadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(args.name,style: TextStyle(fontWeight: FontWeight.bold,fontSize: headersize),),
            SizedBox(height: 20,),
            args.river.isEmpty?Text('No information',style: textStyle,):
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Water Level',style: textStyle,),
                  Text(args.river.last.usv),
                  Text('Humidity',style: textStyle,),
                  Text(args.river.last.hv),
                  Text('Temperature',style: textStyle,),
                  Text(args.river.last.tv),
                  ElevatedButton(onPressed: _showNotification, child: Text('notifications'))
                ],
              ),
            ),

          ],
          ),
          
        ),
      ),
    );
  }

   Future<void> _showNotification() async {
    // Configure the initialization settings for the plugin
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    // Initialize the plugin
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

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
    await flutterLocalNotificationsPlugin.show(
      0, // Unique ID for the notification
      'Notification Title', // Title of the notification
      'Notification Body', // Body of the notification
      platformChannelSpecifics,
    );
  }
}