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
  notifyListeners();   
  }

}
