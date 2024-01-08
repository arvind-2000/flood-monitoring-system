import 'package:floodsystem/const.dart';
import 'package:floodsystem/providers/imphalriverprovider.dart';
import 'package:floodsystem/providers/irilprovider.dart';
import 'package:floodsystem/providers/riverprovider.dart';
import 'package:floodsystem/screens/desktop.dart';
import 'package:floodsystem/screens/mobile.dart';
import 'package:floodsystem/screens/mobile/graphscreen.dart';
import 'package:floodsystem/screens/mobile/mobilesettings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  static const String routename = 'homescreen';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController _controller = PageController(); 
  int _currentindex = 0;
  @override
  void initState() {
    
    super.initState();
    // Future.microtask(() => Provider.of<NambulProvider>(context,listen: false).getdata());
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) { 
      Provider.of<NambulProvider>(context,listen: false).getdata();
      Provider.of<ImphalRiverProvider>(context,listen: false).getdata();
      Provider.of<IrilRiverProvider>(context,listen: false).getdata();
    });

  }

  final List<Widget> _navigationscreenlist = const [MobileScreen(),GraphScreen(),MobileSettings()];
  
  void onSelectNavigation(int index){
    setState(() {
      _currentindex = index;
      _controller.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.decelerate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(appname,style: TextStyle(fontSize: headersize),),
      ),
      body:
      Consumer<NambulProvider>(builder:(c,b,d)=>
      
      LayoutBuilder(builder:(context,constraint){
        if(constraint.maxWidth<500){

          return PageView(
            scrollDirection: Axis.horizontal,
            children: _navigationscreenlist,
            controller: _controller,
            onPageChanged: onSelectNavigation,

          );
        }
        else{
          return DesktopScreen();
        }
      })),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _currentindex,
        selectedItemColor: normalColor,
        unselectedItemColor: Colors.grey,
        onTap: onSelectNavigation,
        items:const [
        BottomNavigationBarItem(icon:Icon(Icons.home),label: 'home'),
        BottomNavigationBarItem(icon:Icon(Icons.bar_chart),label: 'graphs'),
        BottomNavigationBarItem(icon:Icon(Icons.settings),label: 'settings',),
      ]),
    );
  }
}