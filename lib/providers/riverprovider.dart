import 'dart:convert';
import 'package:floodsystem/const.dart';
import 'package:floodsystem/models/riverdetails.dart';
import 'package:floodsystem/services/services.dart';
import 'package:flutter/material.dart';

import '../models/river.dart';

class NambulProvider with ChangeNotifier {
  RiverDetails _riverDetails = RiverDetails(id: '', name: '', river: []);
  RiverDetails get getnambulrivers => _riverDetails;
  bool isLoading = true;
  int responsevalue = 0;
  get http => null;
  bool floodindicator = false;
  

  Future<void> getdata() async{
  
  Service ser = Service();
  RiverDetails datas = await ser.getdata(nambulriver);
  _riverDetails = datas;
  responsevalue = ser.responsecode;
  print(responsevalue);
  isLoading = false;
  indicator();
  notifyListeners();   
  }

  void indicator(){
    Service ser  = Service();
    double value = 0.0;
    try{
      value = double.parse(_riverDetails.river.last.hv);
    }
    catch(e){
      print('no value for doubles');
      value = 0.0;
    }
    floodindicator =  ser.floodIndicator(value);
    notifyListeners();
  }

}
