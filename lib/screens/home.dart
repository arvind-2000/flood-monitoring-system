import 'package:floodsystem/const.dart';
import 'package:floodsystem/screens/desktop.dart';
import 'package:floodsystem/screens/mobile.dart';
import 'package:floodsystem/services/services.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Service ser = Service();
  @override
  void initState() {
    
    super.initState();
 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(appname,style: TextStyle(fontSize: headersize),),
      ),
      body:LayoutBuilder(builder:(context,constraint){
        if(constraint.maxWidth<500){
          return MobileScreen();
        }
        else{
          return DesktopScreen();
        }
      }),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items:const [
        BottomNavigationBarItem(icon:Icon(Icons.home),label: 'home'),
        BottomNavigationBarItem(icon:Icon(Icons.bar_chart),label: 'graphs'),
        BottomNavigationBarItem(icon:Icon(Icons.settings),label: 'settings',),
      ]),
    );
  }
}