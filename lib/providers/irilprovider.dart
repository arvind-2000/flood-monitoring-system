
import 'package:floodsystem/const.dart';
import 'package:floodsystem/services/services.dart';
import 'package:flutter/material.dart';

import '../models/river.dart';
import '../models/riverdetails.dart';

class IrilRiverProvider with ChangeNotifier {
 RiverDetails _irilriverlist = RiverDetails(id: '', name: '', river: []);
  RiverDetails get getallirilrivers => _irilriverlist;
  bool isLoading = true;
  int responsevalue = 0;
  get http => null;
  bool floodindicator = false;

  // Future<void> getdata() async{
  
  // Service ser = Service();
  // // RiverDetails datas = await ser.getdata(irilriver);
  // _irilriverlist = datas;
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
      value = double.parse(_irilriverlist.river.last.hv);
    }
    catch(e){
      print('no value for doubles');
      value = 0.0;
    }
    floodindicator =  ser.floodIndicator(value,threshold);
    notifyListeners();
  }

}
