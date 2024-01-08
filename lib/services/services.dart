import 'dart:convert';
import 'package:floodsystem/const.dart';
import 'package:floodsystem/models/riverdetails.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/river.dart';

class Service{

  int responsecode = 0;

  Future<RiverDetails> getdata(String api) async{
    RiverDetails datas = RiverDetails(id: '', name: '', river: []);
    try{
    var response = await http.get(Uri.parse(api));
    if(response.statusCode == 200){
      var data = jsonDecode(response.body) as Map<String,dynamic>;
      print(data['feeds'].length);
      datas = convertValues(data['feeds'],data['channel']['name'],data['channel']['id']);
      responsecode = 1;
    }else{
      print('Error connecting to the server');
      responsecode = 2;
    }

    }
    catch(e){
      responsecode = 3;
      print('Error while Connecting');
    }
    return  datas;
  }

 RiverDetails convertValues(List<dynamic> data,name,channelid) {
    List<River> tempdata = [];
    
    try{
  for(var d in data){
      print(' $channelid  $name');
        River value = River(id: d["id"].toString(), channelid:channelid, name: name, usv: d["field2"], hv: d["field4"], tv: d["field3"], date: d["created"]);
        tempdata.add(value);
     }

    }catch(e){
      print('$e');
    }
    RiverDetails rivers =RiverDetails(id: channelid, name: name, river: tempdata);
     return rivers;

  }


    bool floodIndicator(double value){
      if(value>threshold){
        return true;
      }
      return false;
    }

    List<double> datapoints(RiverDetails d){
      List<double> _data = [];
      
          for(River x in d.river){
              double val = 0.0;
              try{
                  val = double.parse(x.usv); 
              }catch(e){
                  val = 0.0;
              }
            _data.add(val);
          }
          return [..._data];
     

    }
}