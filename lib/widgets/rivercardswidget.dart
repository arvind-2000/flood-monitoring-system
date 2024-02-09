import 'package:floodsystem/const.dart';
import 'package:floodsystem/models/riverdetails.dart';
import 'package:flutter/material.dart';

import '../models/river.dart';

class RiversCardDesktop extends StatelessWidget {
  const RiversCardDesktop({
    super.key,
    required this.riverdetails
  });
  final RiverDetails riverdetails;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8,horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Theme.of(context).colorScheme.primary
      

      ),

      child: Row(
        children: [
          Expanded(
            child: Container(
       
              child:Stack(
                children: [
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      margin: EdgeInsets.all(16),
                      width: 100,
                      height: 100,
                      decoration:const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.green
                      ),
                    ),
                  ),
            
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(riverdetails.name),
                      const SizedBox(height: 20,),
                      Row(
                    
                        children: [
                          Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("level",style: TextStyle(fontSize: 14),),
                              Text('${toDouble(riverdetails.river.last.usv).toStringAsFixed(0)} $levelunit',),
                            ],
                          ),
                          SizedBox(width: 20,),
                          Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Humidity",style: TextStyle(fontSize: 14),),
                               Text('${toDouble(riverdetails.river.last.hv).toStringAsFixed(0)} $humiditylevel'),
                            ],
                          ),
                            SizedBox(width: 20,),
                          Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Temp",style: TextStyle(fontSize: 14),),
                               Text('${toDouble(riverdetails.river.last.tv).toStringAsFixed(0)} $templevel'),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ) ,
            ),
          ),
       
        ],
      ),
    );
  }
}
