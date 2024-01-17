import 'package:floodsystem/const.dart';
import 'package:floodsystem/providers/imphalriverprovider.dart';
import 'package:floodsystem/providers/irilprovider.dart';
import 'package:floodsystem/providers/riverprovider.dart';
import 'package:floodsystem/screens/desktop.dart';
import 'package:floodsystem/screens/mobile.dart';
import 'package:floodsystem/screens/mobile/errorscreen.dart';
import 'package:floodsystem/screens/mobile/graphscreen.dart';
import 'package:floodsystem/screens/mobile/mobilesettings.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  static const String routename = 'homescreen';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  PageController _controller = PageController(initialPage: 0,keepPage: true); 
  int _currentindex = 0;

  @override
  void initState() {
    // TODO: implement initState
  WidgetsBinding.instance.addPostFrameCallback((timeStamp) { 

    Provider.of<NambulProvider>(context,listen: false).timer();
    Provider.of<NambulProvider>(context,listen: false).getprefs();
  });

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    Provider.of<NambulProvider>(context,listen: false).destroy();
    super.dispose();
  }

  // final List<Widget> _navigationscreenlist =  [MobileScreen(onchanged: onSelectNavigation,),GraphScreen()];
  
  void onSelectNavigation(int index){
    setState(() {
      _currentindex = index;
      
      _controller.animateToPage(_currentindex, duration: Duration(milliseconds: 200), curve: Curves.linear);
    });

  

  }



  @override
  Widget build(BuildContext context) {
     final prov = Provider.of<NambulProvider>(context);
    return !prov.isLoading && prov.responsevalue==1?Scaffold(
      backgroundColor:Theme.of(context).colorScheme.background,
      appBar: AppBar(
 
        backgroundColor: Colors.transparent,
        title: const Text(appname,style: TextStyle(fontSize: headersize),),
        actions: [Padding(
          padding: const EdgeInsets.only(right: 8),
          child: IconButton(onPressed: (){
            Navigator.pushNamed(context, MobileSettings.routename);
          }, icon: FaIcon(FontAwesomeIcons.gear,color: Theme.of(context).colorScheme.surface,)),
        )],
      ),
      body:Consumer<NambulProvider>(builder:(c,b,d){
        
      return LayoutBuilder(builder:(context,constraint){
        // if(constraint.maxWidth<500){

          return PageView(
            scrollDirection: Axis.horizontal,
         
            children: [
             MobileScreen(onchanged: onSelectNavigation,),
             GraphScreen()
            ],
            controller: _controller,
            
            onPageChanged: onSelectNavigation,

          );
        // }
        // else{
        //   return DesktopScreen();
        // }
      });
      
      }),

      
      // bottomNavigationBar: BottomNavigationBar(
      //   backgroundColor: backgroundColor,
      //   elevation: 0,
      //   showSelectedLabels: false,
      //   showUnselectedLabels: false,
      //   currentIndex: _currentindex,
      //   selectedItemColor: normalColor,
      //   unselectedItemColor: Colors.grey,
      //   onTap: onSelectNavigation,
      //   items:const [
      //   BottomNavigationBarItem(icon:Icon(Icons.home),label: 'home'),
      //   BottomNavigationBarItem(icon:Icon(Icons.bar_chart),label: 'graphs'),
      //   // BottomNavigationBarItem(icon:Icon(Icons.settings),label: 'settings',),
      // ]),
    ):ErrorScreen();
  }
}