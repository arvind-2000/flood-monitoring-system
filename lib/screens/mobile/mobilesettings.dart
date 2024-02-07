import 'dart:developer';
import 'dart:io';

import 'package:floodsystem/const.dart';
import 'package:floodsystem/providers/riverprovider.dart';
import 'package:floodsystem/widgets/cards.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MobileSettings extends StatefulWidget {
  const MobileSettings({super.key});
  static const String routename = 'Settings';

  @override
  State<MobileSettings> createState() => _MobileSettingsState();
}

class _MobileSettingsState extends State<MobileSettings> {

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  bool _checkThresholdfield = false;
  bool isSaved = false;
  final TextEditingController _thresholdfield = TextEditingController();
  void checkthreshold() {
          if(_checkThresholdfield){
        setprefs(double.parse(_thresholdfield.text));
      }

    
    setState(() {



      _checkThresholdfield = !_checkThresholdfield;
      // if(_checkThresholdfield){
      //   _checkThresholdfield = false;
      //   setprefs(double.parse(_thresholdfield.text));
      // }
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    Provider.of<NambulProvider>(context,listen: false).getprefs();

    super.initState();
  }
  void setprefs(double? d) async{
    final prefs = await _prefs;
    prefs.setDouble('threshold', d??0).then((value){
      isSaved = true;
      print('saved');
    });
  }
  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<NambulProvider>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('Settings'),
      ),
      body: SingleChildScrollView(
        child: Container(
            // decoration: BoxDecoration(
            //  color:cardcolor,
            //   borderRadius: BorderRadius.circular(radius)
            // ),
            // margin: EdgeInsets.all(regularpadding),
            // padding: EdgeInsets.all(regularpadding),
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            CardsContainer(
              margins: EdgeInsets.all(16),
              paddings: EdgeInsets.all(8),
              cardcolor: Theme.of(context).colorScheme.primary,
              childs: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Threshold',
                          style: TextStyle(
                              fontSize: headersize2, fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                            onPressed: () {
                              checkthreshold();
                            },
                            icon: FaIcon(
                              
                              _checkThresholdfield
                                  ? FontAwesomeIcons.checkDouble
                                  : FontAwesomeIcons.penToSquare,
                              size: 20,
                              color: Theme.of(context).colorScheme.secondary,
                            ))
                      ],
                    ),
                    AnimatedOpacity(
                      opacity: _checkThresholdfield ? 1.0 : 0.0,
                      curve: Curves.easeIn,
                      duration: Duration(milliseconds: 1000),
                      child: _checkThresholdfield
                          ? CardsContainer(
                            margins: EdgeInsets.only(bottom: 16),
                            paddings: EdgeInsets.all(8),
                              cardcolor:Theme.of(context).colorScheme.error.withOpacity(0.3),
                              childs: Column(
                                children: [
                                  FaIcon(FontAwesomeIcons. triangleExclamation,color:Theme.of(context).colorScheme.error,),
                                  Text(
                                    
                                    'This will change the threshold value.\nChanging will vary in the monitoring system of the app.\nProceed with caution',
                                    style: TextStyle(
                                       ),
                                        textAlign: TextAlign.center,
                                  ),
                                 
                                ],
                              ))
                          : SizedBox(),
                    ),
                   
                    TextField(
                      enabled: _checkThresholdfield,
                      controller: _thresholdfield,
                      keyboardType: TextInputType.number,
                      onSubmitted: (v){
                      
                       setprefs(double.parse(v));
                       _checkThresholdfield = false;
                       prov.getprefs();
                    
                      },
                      decoration: InputDecoration(
                        hintStyle: TextStyle(fontWeight: FontWeight.bold),
                        hintText: '${prov.getThreshold}',
                        
                        border:_checkThresholdfield?OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.background
                            )
                        
                        ):InputBorder.none
                      ),
                    ),
                  ],
                ),
              ),
            ),
        
           Platform.isAndroid?CardsContainer(
              
              childs: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: double.infinity,),
                Text("Background Service",style: TextStyle(fontSize: 20),),
                GestureDetector(
                  onTap: () async{
                final service = FlutterBackgroundService();
                bool isRunning = await service.isRunning();
                if (isRunning) {
                  service.invoke('StopService');
                } else {
                   service.invoke('AsBackGround');
                  service.startService();
                }
        
                if (!isRunning) {
                  service.invoke('StopService');
                  print("service stop");
                } else {
                  print('start service');
                }
                  },
                  child: CardsContainer(
                  margins: EdgeInsets.symmetric(vertical: 8),
                  paddings: EdgeInsets.all(16),
                  childs: Text('Start Service'), cardcolor: Theme.of(context).colorScheme.secondary))
        
              ],
            ),  margins: EdgeInsets.all(16),
              paddings: EdgeInsets.all(16),
              cardcolor: Theme.of(context).colorScheme.primary,):SizedBox(),
        
            // ElevatedButton(
            //   onPressed: () {
            //     FlutterBackgroundService().invoke('AsForeGround');
            //   },
            //   child: Padding(
            //     padding: const EdgeInsets.all(regularpadding),
            //     child: Text('AsForeGround'),
            //   ),
            // ),
            // ElevatedButton(
            //   onPressed: () {
            //     FlutterBackgroundService().invoke('AsBackGround');
            //   },
            //   child: Padding(
            //     padding: const EdgeInsets.all(regularpadding),
            //     child: Text('Background'),
            //   ),
            // ),
            // ElevatedButton(
            //   onPressed: () async {
            //     final service = FlutterBackgroundService();
            //     bool isRunning = await service.isRunning();
            //     if (isRunning) {
            //       service.invoke('StopService');
            //     } else {
            //       service.startService();
            //     }
        
            //     if (!isRunning) {
            //       service.invoke('StopService');
            //       print("service stop");
            //     } else {
            //       print('start service');
            //     }
            //   },
            //   child: Padding(
            //     padding: const EdgeInsets.all(regularpadding),
            //     child: Text('Periodic'),
            //   ),
            // )
          ],
        )),
      ),
    );
  }
}
