import 'package:flutter/material.dart';

import '../const.dart';
import '../providers/riverprovider.dart';
import 'cards.dart';

class Tables extends StatelessWidget {
  const Tables({
    super.key,
    required this.prov2,
    required this.args,
    required ScrollController listcontroller,
  }) : _listcontroller = listcontroller;

  final NambulProvider prov2;
  final int args;
  final ScrollController _listcontroller;

  @override
  Widget build(BuildContext context) {
    return CardsContainer(
      cardcolor: Theme.of(context).colorScheme.primary.withOpacity(0.5),
      
      childs: Column(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Text("Date/time",textAlign: TextAlign.center,)),
                Expanded(child: Text("Water\nLevel",textAlign: TextAlign.center,)),
                Expanded(child: Text("humidity",textAlign: TextAlign.center,)),
                Expanded(child: Text("Temp",textAlign: TextAlign.center,)),
              ],
            ),
          ),
            prov2.isLoadingall? Center(child: CircularProgressIndicator(color: Theme.of(context).colorScheme.secondary,)):args>=prov2.rivergraph.length?SizedBox():ListView(
              controller:_listcontroller,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: prov2.allrivers[args].river.asMap().entries.map((e) => Container(
            
                padding: EdgeInsets.all(8),
                child:Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center ,
                    
                    children: [
                      Text('${getDate(e.value.date)}',style: TextStyle(fontSize:12,fontWeight: FontWeight.bold),),
                    
                      Text('${gethour(e.value.date)}',style: TextStyle(fontSize:12,),),
                   
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    
                    padding: EdgeInsets.all(4),
                   
                    child: Text('${e.value.usv}',textAlign: TextAlign.center,)),
                ),
                
                     Expanded(
                       child: Container(
                                           
                                           padding: EdgeInsets.all(4),
                                          
                                           child: Text('${e.value.hv}',textAlign: TextAlign.center,)),
                     ),
                  
             Expanded(
               child: Container(
                    
                    padding: EdgeInsets.all(4),
                   
                    child: Text('${e.value.tv}',textAlign: TextAlign.center,)),
             ),
                 
              ],), color:toDouble(e.value.usv)>prov2.getThreshold?Theme.of(context).colorScheme.error.withOpacity(0.2) :e.key%2==0?Theme.of(context).colorScheme.secondary.withOpacity(0.1):Theme.of(context).colorScheme.secondary.withOpacity(0.2)),).toList().sublist(0, prov2.allrivers[args].river.length>10?10:prov2.allrivers[args].river.length)
            ),
        ],
      ),
    );
  }
}