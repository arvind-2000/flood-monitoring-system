import 'dart:async';

import 'package:floodsystem/const.dart';
import 'package:floodsystem/models/riverdetails.dart';
import 'package:floodsystem/services/services.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NambulProvider with ChangeNotifier {
  List<RiverDetails> _riverlist = [];
  List<RiverDetails> _allriverlist = [];
   List<RiverDetails> _rivergraph = [];
  // RiverDetails _riverDetails = RiverDetails(id: '', name: '', river: []);
  List<RiverDetails> get getnambulrivers => _riverlist;
  List<RiverDetails> get allrivers => _allriverlist;
   List<RiverDetails> get rivergraph => _rivergraph;
  bool isLoading = true;
  bool isLoadingall = true;
  int responsevalue = 0;
  int responsevalue2 = 0;
  get http => null;
  bool isSaved = false;
  List<bool> floodindicator = [];
  dynamic _scheduler;
  double _threshold = 60;
  int indexval = 3;

  Future<SharedPreferences> prefs = SharedPreferences.getInstance();

  double get getThreshold => _threshold;

  
  
  
  //get data
  Future<void> getdata() async {
    List<RiverDetails> rivers = [];
    List<RiverDetails> riversgrap = [];
    // RiverDetails riverDetails = RiverDetails(id: '', name: '', river: []);
    Service ser = Service();
    // List<String>  apis = [];
    // for(String x in apicalls){
    //   apis.add('$x${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}-');
    // }
    await ser.getdata(apicalls).then((value) {
      rivers = value;
      responsevalue2 = ser.responsecode;
      _allriverlist = rivers;

      _rivergraph = _allriverlist;
      // print(responsevalue);
      isLoadingall = false;
      indicator();
      notifyListeners();
    });

    notifyListeners();
  }
  

  void rivergraphs(int index){
    _rivergraph = [_allriverlist[index]];
    notifyListeners();
  }


  Future<void> reconnect() async {
    // isLoading = true;
    // notifyListeners();
    await timer();
    notifyListeners();
  }

  Future<void> timer() async {
    _scheduler = Timer.periodic(Duration(seconds: 5), (timer) {
      print('In timer');
      getlatest();
    });
  }

  void destroy() {
    print('timer cancel');
    _scheduler.cancel();
  }

  Future<void> getlatest() async {
    List<RiverDetails> rivers = [];
    // isLoading = true;
    notifyListeners();
    Service ser = Service();
    await ser.getdata(apicallslatest).then((value) {
      rivers = value;
      responsevalue = ser.responsecode;

      _riverlist = rivers;
      print(responsevalue);
      isLoading = false;
      isSaved = true;
      indicator();
      notifyListeners();
    }).timeout(
      Duration(seconds: 15),
      onTimeout: () {
        isLoading = false;
        responsevalue = 2;
        print('Timeout');
        notifyListeners();
      },
    );
  }



  void indicator() {
    List<bool> floodIndicatorlist = [];
    Service ser = Service();
    for (RiverDetails d in _riverlist) {
      double value = 0.0;
      try {
        value = double.parse(d.river.last.usv);
      } catch (e) {
        print('no value for doubles');
        value = 0.0;
      }
      floodIndicatorlist.add(ser.floodIndicator(value, _threshold));
    }
    floodindicator = floodIndicatorlist;
    notifyListeners();
  }

  void getprefs() async {
    SharedPreferences s = await prefs;
    _threshold = s.getDouble('threshold') ?? 60;
    notifyListeners();
  }

  void setPrefs(double d) async {
    print("in set prefs");
    isSaved = true;
    notifyListeners();
    SharedPreferences s = await prefs;
    s.setDouble('threshold', d).then((value) {
      isSaved = false;
      notifyListeners();
    });
    getprefs();
  }
}
