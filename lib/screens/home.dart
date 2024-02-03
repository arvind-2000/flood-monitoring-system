import 'package:floodsystem/const.dart';
import 'package:floodsystem/providers/riverprovider.dart';
import 'package:floodsystem/screens/desktop.dart';
import 'package:floodsystem/screens/mobile.dart';
import 'package:floodsystem/screens/mobile/errorscreen.dart';
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
  PageController _controller = PageController(initialPage: 0, keepPage: true);
  int _currentindex = 0;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<NambulProvider>(context, listen: false).timer();
      Provider.of<NambulProvider>(context, listen: false).getprefs();
    });

    super.initState();
  }

  @override
  void dispose() {
    Provider.of<NambulProvider>(context, listen: false).destroy();
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
    return (!prov.isLoading && prov.responsevalue == 1) || prov.isSaved
        ? WillPopScope(
            onWillPop: _onWillPop,
            child: Scaffold(
              backgroundColor: Theme.of(context).colorScheme.background,
              appBar: AppBar(
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
                return LayoutBuilder(builder: (context, constraint) {
                  if (constraint.maxWidth < 500) {
                    return MobileScreen();
                  } else {
                    return DesktopScreen();
                  }
                });
              }),
            ),
          )
        : ErrorScreen();
  }
}
