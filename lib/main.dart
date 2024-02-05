import 'dart:developer';
import 'dart:io';

import 'package:floodsystem/providers/riverprovider.dart';
import 'package:floodsystem/screens/home.dart';
import 'package:floodsystem/screens/mobile/details.dart';
import 'package:floodsystem/screens/mobile/graphscreen.dart';
import 'package:floodsystem/screens/mobile/mobilesettings.dart';
import 'package:floodsystem/screens/mobile/tablescreen.dart';
import 'package:floodsystem/services/backgroundservice.dart';
import 'package:floodsystem/themes/darkthemes.dart';
import 'package:floodsystem/themes/lighttheme.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import 'const.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
    
     if (Platform.isAndroid) {
  try {
     await Permission.notification.isDenied.then((value){
      if(value){
   Permission.notification.request();
      }
  
    },);
    await initializeService();
  } on Exception catch (e) {
      log(e.toString());
    // TODO
  }
}

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return 
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => NambulProvider() ),
      // ChangeNotifierProvider(create: (context) => ImphalRiverProvider() ),
      // ChangeNotifierProvider(create: (context) => IrilRiverProvider() ),
    ],
    builder: (context,c)=>
    MaterialApp(
      title: appname,
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: normalColor),
      //   useMaterial3: true,
      // ),
    
      darkTheme: darktheme,
      theme: lighttheme,
      themeMode: ThemeMode.system,
      home: const HomePage(),
      routes: {
        HomePage.routename:(c)=>const HomePage(),
        DetailsScreen.routename:(c)=>const DetailsScreen(),
        MobileSettings.routename:(c)=>const MobileSettings(),
        TableScreen.routename:(c)=>const TableScreen(),
        GraphScreen.routename:(c)=>const GraphScreen(),
      }
  ,
    ),);
  }
}
