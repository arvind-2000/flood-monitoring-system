import 'package:fl_chart/fl_chart.dart';
import 'package:floodsystem/const.dart';
import 'package:floodsystem/models/river.dart';
import 'package:floodsystem/models/riverdetails.dart';
import 'package:floodsystem/providers/riverprovider.dart';
import 'package:floodsystem/widgets/cards.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../providers/imphalriverprovider.dart';
import '../services/services.dart';

class LineCharts extends StatelessWidget {
LineCharts({
    super.key,
    required this.isPinching,
    required this.showcolorindicator,
    
  });
  final bool isPinching;
  final bool showcolorindicator;

 final List<River> data = [
    River(id: '337', channelid:'vhsj', name: 'imphal River', usv: '200', hv: '0', tv: '34', date: '2024'),
    River(id: '335', channelid:'vhsj', name: 'imphal River', usv: '202', hv: '1', tv: '34', date: '2024'),
    River(id: '337', channelid:'vhsj', name: 'imphal River', usv: '210', hv: '2', tv: '34', date: '2024'),
    River(id: '337', channelid:'vhsj', name: 'imphal River', usv: '215', hv: '3', tv: '34', date: '2024'),
     River(id: '337', channelid:'vhsj', name: 'imphal River', usv: '200', hv: '4', tv: '34', date: '2024'),
    River(id: '335', channelid:'vhsj', name: 'imphal River', usv: '215', hv: '5', tv: '34', date: '2024'),
    River(id: '337', channelid:'vhsj', name: 'imphal River', usv: '220', hv: '6', tv: '34', date: '2024'),
    River(id: '337', channelid:'vhsj', name: 'imphal River', usv: '225', hv: '7', tv: '34', date: '2024'),
     River(id: '337', channelid:'vhsj', name: 'imphal River', usv: '230', hv: '8', tv: '34', date: '2024'),
    River(id: '335', channelid:'vhsj', name: 'imphal River', usv: '220', hv: '9', tv: '34', date: '2024'),
    River(id: '337', channelid:'vhsj', name: 'imphal River', usv: '215', hv: '10', tv: '34', date: '2024'),
    River(id: '337', channelid:'vhsj', name: 'imphal River', usv: '220', hv: '11', tv: '34', date: '2024'),
  ];
  @override
  Widget build(BuildContext context) {
      Service ser = Service();
    final prov = Provider.of<NambulProvider>(context);
    return Stack(
      children: [
        SfCartesianChart(
          margin: EdgeInsets.all(0),
          zoomPanBehavior:ZoomPanBehavior(enablePinching: isPinching,
          zoomMode: ZoomMode.x
          ),
          
          plotAreaBorderColor: Colors.transparent,
          borderColor: Colors.transparent,
          borderWidth: 0,
            plotAreaBorderWidth: 0,
            
          primaryXAxis: NumericAxis(
            minimum: 0,
            maximum: prov.getnambulrivers[0].river.length.toDouble(),
            isVisible: true,
            
            borderWidth: 0,
            borderColor: Colors.transparent,
            
          ),
          primaryYAxis: NumericAxis(
            minimum: 0,
            maximum: 300,
              isVisible: true,
              desiredIntervals: 5,
              borderWidth: 0,
               borderColor: Colors.transparent,
          ),
        
          series:prov.getnambulrivers.asMap().entries.map((e) => linecharts(e.value, e.key)).toList(),
            
        ),

       showcolorindicator?Positioned(
        right: 0,
         child: CardsContainer(childs:prov.getnambulrivers.isEmpty?SizedBox():Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: prov.getnambulrivers.asMap().entries.map((e) => Row(
          children: [
            FaIcon(FontAwesomeIcons.circleDot,color: rivercolors[e.key],size: 10,),
            SizedBox(width: 10,),
            Text(e.value.name.split(' ')[0])],
         ),
         ).toList(),), cardcolor: cardcolor.withOpacity(0.4)),
       ):SizedBox(),
      ],
    );
  }

  SplineAreaSeries<River, int> linecharts(RiverDetails riversdata,int index) {
    return SplineAreaSeries(
      animationDelay: 0.2,
      enableTooltip: true,
        borderColor: normalColor,
        borderWidth: 0.5,
        splineType: SplineType.natural,
        gradient: LinearGradient(colors: [rivercolors[index]!,Colors.white],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter
        ),
        dataSource: riversdata.river.sublist(0,10),
        xValueMapper: (datum, index) => index, yValueMapper: (d,i)=>toDouble(d.usv));
  }
}

