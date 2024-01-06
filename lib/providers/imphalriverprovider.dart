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


  Future<void> getdata() async{
  
  Service ser = Service();
  RiverDetails datas = await ser.getdata(imphalriver);
  _imphalriverlist = datas;
  responsevalue = ser.responsecode;
  print(responsevalue);
  isLoading = false;
  notifyListeners();   
  }
  

}
