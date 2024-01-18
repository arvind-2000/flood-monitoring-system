

import 'dart:developer';

import 'package:fl_chart/fl_chart.dart';
import 'package:floodsystem/const.dart';
import 'package:floodsystem/models/river.dart';
import 'package:floodsystem/models/riverdetails.dart';
import 'package:floodsystem/providers/riverprovider.dart';
import 'package:floodsystem/widgets/cards.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/retry.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../providers/imphalriverprovider.dart';
import '../services/services.dart';

class LineCharts extends StatelessWidget {
LineCharts({
    super.key,
    required this.isPinching,
    required this.showcolorindicator,
    required this.chooseSensor,
    this.index = 0,
  });
  final int index;
  final bool isPinching;
  final bool showcolorindicator;
  final int chooseSensor;
//  final List<River> data = [
//     River(id: '337', channelid:'vhsj', name: 'imphal River', usv: '200', hv: '0', tv: '34', date: DateTime(2024,1,12)),
//     River(id: '335', channelid:'vhsj', name: 'imphal River', usv: '202', hv: '1', tv: '34', date: DateTime(2024,2,12)),
//     River(id: '337', channelid:'vhsj', name: 'imphal River', usv: '210', hv: '2', tv: '34', date: DateTime(2024,3,12)),
//     River(id: '337', channelid:'vhsj', name: 'imphal River', usv: '215', hv: '3', tv: '34', date: DateTime(2024,4,12)),
//      River(id: '337', channelid:'vhsj', name: 'imphal River', usv: '200', hv: '4', tv: '34', date: DateTime(2024,5,12)),
//     River(id: '335', channelid:'vhsj', name: 'imphal River', usv: '215', hv: '5', tv: '34', date: DateTime(2024,6,12)),
//     River(id: '337', channelid:'vhsj', name: 'imphal River', usv: '220', hv: '6', tv: '34', date: DateTime(2024,7,12)),
//     River(id: '337', channelid:'vhsj', name: 'imphal River', usv: '225', hv: '7', tv: '34', date:DateTime(2024,8,12)),
//      River(id: '337', channelid:'vhsj', name: 'imphal River', usv: '230', hv: '8', tv: '34', date:DateTime(2024,9,12)),
//     River(id: '335', channelid:'vhsj', name: 'imphal River', usv: '220', hv: '9', tv: '34', date:DateTime(2024,10,12)),
//     River(id: '337', channelid:'vhsj', name: 'imphal River', usv: '215', hv: '10', tv: '34', date: DateTime(2024,11,12)),
//     River(id: '337', channelid:'vhsj', name: 'imphal River', usv: '220', hv: '11', tv: '34', date: DateTime(2024,12,12)),
//   ];

//   final RiverDetails riverss = RiverDetails(id: '34637', name: 'Imphal River', river: [
//     River(id: '337', channelid:'vhsj', name: 'imphal River', usv: '200', hv: '0', tv: '34', date: DateTime(2024,1,12)),
//     River(id: '335', channelid:'vhsj', name: 'imphal River', usv: '202', hv: '1', tv: '34', date: DateTime(2024,2,12)),
//     River(id: '337', channelid:'vhsj', name: 'imphal River', usv: '210', hv: '2', tv: '34', date: DateTime(2024,3,12)),
//     River(id: '337', channelid:'vhsj', name: 'imphal River', usv: '215', hv: '3', tv: '34', date: DateTime(2024,4,12)),
//      River(id: '337', channelid:'vhsj', name: 'imphal River', usv: '200', hv: '4', tv: '34', date: DateTime(2024,5,12)),
//     River(id: '335', channelid:'vhsj', name: 'imphal River', usv: '215', hv: '5', tv: '34', date: DateTime(2024,6,12)),
//     River(id: '337', channelid:'vhsj', name: 'imphal River', usv: '220', hv: '6', tv: '34', date: DateTime(2024,7,12)),
//     River(id: '337', channelid:'vhsj', name: 'imphal River', usv: '225', hv: '7', tv: '34', date:DateTime(2024,8,12)),
//      River(id: '337', channelid:'vhsj', name: 'imphal River', usv: '230', hv: '8', tv: '34', date:DateTime(2024,9,12)),
//     River(id: '335', channelid:'vhsj', name: 'imphal River', usv: '220', hv: '9', tv: '34', date:DateTime(2024,10,12)),
//     River(id: '337', channelid:'vhsj', name: 'imphal River', usv: '215', hv: '10', tv: '34', date: DateTime(2024,11,12)),
//     River(id: '337', channelid:'vhsj', name: 'imphal River', usv: '220', hv: '11', tv: '34', date: DateTime(2024,12,12)),
//   ]);
  @override
  Widget build(BuildContext context) {
    
    final prov = Provider.of<NambulProvider>(context);
    return Stack(
      children: [
        SfCartesianChart(
          
          margin: EdgeInsets.all(0),
          zoomPanBehavior:ZoomPanBehavior(enablePinching: isPinching,
          zoomMode: ZoomMode.x
          ),
          enableAxisAnimation: true,
          plotAreaBorderColor: Colors.transparent,
          borderColor: Colors.transparent,
          borderWidth: 0,
            plotAreaBorderWidth: 0,
           
           primaryXAxis:DateTimeAxis(
            minimum: prov.rivergraph[index].river.first.date,
              maximum: prov.rivergraph[index].river.last.date,
        
              intervalType: DateTimeIntervalType.milliseconds,
          ),
          primaryYAxis: NumericAxis(
            minimum: 0,
            maximum:600,
              isVisible: true,
              desiredIntervals: 5,
              borderWidth: 0,
               borderColor: Colors.transparent,
          ),
        
          series:prov.rivergraph.asMap().entries.map((e) => linecharts(e.value,e.key)).toList(),
            
        ),

       showcolorindicator?Positioned(
        right: 0,
         child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             CardsContainer(
              paddings: EdgeInsets.all(8),
              childs:prov.rivergraph.isEmpty?SizedBox():Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: prov.rivergraph.asMap().entries.map((e) => Row(
              children: [
                FaIcon(FontAwesomeIcons.circleDot,color: rivercolors[e.key],size: 10,),
                SizedBox(width: 10,),
                Text(e.value.name.split(' ')[0],style: TextStyle(color: Theme.of(context).colorScheme.surface),)],
             ),
             ).toList(),), cardcolor: Theme.of(context).colorScheme.onSecondary.withOpacity(0.3)),
              SizedBox(width: 10,),
             FaIcon(FontAwesomeIcons.upRightAndDownLeftFromCenter,size: 20,color: Theme.of(context).colorScheme.secondary,)
           ],
         ),
       ):SizedBox(),
      ],
    );
  }

  SplineAreaSeries<River, DateTime> linecharts(RiverDetails riversdata,int index) {
    return SplineAreaSeries(
      animationDelay:1,
      animationDuration: 0.3,
    
      enableTooltip: true,
        borderColor: rivercolors[index]!,
        borderWidth: 0.5,
        splineType: SplineType.natural,
        gradient: LinearGradient(colors: [rivercolors[index]!,Colors.white],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter
        ),
        dataSource: riversdata.river,
        xValueMapper: (datum, index){
            return datum.date;
        }, yValueMapper: (d,i)=>toDouble(chooseSensor==0?d.usv:chooseSensor==1?d.hv:d.tv));
  }
}

