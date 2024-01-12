import 'package:floodsystem/const.dart';
import 'package:floodsystem/widgets/cards.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MobileSettings extends StatefulWidget {
  const MobileSettings({super.key});
  static const String routename = 'Settings';

  @override
  State<MobileSettings> createState() => _MobileSettingsState();
}

class _MobileSettingsState extends State<MobileSettings> {
  bool _checkThresholdfield = false;
  final TextEditingController _thresholdfield = TextEditingController();
  void checkthreshold() {
    setState(() {
      _checkThresholdfield = !_checkThresholdfield;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('Settings'),
      ),
      body: Container(
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
            cardcolor: Colors.white.withOpacity(0.4),
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
                                ? FontAwesomeIcons.check
                                : FontAwesomeIcons.penToSquare,
                            size: 20,
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
                            cardcolor: errorColor.withOpacity(0.3),
                            childs: Column(
                              children: [
                                FaIcon(FontAwesomeIcons. triangleExclamation,color: Colors.black.withOpacity(0.7),),
                                Text(
                                  
                                  'This will change the threshold value.\nChanging will vary in the monitoring system of the app.\nProceed with caution',
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.6)),
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
                    decoration: InputDecoration(
                      hintStyle: TextStyle(fontWeight: FontWeight.bold,color:Colors.black.withOpacity(_checkThresholdfield?0.3:1.0)),
                      hintText: '$threshold',
                    
                      border:_checkThresholdfield?OutlineInputBorder():InputBorder.none
                    ),
                  ),
                ],
              ),
            ),
          ),
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
    );
  }
}
