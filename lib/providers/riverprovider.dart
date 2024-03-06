import 'dart:async';
import 'dart:developer';
import 'dart:isolate';

import 'package:floodsystem/const.dart';
import 'package:floodsystem/models/riverdetails.dart';
import 'package:floodsystem/providers/logics.dart';
import 'package:floodsystem/services/services.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/river.dart';

class NambulProvider extends Logics with ChangeNotifier {
  List<RiverDetails> _riverlist = [];
  List<RiverDetails> _allriverlist = [];
  List<RiverDetails> _rivergraph = [];
  List<RiverDetails> _riverfilters = [];
  List<RiverDetails> _riverisolates = [];
  // RiverDetails _riverDetails = RiverDetails(id: '', name: '', river: []);
  List<RiverDetails> get getnambulrivers => _riverlist;
  List<RiverDetails> get allrivers => _allriverlist;
  List<RiverDetails> get rivergraph => _rivergraph;
  List<RiverDetails> get riverfilters => _riverfilters;
  bool isLoading = true;
  bool isLoadingall = true;
  int filtertype = 0;
  int _checktime = checktime;
  int responsevalue = 0;
  int responsevalue2 = 0;
  bool islinegraphs = true;

  bool predictionswitch = false;
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
  int tableFilters = 0;
  DateTime graphchooseDate = DateTime.now();
  bool isBackgroundrunning = false;

  List<RiverDetails> _tablegraph = [];
  List<RiverDetails> get tablegraph=>_tablegraph;

  int tablesensor = 0;

  bool isLinegraph = true;

  List<River> _predictions = [];
  List<River> get getPredictions => _predictions;
  bool updateFirsttime = false;
  int get durationtime=>_checktime;
  //get data
  Future<void> getdata() async {




    Service ser = Service();
    ser.getdata(apicalls).then((value) {


      responsevalue2 = ser.responsecode;

      _allriverlist =filterInDays(value);
      
      // _predictions = Logics().predictions(_allriverlist);
      
      // _predictions = Logics().predictions(_allriverlist);
      print("log: $_predictions     length of rivers: $value length of filter river: $_allriverlist");
      // rivergraphs();
      // rivergraphs();
      // print(responsevalue);
      isLoadingall = false;
      indicator();
      notifyListeners();
    });
    
    notifyListeners();
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
      // print(responsevalue);
      isLoading = false;
      isSaved = true;
      indicator();
      notifyListeners();
      if(updateFirsttime){
        updateAllRiverData();
        
      }else{
        updateFirsttime = true;
      }

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


void updateAllRiverData(){
  try {
  for(int i = 0;i<_allriverlist.length;i++){
  
    if(_allriverlist[i].river.last.date !=_riverlist[i].river.last.date){
      _allriverlist[i].river.add(_riverlist[i].river.last);
      
      notifyListeners();
      rivergraphs();
      }

  }
} on Exception catch (e) {
  log('error in updating river data');
  // TODO
}



}


  void changegraph(){
    isLinegraph = !isLinegraph;
    notifyListeners();
  }
void changeData(){


_rivergraph = getDays([_allriverlist[graphindex]],graphchooseDate)..reversed;

notifyListeners();

}


  void setfromIsolates(List<RiverDetails> r,int res){
    print('In isolate call');
    log('$res');
    if(res==1){
        responsevalue2 = res;
        log('${r.length}');
      _riverisolates = r;

      // _predictions = Logics().predictions(_allriverlist);
      // print("log: $_predictions");
     rivergraphs();
      // print(responsevalue);
      filterData(0, DateTime.now());
      settableFilter(0, DateTime.now());
      indicator();
      notifyListeners();

    }
    
      isLoadingall = false;

  }



  void setAllfromIsolates(List<RiverDetails> r,int res){
    print('in isolate all call');
    log('$res');
    if(res==1){
        responsevalue2 = res;
      
      _allriverlist = r;
      _predictions = Logics().predictions(_allriverlist);
      log('all river list: ${_allriverlist.last.river.last.usv}');
      rivergraphs();
     
      filterData(0, DateTime.now());
      settableFilter(0, DateTime.now());


      notifyListeners();
    }
          isLoadingall = false;
          notifyListeners();
  }    
  

  void setAllRiverData(List<RiverDetails> r,int res){
    log('$res');
    if(res==1){
        responsevalue2 = res;
        log('${r.length}');
      _allriverlist = r;
      
      _predictions = Logics().predictions(_allriverlist);
      // print("log: $_predictions");
      indicator();
      // print(responsevalue);
   changeData();
  filterData(0, DateTime.now());
  settableFilter(0, DateTime.now());

  notifyListeners();
    }
    
      isLoadingall = false;
            notifyListeners();
  }    

void setTableSensor(int inde){
  tablesensor = inde;
 notifyListeners();
}


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
    RiverDetails d =  RiverDetails(id: _riverisolates[graphindex].id, name: _riverisolates[graphindex].name, river: _riverisolates[graphindex].river..reversed);
    _rivergraph = [d]; 
    print("river graph: ${_rivergraph[0].name}");
    notifyListeners();
        changeData();
   
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
    getlatest();
    notifyListeners();
  }
 void errorreconnect() {
    isLoading = true;
    notifyListeners();
    getlatest();
    notifyListeners();
  }
  Future<void> timer() async {
    _scheduler = Timer.periodic(Duration(seconds: _checktime), (timer) {
      print('In timer: $_checktime');
      getlatest();
    //  isolatesRun();
    });
    notifyListeners();
  }

  void destroy() {
    print('timer cancel');
    _scheduler.cancel();
    notifyListeners();
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
  
    int getindexs(List<RiverDetails> des) {
    int ind = 0;
    int great= 0;
     for(int i = 0;i<des.length;i++){
          

          if(des[i].river.length>great){
            great = des[i].river.length;
            ind = i;
        }
     }  
    // print("index of:${des[ind].name}");
    return ind;
  }

  void settableFilter(int f,DateTime d){
    tableFilters = f;
    notifyListeners();  
    tableFiltersFunc(d);
  }


  void tableFiltersFunc(DateTime d){
    graphchooseDate = d;
      if(tableFilters==0){
          _tablegraph =  getYear(allrivers);
      }
      else if(tableFilters == 1){
        _tablegraph =  getMonths(allrivers,d);
      }else if(tableFilters == 2){

          _tablegraph = getDays(allrivers,d);
      }

    notifyListeners();
  }


  void setgraphdate(DateTime d){
    graphchooseDate = d;
    
    notifyListeners();
    changeData();
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
    isBackgroundrunning = s.getBool('background') ?? false;
    _checktime = s.getInt('checktime') ?? checktime;
    predictionswitch = s.getBool('prediction') ?? false;
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
  void setPrefsbackground(bool f) async {
    //setting threshold in local database
    print("in set prefs");

    notifyListeners();
    SharedPreferences s = await prefs;
    s.setBool('background', f).then((value) {
    
      notifyListeners();
    });
    getprefs();
  }
  


  void setPrefschecktime(int checktimes) async {
    //setting threshold in local database
    print("in set prefs");

    notifyListeners();
    SharedPreferences s = await prefs;
    s.setInt('checktime', checktimes).then((value) {
    
      notifyListeners();
    });
    getprefs();
    destroy();
    timer();
  }

  void resetdate(){
    graphchooseDate = DateTime.now();
    notifyListeners();
  }

  String day(){
    if(tableFilters == 0){
      return "Year";
    }
    else if(tableFilters==1){
      return "Months";
    }
    else{
      return "Days";
    }

  }



}

