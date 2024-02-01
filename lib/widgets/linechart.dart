import 'package:fl_chart/fl_chart.dart';
import 'package:floodsystem/const.dart';
import 'package:floodsystem/models/river.dart';
import 'package:floodsystem/models/riverdetails.dart';
import 'package:floodsystem/providers/riverprovider.dart';

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';



class LineCharts extends StatelessWidget {
  LineCharts({
    super.key,
    required this.isPinching,
    required this.showcolorindicator,
    this.index = 0,
  });
  final int index;
  final bool isPinching;
  final bool showcolorindicator;

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<NambulProvider>(context);
    return Stack(
      children: [
      prov.rivergraph[0].river.isEmpty?const SizedBox(
        child: Center(child: Text('No Data'),),
       ):SfCartesianChart(
          zoomPanBehavior: ZoomPanBehavior(

            enableMouseWheelZooming: true,
            enablePanning: true,
            
            // maximumZoomLevel: 1,  
            // enablePinching: true,
         
            zoomMode: ZoomMode.x,
            enableSelectionZooming: true

          ),

          borderWidth: 0,
          borderColor: Colors.transparent,
          margin: EdgeInsets.zero,
          plotAreaBorderColor: Colors.transparent,
          plotAreaBorderWidth: 0,
          title: ChartTitle(
            text: prov.rivergraph[0].name,
            alignment: ChartAlignment.near,
            borderWidth: 8
          ),
          enableAxisAnimation: true,
          isTransposed: prov.setgraph,
          primaryYAxis: NumericAxis(
            maximum:400,
          ),
        primaryXAxis: DateTimeAxis(
                initialVisibleMinimum: DateTime(DateTime.now().year,DateTime.now().month,1),
                interval:10,
                dateFormat: DateFormat('d-m-y'),
                 
                autoScrollingMode: AutoScrollingMode.end,
                autoScrollingDelta: 20,
                autoScrollingDeltaType: DateTimeIntervalType.hours,
          initialZoomPosition: 1,
          initialZoomFactor: 0.5,
         
          
                
        ),
        series: prov.rivergraph.asMap().entries.map((e) => linecharts(e.value, e.key,Theme.of(context).colorScheme.secondary,prov)).toList(),
       ),
      //  LineChart(
      //     LineChartData(
      //           maxY: 300,
      //           minY: 0,
      //             extraLinesData: ExtraLinesData(horizontalLines: [
      //               HorizontalLine(
      //                   y: prov.getThreshold,
      //                   color: Theme.of(context).colorScheme.error,
      //                   strokeWidth:prov.isSensor==0?1:0 )
      //             ]),

      //                        gridData: FlGridData(show: false),
      //             borderData: FlBorderData(show: false),
      //             backgroundColor: Theme.of(context).colorScheme.primary,
                     
      //                   titlesData: FlTitlesData(
      //               show: true,
              
      //               rightTitles:
      //                   AxisTitles(sideTitles: SideTitles(showTitles: false)),
      //               topTitles:
      //                   AxisTitles(sideTitles: SideTitles(showTitles: false)),
      //               bottomTitles: AxisTitles(
                                      
      //                 sideTitles: SideTitles(
      //                     interval:prov.rivergraph[0].river.isEmpty?400:prov.rivergraph[0].river.length/4,   
      //                   showTitles: true,
      //                   getTitlesWidget: (value, meta) => Text(getDate( prov.rivergraph[0].river[value.toInt()].date).replaceAll('/', '\n')),
      //                 )
      //               )
      //               // leftTitles: AxisTitles(
      //               //     sideTitles: SideTitles(interval: 50, showTitles: true)),
      //             ),
      //       lineBarsData: prov.rivergraph.asMap().entries.map((e) => LineChartBarData(
      //         curveSmoothness: 0.4,
      //         barWidth: 1,
      //         isCurved: true,
      //         color: rivercolors[e.key],
              
      //         spots: e.value.river.asMap().entries.map((e) => FlSpot(
              
      //           e.key.toDouble(),toDouble(prov.isSensor==0?e.value.usv:prov.isSensor==1?e.value.hv:e.value.tv) )
                
                
      //           ).toList()
      //       )).toList()
      //     )
      //  )
        // ):
        // Container(
        //   padding: EdgeInsets.symmetric(vertical: 16),
        //   child: BarChart(
        //       swapAnimationDuration: Duration(seconds: 1),
        //       BarChartData(
        //           maxY: 400,
        //           minY: 0,
                
        //           extraLinesData: ExtraLinesData(horizontalLines: [
        //             HorizontalLine(
        //                 y: prov.getThreshold,
        //                 color: Theme.of(context).colorScheme.error,
        //                 strokeWidth: 1)
        //           ]),
        //           // groupsSpace: 20,
        //           // alignment: BarChartAlignment.spaceEvenly,
        //           gridData: FlGridData(show: false),
        //           borderData: FlBorderData(show: false),
        //           backgroundColor: Theme.of(context).colorScheme.primary,
        //           barTouchData: BarTouchData(
        //             enabled: true,
        //           ),
        //           titlesData: FlTitlesData(
        //             show: true,
        //             rightTitles:
        //                 AxisTitles(sideTitles: SideTitles(showTitles: false)),
        //             topTitles:
        //                 AxisTitles(sideTitles: SideTitles(showTitles: false)),
        //             bottomTitles: AxisTitles(
                      
        //               sideTitles: SideTitles(
        //                 showTitles: true,
        //                 getTitlesWidget: (value, meta) => Text(prov.allrivers[value.toInt()].name.replaceFirst(' ', '\n')),
        //               )
        //             )
        //             // leftTitles: AxisTitles(
        //             //     sideTitles: SideTitles(interval: 50, showTitles: true)),
        //           ),
        //           barGroups: prov.allrivers
        //               .asMap()
        //               .entries
        //               .map((e) => BarChartgroupdata(e))
        //               .toList())),
        // ),
        // showcolorindicator
        //     ? Positioned(
        //         right: 0,
        //         child: Row(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //           //  prov.setgraph?CardsContainer(
        //           //       paddings: EdgeInsets.all(8),
        //           //       childs: prov.rivergraph.isEmpty
        //           //           ? SizedBox()
        //           //           : Column(
        //           //               crossAxisAlignment: CrossAxisAlignment.start,
        //           //               children: prov.rivergraph
        //           //                   .asMap()
        //           //                   .entries
        //           //                   .map(
        //           //                     (e) => Row(
        //           //                       children: [
        //           //                         FaIcon(
        //           //                           FontAwesomeIcons.circleDot,
        //           //                           color: rivercolors[e.key],
        //           //                           size: 10,
        //           //                         ),
        //           //                         SizedBox(
        //           //                           width: 10,
        //           //                         ),
        //           //                         Text(
        //           //                           e.value.name.split(' ')[0],
        //           //                           style: TextStyle(
        //           //                               color: Theme.of(context)
        //           //                                   .colorScheme
        //           //                                   .surface),
        //           //                         )
        //           //                       ],
        //           //                     ),
        //           //                   )
        //           //                   .toList(),
        //           //             ),
        //           //       cardcolor: Theme.of(context)
        //           //           .colorScheme
        //           //           .onSecondary
        //           //           .withOpacity(0.3)):SizedBox(),
        //             SizedBox(
        //               width: 10,
        //             ),
        //             IconButton(
        //               onPressed: prov.setgraphd,
        //               icon: FaIcon(
        //                 FontAwesomeIcons.upRightAndDownLeftFromCenter,
        //                 size: 20,
        //                 color: Theme.of(context).colorScheme.secondary,
        //               ),
        //             )
        //           ],
        //         ),
        //       )
        //     : SizedBox(),
      ],
    );
  }

  BarChartGroupData BarChartgroupdata(MapEntry<int, RiverDetails> r) =>
      BarChartGroupData(
        x: r.key,
        // barsSpace: 20,
        barRods: [
          BarChartRodData(
              width: 20,
              borderRadius: BorderRadius.zero,
              gradient: LinearGradient(
                  colors: [Colors.orange.shade300, Colors.transparent],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter),
              toY: toDouble(r.value.river.last.usv)),
          BarChartRodData(
             width: 20,
              borderRadius: BorderRadius.zero,
              gradient: LinearGradient(
                  colors: [Colors.blue.shade300, Colors.transparent],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter),
            toY: toDouble(r.value.river.last.hv)),
          BarChartRodData(
             width: 20,
              borderRadius: BorderRadius.zero,
              gradient: LinearGradient(
                  colors: [Colors.purple.shade300, Colors.transparent],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter),
            toY: toDouble(r.value.river.last.tv)),
        ],
      );

  SplineAreaSeries<River, DateTime> linecharts(
    RiverDetails riversdata,
    int index,
    Color color,
    NambulProvider prov
  ) {
    return SplineAreaSeries(
        animationDelay: 1,
        animationDuration: 0.3,
        enableTooltip: true,
        markerSettings: MarkerSettings(
          isVisible: true,

          color:color.withOpacity(0.4),
          borderWidth: 0,
          shape: DataMarkerType.circle
        ),
        borderColor: rivercolors[index]!,
        borderWidth: 2,
        splineType: SplineType.natural,
        gradient: LinearGradient(
            colors: [rivercolors[index]!, Colors.transparent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter),
        dataSource: riversdata.river,
        xValueMapper: (datum, index) {
          return datum.date;
        },
        yValueMapper: (d, i) => toDouble(prov.isSensor == 0
            ? d.usv
            : prov.isSensor == 1
                ? d.hv
                : d.tv));
  }
}
