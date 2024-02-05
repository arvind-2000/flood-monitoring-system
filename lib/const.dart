import 'package:flutter/material.dart';
const String notificationtitle = '';
const String imphalriver = 'http://10.10.1.139:88/api/channel-data/337099/feeds?api_key=E5CB7E7E6F4B451D&dtfrom=2023-12-27&dtupto=2024-02-20';
const String irilriver = 'http://10.10.1.139:88/api/channel-data/839204/feeds?api_key=11232D7AB82F48A3&dtfrom=2023-12-27&dtupto=2024-02-20';
const String nambulriver = 'http://10.10.1.139:88/api/channel-data/154208/feeds?api_key=F287343B4F124E0F&dtfrom=2023-01-27&dtupto=2024-02-20';

const String imphalriverlatest = 'http://10.10.1.139:88/api/channel-data/337099/latest-feeds?api_key=E5CB7E7E6F4B451D';
const String irilriverlatest = 'http://10.10.1.139:88/api/channel-data/839204/latest-feeds?api_key=11232D7AB82F48A3';
const String nambulriverlatest = 'http://10.10.1.139:88/api/channel-data/154208/latest-feeds?api_key=F287343B4F124E0F';
const String appname = 'River Sense';
const Color errorColor = Color.fromARGB(255, 214, 80, 68);
const Color normalColor = Color.fromARGB(255, 125, 195, 228);
const int checktime = 10;
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

const levelunit = "ft";
const humiditylevel = "%";
const templevel = "°C";
 

const Map<int,String> graphIntervals = {0:'latest',1:'1D',2:'1M',3:'1Y'};
List<String> sensorslist = ['Levels','Humidity','Temp'];
List<Color?> rivercolors = [Colors.blue.withOpacity(0.5),Colors.brown.withOpacity(0.5),Colors.greenAccent.withOpacity(0.5)];

List<String>  months = ['Jan','Feb','Mar','Apl','May','June','July','Aug','Sep','Oct','Nov','Dec'];
const alertbannertext = 'Danger';
BoxDecoration carddecoration = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(radius)
);
const List<String> apicalls = [imphalriver,nambulriver,irilriver];
const List<String> apicallslatest = [imphalriverlatest,nambulriverlatest,irilriverlatest];

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


String getDate(DateTime date){
  return '${date.day}/${date.month}/${date.year}';
}
String gethour(DateTime date){
  return '${date.hour}:${date.minute}:${date.second}';
}