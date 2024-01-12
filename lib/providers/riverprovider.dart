
import 'dart:async';
import 'dart:developer';

import 'package:floodsystem/const.dart';
import 'package:floodsystem/models/riverdetails.dart';
import 'package:floodsystem/services/services.dart';
import 'package:flutter/material.dart';



class NambulProvider with ChangeNotifier {
  List<RiverDetails> _riverlist = [];
  // RiverDetails _riverDetails = RiverDetails(id: '', name: '', river: []);
  List<RiverDetails> get getnambulrivers => _riverlist;
  bool isLoading = true;
  int responsevalue = 0;
  get http => null;
  List<bool> floodindicator = [];
  

  Future<void> getdata() async{

  List<RiverDetails>  rivers = [];
  RiverDetails riverDetails = RiverDetails(id: '', name: '', river: []);
  Service ser = Service();
  for(String i in apicalls){
  riverDetails = await ser.getdata(i);
  rivers.add(riverDetails);
  responsevalue = ser.responsecode;

  _riverlist = rivers;
  print(responsevalue);
  isLoading = false;
  indicator();
  notifyListeners();   

  }

  }



  void indicator(){
    List<bool> floodIndicatorlist = [];
    Service ser  = Service();
    for (RiverDetails d in _riverlist) {
  double value = 0.0;
  try{
    value = double.parse(d.river.last.hv);
  }
  catch(e){
    print('no value for doubles');
    value = 0.0;
  }
   floodIndicatorlist.add(ser.floodIndicator(value));
}
floodindicator = floodIndicatorlist;
  notifyListeners();
  }





}
