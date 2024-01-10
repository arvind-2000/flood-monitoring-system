// ignore_for_file: unnecessary_type_check

import 'dart:async';
import 'dart:ui';

import 'package:floodsystem/const.dart';
import 'package:floodsystem/models/riverdetails.dart';
import 'package:floodsystem/providers/riverprovider.dart';

import 'package:floodsystem/services/notifications.dart';
import 'package:floodsystem/services/services.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> initializeService() async{
  final service = FlutterBackgroundService();
  await service.configure(iosConfiguration: IosConfiguration(
    autoStart: true,
    onForeground: onStart,
    onBackground: onBackgound
  ), androidConfiguration: AndroidConfiguration(onStart:onStart, isForegroundMode: true));
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async{
  Service ser = Service();
  NambulProvider _prov = NambulProvider();   
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

     Timer.periodic(Duration(seconds: 10), (timer) async{ 
      
      _prov.getdata();

      if(service is AndroidServiceInstance){

      
      try{
            print('Backgroudn: In try ');
            s = _prov.getnambulrivers[0].name;
     
          print('River name: $s');
          //  showNotification(notificationsPlugin: _flutterLocalNotificationsPlugin, title: "Flood Level Critical", body: 'Water level raised:\n$s');
          int k = _prov.floodindicator.length;
          for(int i = 0;i<k;i++){
            if(_prov.floodindicator[i]){
              s = _prov.getnambulrivers[i].name;
              showNotification(notificationsPlugin: _flutterLocalNotificationsPlugin, title: "Flood Level Critical", body: 'Water level raised:\n${_prov.getnambulrivers[i].name}');
            }
          }
      }catch(e){
          print("no data:$e");
      }

        if(await service.isForegroundService()){
         service.setForegroundNotificationInfo(title: 'background', content:'Water level raised:\n$s');
      
        }
      }
  
      print('background service running');
      service.invoke('update');
     });
  }
  }

@pragma('vm:entry-point')
FutureOr<bool> onBackgound(ServiceInstance service) {
  return true;
}
