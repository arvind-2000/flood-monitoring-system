import 'package:floodsystem/widgets/cards.dart';
import 'package:floodsystem/widgets/graphreportscreen.dart';
import 'package:flutter/material.dart';


import '../../const.dart';
import '../../widgets/linechart.dart';

class GraphScreen extends StatefulWidget {
  const GraphScreen({super.key});

  @override
  State<GraphScreen> createState() => _GraphScreenState();
}

class _GraphScreenState extends State<GraphScreen> {
     int isSensor = 0;
  @override
  Widget build(BuildContext context) {
 

    

    return CardsContainer(
      // margins: EdgeInsets.all(regularpadding),
      cardcolor: Colors.transparent,
      childs: Column(
        children: [
          Expanded(
              flex: 5,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(regularpadding),
                margin: EdgeInsets.all(regularpadding),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(radius)
                ),
                child: Column(
                  children: [

                    Expanded(
                      flex: 3,
                      child: Container(
                        
                        // padding: EdgeInsets.only(right: regularpadding,top: regularpadding,bottom: regularpadding),
                        child: LineCharts(isPinching: false,showcolorindicator: true,chooseSensor: isSensor,),
                      ),
                    ),
                   Expanded(child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                     children: sensorslist.asMap().entries.map((e) => InkWell(
                      onTap: (){
                        setState(() {
                          isSensor = e.key;
                        });
                      },
                      child: CardsContainer(childs: Text(e.value,style: TextStyle(fontWeight: FontWeight.bold),), cardcolor: Theme.of(context).colorScheme.onSecondary.withOpacity(0.3),paddings: EdgeInsets.all(8),margins: EdgeInsets.all(8),isBorder:e.key==isSensor,)),).toList(),
                   ))
                  ],
                ),
              )),
          GraphScreenReport()
        ],
      ),
    );
  }
}



