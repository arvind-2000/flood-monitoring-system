import 'package:flutter/material.dart';
const String notificationtitle = '';
const String imphalriver = 'http://10.10.1.139:88/api/channel-data/337099/feeds?api_key=73B670EB2B784FEE';
const String irilriver = 'http://10.10.1.139:88/api/channel-data/839204/feeds?api_key=11232D7AB82F48A3';
const String nambulriver = 'http://10.10.1.139:88/api/channel-data/154208/feeds?api_key=F287343B4F124E0F';
const String appname = 'Flood Monitor';
const Color errorColor = Color.fromARGB(255, 214, 80, 68);
const Color normalColor = Color.fromARGB(255, 125, 195, 228);
const int checktime = 30;
const Color backgroundColor = Color.fromARGB(255, 231, 230, 230);
const Color cardcolor = Colors.white;
const double headersize = 28;
const double headersize2 = 20;
const double headersize3 = 24;
const double regularfontsize = 16;
const double regularpadding = 16;
const double radius = 16;
const threshold  = 60;
const normalbanner = 'Normal';
List<Color?> rivercolors = [Colors.blue.withOpacity(0.5),Colors.brown.withOpacity(0.5),Colors.greenAccent.withOpacity(0.5)];
const alertbannertext = 'Danger';
BoxDecoration carddecoration = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(radius)
);
const List<String> apicalls = [imphalriver,nambulriver,irilriver];

double toDouble(String d){
  double _value = 0;
  try{
    
    _value = double.parse(d); 
  }catch(e){
    print('no values for double conversion');
    _value = 0;
  }
  return _value;
}