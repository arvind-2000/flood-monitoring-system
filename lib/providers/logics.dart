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

    if(rs.river.length>1){

        temp = toDouble(rs.river.reversed.toList()[0].usv) - toDouble(rs.river.reversed.toList()[1].usv);
        
    }else{
        temp = 0;
    }
      log("Prediction: $temp   ${toDouble(rs.river.last.usv)}");
      res = toDouble(rs.river.last.usv) + temp;

    // double mean = res/len + res;
    River riverpred = River(id: '', channelid: '', name: rs.name, usv: res.toStringAsFixed(2), hv: '', tv: '', date: DateTime.now());
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
      tempo.sort((a, b) =>a.date.compareTo(b.date) );
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
  tempo.sort((a, b) =>a.date.compareTo(b.date) );
      riv.add(RiverDetails(id: i.id, name: i.name, river: tempo));
  }

    print(riverdetails.length);
    return riv;


 }
  List<RiverDetails> filterInDays(List<RiverDetails> riverdetails){
    List<RiverDetails> filterriver = [];
      
    for(RiverDetails riv in riverdetails){
        riv.river.sort((a,b)=>b.date.compareTo(a.date));
        List<River> riverlist = [];
        riverlist.add(riv.river.first);
        River tempriver =  riv.river.first;
        for(River i in riv.river){
            if(i.date!=tempriver.date){
              tempriver = i;
              riverlist.add(i);
            }
        }
        print("Logic : In filter days:${riverlist.length}");
        filterriver.add(RiverDetails(id: riv.id, name: riv.name, river: riverlist));
    }
    return filterriver;
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
  tempo.sort((a, b) =>a.date.compareTo(b.date) );
      riv.add(RiverDetails(id: i.id, name: i.name, river: tempo));
  }

    print(riverdetails.length);
    return riv;


 }

}
