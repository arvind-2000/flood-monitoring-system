import 'dart:async';

import 'package:floodsystem/const.dart';
import 'package:floodsystem/models/riverdetails.dart';
import 'package:floodsystem/providers/logics.dart';
import 'package:floodsystem/services/services.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/river.dart';

class NambulProvider with ChangeNotifier {
  List<RiverDetails> _riverlist = [];
  List<RiverDetails> _allriverlist = [];
  List<RiverDetails> _rivergraph = [];
  List<RiverDetails> _riverfilters = [];
  // RiverDetails _riverDetails = RiverDetails(id: '', name: '', river: []);
  List<RiverDetails> get getnambulrivers => _riverlist;
  List<RiverDetails> get allrivers => _allriverlist;
  List<RiverDetails> get rivergraph => _rivergraph;
  List<RiverDetails> get riverfilters => _riverfilters;
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
  bool isFilterLoading = true;
  Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  bool setgraph = false;
  double get getThreshold => _threshold;
  int graphindex = 0;
  int isSensor = 0;

  // DateTime graphChooseDate = DateTime.now();

  List<River> _predictions = [];
  List<River> get getPredictions => _predictions;
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
      _predictions = Logics().predictions(_allriverlist);
      print("log: $_predictions");
      rivergraphs();
      // print(responsevalue);
      isLoadingall = false;
      indicator();
      notifyListeners();
    });

    notifyListeners();
  }

  // void graphChooseDates(DateTime d) {
  //   graphChooseDate = d;
  //   notifyListeners();
  //   monthyear(d);
  // }

  void setgraphindex(int index) {
    graphindex = index;
    
    notifyListeners();
    rivergraphs();
  }

  void rivergraphs() {
   
    // _rivergraph = _rivergraph.map((e) => R\iverDetails(id: e.id, name: e.name, river: e.river.where((element) => element.date.year==d.year && element.date.month==d.month).toList()..sort((a,b)=>a.date.compareTo(b.date)))).toList();
    // graphChooseDates(graphChooseDate);
     print("index: $graphindex");
    // RiverDetails d =  RiverDetails(id: _allriverlist[graphindex].id, name: _allriverlist[graphindex].name, river: _allriverlist[graphindex].river.reversed.take(_allriverlist[graphindex].river.length>20?20:_allriverlist[graphindex].river.length).toList().reversed.toList());
    RiverDetails d =  RiverDetails(id: _allriverlist[graphindex].id, name: _allriverlist[graphindex].name, river: _allriverlist[graphindex].river);
    _rivergraph = [d];
    print("river graph: ${_rivergraph[0].river.length}");
    notifyListeners();
  }

  void monthyear(DateTime d) {
    _rivergraph = [
      RiverDetails(
          id: allrivers[graphindex].id,
          name: allrivers[graphindex].name,
          river: allrivers[graphindex]
              .river
              .where((element) =>
                  element.date.year == d.year && element.date.month == d.month)
              .toList())
    ];

      notifyListeners();
  }

  void changesensor(int val) {
    isSensor = val;
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
      getdata();
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

  void filterData(int choose, DateTime date) {
    if (choose == 0) {
      _riverfilters = allrivers
          .map((e) => RiverDetails(
              id: e.id,
              name: e.name,
              river: e.river
                  .where((element) => element.date.year == date.year)
                  .toList()))
          .toList();
      isFilterLoading = false;
      notifyListeners();
    }
  }

  void setgraphd() {
    setgraph = !setgraph;
    notifyListeners();
  }

  int getindex() {
    int i = 0;
    _riverfilters.map((e) {
      if (e.river.length > i) {
        i = e.river.length;
      }
    });
    return i;
  }

  void sort() {
    _riverfilters = _riverfilters
        .map((e) => RiverDetails(
              id: e.id,
              name: e.name,
              river: e.river.toList()
                ..sort((a, b) => toDouble(a.usv).compareTo(toDouble(b.usv))),
            ))
        .toList();
    notifyListeners();
  }


  void getprefs() async {
    //getting sharedpreferences threshold values
    SharedPreferences s = await prefs;
    _threshold = s.getDouble('threshold') ?? 60;
    notifyListeners();
  }



  void setPrefs(double d) async {
    //setting threshold in local database
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
