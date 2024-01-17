
import 'dart:async';

import 'package:floodsystem/const.dart';
import 'package:floodsystem/models/riverdetails.dart';
import 'package:floodsystem/services/services.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';



class NambulProvider with ChangeNotifier {
  List<RiverDetails> _riverlist = [];
  // RiverDetails _riverDetails = RiverDetails(id: '', name: '', river: []);
  List<RiverDetails> get getnambulrivers => _riverlist;
  bool isLoading = true;
  int responsevalue = 0;
  get http => null;
  bool isSaved = false;
  List<bool> floodindicator = [];
  dynamic _scheduler;
  double _threshold = 60;

  Future<SharedPreferences> prefs = SharedPreferences.getInstance();

  double get getThreshold=>_threshold;

  Future<void> getdata() async{
  List<RiverDetails>  rivers = [];
  // RiverDetails riverDetails = RiverDetails(id: '', name: '', river: []);
  Service ser = Service();



  await ser.getdata(apicalls).then((value){
    rivers = value;
  responsevalue = ser.responsecode;
  _riverlist = rivers;
  print(responsevalue);
  isLoading = false;
  indicator();
  notifyListeners();
  }).timeout(Duration(seconds: 15),onTimeout: (){

    isLoading = false;
    responsevalue = 2;
    print('Timeout');
    notifyListeners();
  },);



 
  notifyListeners();   
  }

  Future<void> reconnect ()async{
    // isLoading = true;
    // notifyListeners();
    await timer();
    notifyListeners();
  }

  Future<void> timer() async{
    _scheduler = Timer.periodic(Duration(seconds: 5), (timer) { 
      print('In timer');
      getlatest();
    });

  }

void destroy(){
  print('timer cancel');
  _scheduler.cancel();
}


  Future<void> getlatest() async{
    List<RiverDetails>  rivers = [];
    // isLoading = true;
    notifyListeners();
    Service ser = Service();
    await ser.getdata(apicallslatest).then((value){   
     rivers = value;
  responsevalue = ser.responsecode;
  
  _riverlist = rivers;
  print(responsevalue);
  isLoading = false;
  indicator();
  notifyListeners();
  
  }).timeout(Duration(seconds: 15),onTimeout: (){

    isLoading = false;
    responsevalue = 2;
    print('Timeout');
    notifyListeners();
  },);

  
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

void getprefs()async{
 SharedPreferences s = await prefs;
_threshold = s.getDouble('threshold')??60;
notifyListeners();
}


void setPrefs(double d) async{
  print("in set prefs");
  isSaved = true;
  notifyListeners();
 SharedPreferences s = await prefs;
s.setDouble('threshold', d).then((value){
  isSaved = false;
    notifyListeners();
});
  getprefs();

}


}
