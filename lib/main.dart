import 'package:floodsystem/providers/imphalriverprovider.dart';
import 'package:floodsystem/providers/irilprovider.dart';
import 'package:floodsystem/providers/riverprovider.dart';
import 'package:floodsystem/screens/home.dart';
import 'package:floodsystem/screens/mobile/details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'const.dart';

void main() {
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
      ChangeNotifierProvider(create: (context) => ImphalRiverProvider() ),
      ChangeNotifierProvider(create: (context) => IrilRiverProvider() ),
    ],
    builder: (context,c)=>
    MaterialApp(
      title: appname,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: normalColor),
        useMaterial3: true,
      ),
      home: const HomePage(),
      routes: {
        HomePage.routename:(c)=>HomePage(),
        DetailsScreen.routename:(c)=>DetailsScreen(),
      }
  ,
    ),);
  }
}
