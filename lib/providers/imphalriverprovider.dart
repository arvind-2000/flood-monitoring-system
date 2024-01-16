import 'dart:convert';
import 'package:floodsystem/const.dart';
import 'package:floodsystem/models/riverdetails.dart';
import 'package:floodsystem/services/services.dart';
import 'package:flutter/material.dart';

import '../models/river.dart';

class ImphalRiverProvider with ChangeNotifier {
  RiverDetails _imphalriverlist = RiverDetails(id: '', name: '', river: []);
  RiverDetails get getallimphalrivers => _imphalriverlist;
  bool isLoading = true;
  int responsevalue = 0;
  get http => null;
  bool floodindicator = false;

  // Future<void> getdata() async{
  
  // Service ser = Service();
  // RiverDetails datas = await ser.getdata(imphalriver);
  // _imphalriverlist = datas;
  // responsevalue = ser.responsecode;
  // print(responsevalue);
  // isLoading = false;
  // indicator();
  // notifyListeners();   
  // }

    
    void indicator(){
    Service ser  = Service();
    double value = 0.0;
    try{
      value = double.parse(_imphalriverlist.river.last.hv);
    }
    catch(e){
      print('no value for doubles');
      value = 0.0;
    }
    floodindicator =  ser.floodIndicator(value);
    notifyListeners();
  }
  

}
