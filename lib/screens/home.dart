
import 'dart:developer';
import 'package:floodsystem/const.dart';
import 'package:floodsystem/providers/riverprovider.dart';
import 'package:floodsystem/screens/desktop/desktop.dart';

import 'package:floodsystem/screens/mobile.dart';
import 'package:floodsystem/screens/mobile/errorscreen.dart';
import 'package:floodsystem/screens/mobile/graphscreen.dart';
import 'package:floodsystem/screens/mobile/mobilesettings.dart';
import 'package:floodsystem/screens/mobile/tablescreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  static const String routename = 'homescreen';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController _controller = PageController(initialPage: 0, keepPage: true);
  int _currentindex = 0;
  final _advancedController = AdvancedDrawerController();
  @override
  void initState() {
    log('in init state home');
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<NambulProvider>(context, listen: false).timer();
      Provider.of<NambulProvider>(context, listen: false).getprefs();
    });

    super.initState();
  }

  @override
  void dispose() {
    Provider.of<NambulProvider>(context, listen: false).destroy();
    _advancedController.dispose();
    super.dispose();
  }

  // final List<Widget> _navigationscreenlist =  [MobileScreen(onchanged: onSelectNavigation,),GraphScreen()];

  void onSelectNavigation(int index) {
    setState(() {
      _currentindex = index;

      _controller.animateToPage(_currentindex,
          duration: Duration(milliseconds: 200), curve: Curves.linear);
    });
  }

  Future<bool> _onWillPop() async {
    if (_currentindex == 0) {
      return (await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              backgroundColor: Theme.of(context).colorScheme.primary,
              title: const Text('Are you sure?'),
              content: const Text('Do you want to exit the app'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text(
                    'No',
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.surface),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text(
                    'Yes',
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.surface),
                  ),
                ),
              ],
            ),
          )) ??
          false;
    } else {
      onSelectNavigation(0);
      return false;
    }
  }




  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<NambulProvider>(context);
    log('home');

    
    return (!prov.isLoading && prov.responsevalue == 1) || prov.isSaved
        ? WillPopScope(
            onWillPop: _onWillPop,
            child:LayoutBuilder(
              builder: (context,constraints) {
               
                    return AdvancedDrawer(
                
                  controller: _advancedController,
                   backdrop: Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Theme.of(context).colorScheme.secondary.withOpacity(0.4),Theme.of(context).colorScheme.primary.withOpacity(0.2)],
                          ),
                        ),
                      ),
                           drawer: SafeArea(
                        child: Container(
                          child: ListTileTheme(
                textColor: Theme.of(context).colorScheme.surface,
                iconColor:  Theme.of(context).colorScheme.surface,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: 128.0,
                      height: 128.0,
                      margin: const EdgeInsets.only(
                        top: 24.0,
                        bottom: 64.0,
                      ),
                  
              
                      child: Image.asset(
                      'assets/images/logodark.png',
                      ),
                    ),
                   Expanded(
                     child: ListView(
                       
                        children: [
                          ListTile(
                            onTap: () {
                            _advancedController.hideDrawer();
                            },
                            leading: Icon(Icons.home),
                            title: Text('Home'),
                          ),
                          ListTile(
                            onTap: () {
                                      Navigator.pushNamed(context,GraphScreen.routename);
                            },
                            leading: FaIcon(FontAwesomeIcons.chartLine),
                            title: Text('Charts'),
                          ),
                          ListTile(
                            onTap: () {
                              Navigator.pushNamed(context,TableScreen.routename);
                            },
                            leading: FaIcon(FontAwesomeIcons.table),
                            title: Text('Tables'),
                          ),
                          ListTile(
                            onTap: () {
                                        
                                Navigator.pushNamed(context,MobileSettings.routename);
                            },
                            leading: Icon(Icons.settings),
                            title: Text('Settings'),
                          ),
                          // Spacer(),
                      
                        ],
                      ),
                   ),
                  ],
                ),
                          ),
                        ),
                      ),
                
                
                  child: Scaffold(
                    backgroundColor: Theme.of(context).colorScheme.background,
                    appBar: AppBar(
                      leading: IconButton(onPressed: (){
                        _advancedController.showDrawer();
                
                      }, icon:const FaIcon(FontAwesomeIcons.bars)),
                      backgroundColor: Colors.transparent,
                      title: const Text(
                        appname,
                        style: TextStyle(fontSize: headersize),
                      ),
                      actions: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: IconButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, MobileSettings.routename);
                              },
                              icon: FaIcon(
                                FontAwesomeIcons.gear,
                                color: Theme.of(context).colorScheme.surface,
                              )),
                        )
                      ],
                    ),
                
                        
                    body: Consumer<NambulProvider>(builder: (c, b, d) {
                        return const MobileScreen();
                     
                    }),
                  ),
                );
            

                
              }
            ),
          )
        : ErrorScreen();
  }
}
