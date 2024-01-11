import 'package:fl_chart/fl_chart.dart';
import 'package:floodsystem/providers/imphalriverprovider.dart';
import 'package:floodsystem/services/services.dart';
import 'package:floodsystem/widgets/cards.dart';
import 'package:floodsystem/widgets/graphreportscreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../const.dart';
import '../../widgets/linechart.dart';

class GraphScreen extends StatelessWidget {
  const GraphScreen({super.key});

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
                decoration: carddecoration,
                child: Column(
                  children: [

                    Expanded(
                      flex: 3,
                      child: Container(
                        // padding: EdgeInsets.only(right: regularpadding,top: regularpadding,bottom: regularpadding),
                        child: LineCharts(isPinching: false,showcolorindicator: true),
                      ),
                    ),
                   Expanded(child: Row(
                     children: [
                       CardsContainer(childs: Text('new',style: TextStyle(fontWeight: FontWeight.bold),), cardcolor: normalColor.withOpacity(0.6),paddings: EdgeInsets.all(8),margins: EdgeInsets.all(8),),
                       CardsContainer(childs: Text('1D',style: TextStyle(fontWeight: FontWeight.bold),), cardcolor: normalColor.withOpacity(0.6),paddings: EdgeInsets.all(8),margins: EdgeInsets.all(8),),
                       CardsContainer(childs: Text('1M',style: TextStyle(fontWeight: FontWeight.bold),), cardcolor: normalColor.withOpacity(0.6),paddings: EdgeInsets.all(8),margins: EdgeInsets.all(8),),
                       CardsContainer(childs: Text('1Y',style: TextStyle(fontWeight: FontWeight.bold),), cardcolor: normalColor.withOpacity(0.6),paddings: EdgeInsets.all(8),margins: EdgeInsets.all(8),),
                     ],
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



