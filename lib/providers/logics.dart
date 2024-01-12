

import 'dart:developer';

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


}
