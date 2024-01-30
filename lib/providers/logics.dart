import 'dart:developer';
import 'package:floodsystem/const.dart';
import 'package:floodsystem/models/riverdetails.dart';
import 'package:floodsystem/providers/irilprovider.dart';

import '../models/river.dart';

class Logics{

  RiverDetails latest({required RiverDetails rivers,required int intervals}){
    final RiverDetails riverinfo = RiverDetails(id:  rivers.id, name: rivers.name, river: rivers.river);

    //logic here
    for(River i in riverinfo.river){
       try{
        // DateTime d = DateTime.parse(i.date);
      //  if()
        

       } on Exception catch(e){
        log('unable to parse the date value');
       }
    }

    return riverinfo;

  }
  RiverDetails monthly({required RiverDetails rivers}){
    final RiverDetails riverinfo = RiverDetails(id:  rivers.id, name: rivers.name, river: rivers.river);

    //logic here
    

    return riverinfo;

  }

  

  Map<String,dynamic> getHighLow(RiverDetails r){
    final Map<String,dynamic>  d = {};
    //logic here
    return d;
  }


 List<River> predictions(List<RiverDetails> r){
  List<River> prediction = [];

    for(RiverDetails rs in r)
  {
    double temp = 0;
    double res = 0;
    int len = r.length>10?10:r.length;
    for (River r in rs.river.reversed.take(len).toList().reversed){
        temp = toDouble(r.usv) - temp;
        res = temp+res;
    
    }
  
    double mean = res/len + res;
    River riverpred = River(id: '', channelid: '', name: rs.name, usv: mean.toStringAsFixed(2), hv: '', tv: '', date: DateTime.now());
    prediction.add(riverpred);
  }
  return prediction;

 }

 List<RiverDetails> getYear(List<RiverDetails> riverdetails){
  List<RiverDetails> riv = [];
  

  for(RiverDetails i in riverdetails){
     int temp = 0;
    List<River> tempo = [];
    i.river.sort((a,b)=>b.date.compareTo(a.date));
    tempo.add(i.river.first);
    temp = i.river.first.date.year;
    for(River k in i.river){
      if(k.date.year != temp){
        tempo.add(k);
        temp = k.date.year;
      }
    }

      riv.add(RiverDetails(id: i.id, name: i.name, river: tempo));
  }

    print(riverdetails.length);
    return riv;


 }


 List<RiverDetails> getMonths(List<RiverDetails> riverdetails,DateTime dates){
  List<RiverDetails> riv = [];
  

  for(RiverDetails i in riverdetails){
     int temp = 0;
    
    List<River> tempo = [];
    i.river.sort((a,b)=>b.date.compareTo(a.date));

    for(River k in i.river){

      if(k.date.year == dates.year){
       
        if(k.date.month!=temp){
        temp = k.date.month;
        tempo.add(k);
        print('found');
        }
      
        }
    }

      riv.add(RiverDetails(id: i.id, name: i.name, river: tempo));
  }

    print(riverdetails.length);
    return riv;


 }

 List<RiverDetails> getDays(List<RiverDetails> riverdetails,DateTime dates){
  List<RiverDetails> riv = [];
  

  for(RiverDetails i in riverdetails){
     int temp = 0;
    
    List<River> tempo = [];
    i.river.sort((a,b)=>b.date.compareTo(a.date));

    for(River k in i.river){

      if(k.date.year == dates.year && k.date.month==dates.month){
       
        if(k.date.day!=temp){
        temp = k.date.day;
        tempo.add(k);
        print('found');
        }
      
        }
    }

      riv.add(RiverDetails(id: i.id, name: i.name, river: tempo));
  }

    print(riverdetails.length);
    return riv;


 }

}
