// ignore_for_file: unnecessary_type_check

import 'dart:async';
import 'dart:developer';
import 'dart:ui';
import 'package:floodsystem/models/riverdetails.dart';
import 'package:floodsystem/providers/riverprovider.dart';
import 'package:floodsystem/services/services.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../const.dart';

Future<void> initializeService() async{
  final service = FlutterBackgroundService();
  await service.configure(iosConfiguration: IosConfiguration(
    autoStart: true,
    onForeground: onStart,
    onBackground: onBackgound
  ), androidConfiguration: AndroidConfiguration(onStart:onStart, isForegroundMode: true,autoStartOnBoot: true,autoStart: true));
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async{
  Service ser = Service();
  NambulProvider _prov = NambulProvider();   
  DateTime d = DateTime.now();
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  DartPluginRegistrant.ensureInitialized();
  String s = 'hjg';

  if(service is AndroidServiceInstance){
    service.on('AsForeGround').listen((event) {
      service.setAsForegroundService();
     });
  }
    if(service is AndroidServiceInstance){
    service.on('AsBackGround').listen((event) {
      service.setAsBackgroundService();  
     });

     service.on('StopService').listen((event) {
      service.stopSelf();
      print("service stop");
     });

     Timer.periodic(const Duration(seconds: checktime), (timer) async{ 

     // monitor data here
      d = DateTime.now();
      _prov.getlatest( );
      _prov.getprefs();
      
      if(service is AndroidServiceInstance){

      String d = '';
      try{
            print('Backgroudn: In try ');
            // s = _prov.getnambulrivers[0].name;
         
          String s = '';
          // print('River name: $s');
          //  showNotification(notificationsPlugin: _flutterLocalNotificationsPlugin, title: "Flood Level Critical", body: 'Water level raised:\n$s');
          //check flood levels

          for(RiverDetails d in _prov.getnambulrivers){
              if(toDouble(d.river.last.usv)>=_prov.getThreshold){
                log("f:$s : ${d.river.last.usv}");
                s += "${d.name}  ${toDouble( d.river.last.usv).toStringAsFixed(2) }\n";
              }
          }
            if(s.isNotEmpty){
              d = 'Water level raised:\n $s';
             // showNotification(notificationsPlugin: _flutterLocalNotificationsPlugin, title: "Flood Level Critical", body: 'Water level raised:\n$s');
            }
          
      }catch(e){
          print("no data:$e");
      }

        if(await service.isForegroundService()){
         service.setForegroundNotificationInfo(title: 'River Sense', content:d,);
       
        }
      }
      //end monitor flood data
      print('background service running');
      service.invoke('update',{'current date':d.day});
     });
  }
  }

@pragma('vm:entry-point')
FutureOr<bool> onBackgound(ServiceInstance service) {
  return true;
}
