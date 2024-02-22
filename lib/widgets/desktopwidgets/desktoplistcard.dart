import 'package:floodsystem/screens/desktop/bargraphsceen.dart';
import 'package:flutter/material.dart';

import '../../models/riverdetails.dart';
import '../cards.dart';
import 'desktoplinechart.dart';

class DesktopCardHolder extends StatelessWidget {
  DesktopCardHolder({
    super.key,
    required this.riverDetails,
  });

  final RiverDetails riverDetails;
  @override
  Widget build(BuildContext context) {
    return Expanded(child: CardsContainer(
      margins: EdgeInsets.all(16),
      paddings: EdgeInsets.all(16),
      childs: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(riverDetails.name,style: TextStyle(color: Theme.of(context).colorScheme.surface,fontSize: 16),),
                const SizedBox(height: 10,),
          
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CardsContainer(
                      paddings: EdgeInsets.all(8),
                      childs: Column(
                        children: [
                          Text('Level',style: TextStyle(fontSize: 12),),
                          Text(riverDetails.river.last.usv),
                        ],
                      ),cardcolor: Theme.of(context).colorScheme.secondary.withOpacity(0.3),),
                      SizedBox(width: 10,),
                       CardsContainer(
                      paddings: EdgeInsets.all(8),
                      childs: Column(
                        children: [
                          Text('Humidity',style: TextStyle(fontSize: 12),),
                          Text(riverDetails.river.last.usv),
                        ],
                      ),cardcolor: Theme.of(context).colorScheme.secondary.withOpacity(0.3),),
                           SizedBox(width: 10,),
                       CardsContainer(
                      paddings: EdgeInsets.all(8),
                      childs: Column(
                        children: [
                          Text('temp',style: TextStyle(fontSize: 12),),
                          Text(riverDetails.river.last.usv),
                        ],
                      ),cardcolor: Theme.of(context).colorScheme.secondary.withOpacity(0.3),),
                  ],
                )
          
              ],
          

          ),



       Expanded(child:BarGraphDesktopScreen(riverdetails:[riverDetails]))


        
        ],
      ), cardcolor: Theme.of(context).colorScheme.primary));
  }
}