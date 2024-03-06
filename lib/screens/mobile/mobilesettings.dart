import 'dart:developer';
import 'dart:io';

import 'package:floodsystem/const.dart';
import 'package:floodsystem/providers/riverprovider.dart';
import 'package:floodsystem/services/backgroundservice.dart';
import 'package:floodsystem/widgets/cards.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:device_info_plus/device_info_plus.dart';

class MobileSettings extends StatefulWidget {
  const MobileSettings({super.key});
  static const String routename = 'Settings';

  @override
  State<MobileSettings> createState() => _MobileSettingsState();
}

class _MobileSettingsState extends State<MobileSettings> {
  final service = FlutterBackgroundService();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  bool checkThresholdfield = false;
  bool checktimer = false;
  bool isSaved = false;
  bool isRunning = false;
  bool isNotified = false;
  bool _pred = false;
  int sdk = 0;
  final TextEditingController _thresholdfield = TextEditingController();
  final TextEditingController _timerfield = TextEditingController();
  void checkthreshold() {
    if (checkThresholdfield) {
      setprefs(toDouble(_thresholdfield.text));
    }
  }

  void checktimers() {
    if (checktimer) {
      try {
        int d = int.parse(_timerfield.text);
        setprefstime(d);

      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Not updated"),
          duration: Duration(seconds: 2),
          backgroundColor: Theme.of(context).colorScheme.error.withOpacity(0.4),
        ));
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<NambulProvider>(context, listen: false).getprefs();
      _thresholdfield.text = Provider.of<NambulProvider>(context, listen: false)
          .getThreshold
          .toStringAsFixed(0);
      checkbackground();
      checknoti();
    });

    super.initState();
  }

  Future<void> checkbackground() async {
    await service.isRunning().then((value) {
      setState(() {
        isRunning = value;
      });
    });
  }

  Future<void> checknoti() async {
    await Permission.notification.isGranted.then((value) {
      setState(() {
        isNotified = value;
      });
    });
  }

  Future<int> checkSdk() async {
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    await deviceInfoPlugin.androidInfo.then((value) {
      return value.version.sdkInt;
    });
    return 0;
  }

  void setprefs(double? d) async {
    final prefs = await _prefs;
    prefs.setDouble('threshold', d ?? 0).then((value) {
      isSaved = true;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Threshold Change to ${d!.roundToDouble()}"),
        duration: const Duration(seconds: 3),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ));
    });
  }

  void setprefstime(int? d) async {
    final prefs = await _prefs;
    prefs.setInt('checktime', d ?? 0).then((value) {
      isSaved = true;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Timer Change to $d"),
        duration: const Duration(seconds: 2),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ));
    });
  }

  void setprefsbool(bool? d) async {
    final prefs = await _prefs;
    prefs.setBool('prediction', d ?? false).then((value) {
      isSaved = true;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(d! ? 'Forecast enabled' : 'Forecast disabled'),
        duration: const Duration(seconds: 2),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ));
    });
  }
  void setprefsbools(bool? d) async {
    final prefs = await _prefs;
    prefs.setBool('background', d ?? false).then((value) {
      isRunning = !d!;

    });
  }
  void stopBackgroundandstart() {
    final service = FlutterBackgroundService();
    service.invoke('StopService');
    service.invoke('AsBackGround');
    service.startService();
    setprefsbools(!isRunning);
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
                              fontSize: headersize2,
                              fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                            onPressed: () {
                              checkthreshold();
                              checkThresholdfield = !checkThresholdfield;
                              prov.getprefs();
                              if (isRunning) {
                                  stopBackgroundandstart();
                                
                              }
                            },
                            icon: FaIcon(
                              checkThresholdfield
                                  ? FontAwesomeIcons.checkDouble
                                  : FontAwesomeIcons.penToSquare,
                              size: 20,
                              color: Theme.of(context).colorScheme.secondary,
                            ))
                      ],
                    ),
                    AnimatedOpacity(
                      opacity: checkThresholdfield ? 1.0 : 0.0,
                      curve: Curves.easeIn,
                      duration: Duration(milliseconds: 1000),
                      child: checkThresholdfield
                          ? CardsContainer(
                              margins: EdgeInsets.only(bottom: 16),
                              paddings: EdgeInsets.all(8),
                              cardcolor: Theme.of(context)
                                  .colorScheme
                                  .error
                                  .withOpacity(0.3),
                              childs: Column(
                                children: [
                                  FaIcon(
                                    FontAwesomeIcons.triangleExclamation,
                                    color: Theme.of(context).colorScheme.error,
                                  ),
                                  const Text(
                                    'This will change the threshold value.\nChanging will vary in the monitoring system of the app.\nProceed with caution',
                                    style: TextStyle(),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ))
                          : SizedBox(),
                    ),
                    TextFormField(
                      enabled: checkThresholdfield,
                      controller: _thresholdfield,
                      keyboardType: TextInputType.number,
                      onFieldSubmitted: (v) {
                        setprefs(double.parse(v));
                        checkThresholdfield = false;
                        prov.getprefs();
                      },
                      decoration: InputDecoration(
                          hintStyle: TextStyle(fontWeight: FontWeight.bold),
                          hintText: '${prov.getThreshold}',
                          border: checkThresholdfield
                              ? OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .background))
                              : InputBorder.none),
                    ),
                  ],
                ),
              ),
            ),

            Platform.isAndroid
                ? CardsContainer(
                    childs: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          width: double.infinity,
                        ),
                        const Text(
                          "Background Service",
                          style: TextStyle(fontSize: 20),
                        ),
                        GestureDetector(
                            onTap: () async {
                              final service = FlutterBackgroundService();
                              if (!prov.isBackgroundrunning) {
                                await initializeService().then((value) {
                                  isRunning = !isRunning;
                                  service.invoke('AsForeGround');
                                  service.invoke('AsBackGround');
                                  service.startService();
                                });
                                prov.setPrefsbackground(true);
                                prov.getprefs();
                              } else {
                                isRunning = await service.isRunning();
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

                                setState(() {
                                  isRunning = !isRunning;
                                });
                              }

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(isRunning
                                    ? "Background Service started"
                                    : "Background Service stop\nNotifications are canceled"),
                                duration: const Duration(seconds: 3),
                                backgroundColor: isRunning
                                    ? Theme.of(context)
                                        .colorScheme
                                        .secondary
                                        .withOpacity(0.4)
                                    : Theme.of(context)
                                        .colorScheme
                                        .error
                                        .withOpacity(0.4),
                              ));
                            },
                            child: CardsContainer(
                                margins: EdgeInsets.symmetric(vertical: 8),
                                paddings: EdgeInsets.all(16),
                                childs: Text(isRunning
                                    ? "Stop Service"
                                    : 'Start Service'),
                                cardcolor:
                                    Theme.of(context).colorScheme.secondary))
                      ],
                    ),
                    margins: EdgeInsets.all(16),
                    paddings: EdgeInsets.all(16),
                    cardcolor: Theme.of(context).colorScheme.primary,
                  )
                : SizedBox(),

            Platform.isAndroid
                ? CardsContainer(
                    childs: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: double.infinity,
                        ),
                        Text(
                          "Notification Permission",
                          style: TextStyle(fontSize: 20),
                        ),
                        InkWell(
                            onTap: () async {
                              if (isNotified) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: const Text("Already Accepted"),
                                  duration: const Duration(seconds: 3),
                                  backgroundColor:
                                      Theme.of(context).colorScheme.primary,
                                ));
                              } else {
                                try {
                                  await Permission.notification.isDenied.then(
                                    (value) {
                                      if (value) {
                                        Permission.notification.request();

                                        checknoti();
                                      }
                                    },
                                  );
                                } on Exception catch (e) {
                                  openAppSettings();
                                  checknoti();
                                  log(e.toString());
                                  // TODO
                                }
                              }
                            },
                            child: CardsContainer(
                                margins: EdgeInsets.symmetric(vertical: 8),
                                paddings: EdgeInsets.all(16),
                                childs:
                                    Text(isNotified ? "Allowed" : 'Request'),
                                cardcolor:
                                    Theme.of(context).colorScheme.secondary))
                      ],
                    ),
                    margins: EdgeInsets.all(16),
                    paddings: EdgeInsets.all(16),
                    cardcolor: Theme.of(context).colorScheme.primary,
                  )
                : SizedBox(),

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
                          'Timer Schedule',
                          style: TextStyle(
                              fontSize: headersize2,
                              fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                            onPressed: () {
                              checktimers();
                              checktimer = !checktimer;
                              prov.getprefs();
                              prov.destroy();
                              prov.timer();
                            },
                            icon: FaIcon(
                              checkThresholdfield
                                  ? FontAwesomeIcons.checkDouble
                                  : FontAwesomeIcons.penToSquare,
                              size: 20,
                              color: Theme.of(context).colorScheme.secondary,
                            ))
                      ],
                    ),
                    AnimatedOpacity(
                      opacity: checktimer ? 1.0 : 0.0,
                      curve: Curves.easeIn,
                      duration: Duration(milliseconds: 1000),
                      child: checktimer
                          ? CardsContainer(
                              margins: EdgeInsets.only(bottom: 16),
                              paddings: EdgeInsets.all(8),
                              cardcolor: Theme.of(context)
                                  .colorScheme
                                  .error
                                  .withOpacity(0.3),
                              childs: Column(
                                children: [
                                  FaIcon(
                                    FontAwesomeIcons.triangleExclamation,
                                    color: Theme.of(context).colorScheme.error,
                                  ),
                                  const Text(
                                    'This will change the timer duration.\nChanging will vary in the monitoring system of the app.\nProceed with caution',
                                    style: TextStyle(),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ))
                          : SizedBox(),
                    ),
                    TextFormField(
                      enabled: checktimer,
                      controller: _timerfield,
                      keyboardType: TextInputType.number,
                      onFieldSubmitted: (v) {
                        checktimers();
                        checktimer = false;
                        prov.getprefs();
                      },
                      decoration: InputDecoration(
                          hintStyle: TextStyle(fontWeight: FontWeight.bold),
                          hintText: '${prov.durationtime}',
                          border: checktimer
                              ? OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .background))
                              : InputBorder.none),
                    ),
                  ],
                ),
              ),
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
                          'Forecast',
                          style: TextStyle(
                              fontSize: headersize2,
                              fontWeight: FontWeight.bold),
                        ),
                        Switch(
                          value: prov.predictionswitch,
                          onChanged: (v) {
                            setState(() {
                              setprefsbool(v);
                              prov.getprefs();
                            });
                          },
                          splashRadius: 0.5,
                          activeColor: Theme.of(context).colorScheme.secondary,
                        )
                      ],
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
      ),
    );
  }
}
