import 'dart:developer';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../const.dart';
import '../models/river.dart';
import '../models/riverdetails.dart';
import '../providers/riverprovider.dart';




class LineChartsWidget extends StatefulWidget {
    LineChartsWidget({
    super.key,
    required this.isPinching,
    required this.showcolorindicator,
    this.index = 0,
  });
  final int index;
  final bool isPinching;
  final bool showcolorindicator;

  @override
  State<LineChartsWidget> createState() => _LineChartsWidgetState();
}

class _LineChartsWidgetState extends State<LineChartsWidget> {
  int val = 20;


  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<NambulProvider>(context);
    return Stack(
      children: [
        

      prov.rivergraph[0].river.isEmpty?const SizedBox(
        child: Center(child: Text('No Data'),),
       ):Container(
        // margin:const EdgeInsets.symmetric(horizontal: 16),
        // padding:const EdgeInsets.only(left: 24,top: 16),
        padding: EdgeInsets.only(right:16),
       
        decoration: BoxDecoration(
          
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(16)
        ),
         child: SfCartesianChart(
           
            zoomPanBehavior: ZoomPanBehavior(
         
              enableMouseWheelZooming: true,
              enablePanning: true,
              
              // maximumZoomLevel: 1,  
              // enablePinching: true,
           
              zoomMode: ZoomMode.x,
              enableSelectionZooming: true
         
            ),

            tooltipBehavior: TooltipBehavior(enable: true,
            color: Theme.of(context).colorScheme.primary,
            textStyle: TextStyle(color: Theme.of(context).colorScheme.surface)
            ),
            borderWidth: 0,
        
            borderColor: Colors.transparent,
            margin: EdgeInsets.zero,
            plotAreaBorderColor: Colors.transparent,
            plotAreaBorderWidth: 0,
            // title: ChartTitle(
            //   text: prov.graphDataList[0].name,
            //   alignment: ChartAlignment.near,
            //   borderWidth: 8
            // ),
            enableAxisAnimation: true,
          // title: ChartTitle( text:prov.rivergraph[0].name,alignment: ChartAlignment.near,),
            
            primaryYAxis:const NumericAxis(
    
                 majorGridLines: MajorGridLines(
            
             width: 0
           ),
            desiredIntervals: 10,

              minimum: 0.0,
              interval: 50,
              maximum: 300,
              
            ),
          primaryXAxis: NumericAxis(
               majorGridLines: MajorGridLines(
                 
             width: 0
           ),

                // axisLabelFormatter:(axisLabelRenderArgs) => ChartAxisLabel(prov.filtertype==0?months[int.parse(axisLabelRenderArgs.text)]:axisLabelRenderArgs.text, TextStyle(fontSize:12)),
                axisLabelFormatter: prov.filtertype!=0?(axisLabelRenderArgs) => ChartAxisLabel(  months[prov.rivergraph[prov.getindexs(prov.rivergraph)].river[int.parse(axisLabelRenderArgs.text)].date.month-1],const TextStyle(fontSize:12)) :(axisLabelRenderArgs) => ChartAxisLabel(  prov.rivergraph[prov.getindexs(prov.rivergraph)].river[int.parse(axisLabelRenderArgs.text)].date.day.toString(),const TextStyle(fontSize:12)) ,
                  interval:1,
                  
                  // maximum: prov.filtertype==0?12:null,
                  title: AxisTitle(
                  
                    text: "Time"
                  ),
                  autoScrollingMode:AutoScrollingMode.end,
                  // autoScrollingDelta: val,

            // initialZoomPosition: 1,
            // initialZoomFactor: 0.2,
           
            
                  
          ),
          series: prov.rivergraph.asMap().entries.map((e) =>prov.isLinegraph? linecharts(e.value, e.key,Theme.of(context).colorScheme.secondary,prov) :barcharts(e.value, e.key,Theme.of(context).colorScheme.secondary,prov) ).toList(),
         ),
       ),
       Positioned(
            right: 0,
            top: 0,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Row(
                //   children:[
                //     IconButton(onPressed: (){
                //           setState(() {
                //             if(val<=20)
                //           {
                //             val = 20;
                //           }
                //             else{
                //               val = val - 20;
                //             }
                //           });
                
                      
                //     }, icon:const FaIcon(FontAwesomeIcons.plus,size: 20,)),
                //     IconButton(onPressed: (){
                //         setState(() {
                //                  if(val>=200)
                //           {
                //             val = 200;
                //           }
                //             else{
                //               val = val + 20;
                //             }
                //         });
                
                //     }, icon:const FaIcon(FontAwesomeIcons.minus,size: 16,),hoverColor: Theme.of(context).colorScheme.secondary,),
                //   ]
                // ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Theme.of(context).colorScheme.secondary.withOpacity(0.3)
                  ),
                  child: Text(prov.isSensor==0?"Levels in $levelunit":prov.isSensor==1?"Humidity in $humiditylevel":"Temperature in $templevel"),
                )
              ],
            ),
          ),
        ),
    
     
        
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

  SplineAreaSeries<River, int> linecharts(
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
        splineType: SplineType.cardinal,
        cardinalSplineTension: 0.3,
        gradient: LinearGradient(
            colors: [rivercolors[index]!.withOpacity(0.2), Colors.transparent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter),
        dataSource: riversdata.river,
        emptyPointSettings: EmptyPointSettings(
          mode: EmptyPointMode.average
          
        ),
        xValueMapper: (datum, index) {
          return index;
        },
      
        yValueMapper: (d, i) => toDouble(prov.isSensor == 0
            ? d.usv
            : prov.isSensor == 1
                ? d.hv
                : d.tv));
  }


 ChartSeries<River, int> linechartv2(
    RiverDetails riversdata,
    int index,
    Color color,
   NambulProvider prov
  ) {
    return LineSeries(
        animationDelay: 1,
        animationDuration: 0.3,
        enableTooltip: true,
        
        markerSettings: MarkerSettings(
          isVisible: true,
        
          color:color.withOpacity(0.4),
          borderWidth: 0,
          shape: DataMarkerType.circle
        ),

        dataSource: riversdata.river,
        xValueMapper: (datum, index) {
          return index;
        },
        yValueMapper: (d, i) => toDouble(prov.graphindex == 0
            ? d.usv
            : prov.graphindex == 1
                ? d.hv
                : d.tv));
  }



  ColumnSeries<River, int> barcharts(
    RiverDetails riversdata,
    int index,
    Color color,
    NambulProvider prov
  ) {
    return ColumnSeries(
        animationDelay: 1,
        animationDuration: 0.3,
        enableTooltip: true,
        trackColor: Colors.red,
        onPointTap: (c){
          log("DataPoint: ${c.seriesIndex}");
        },
        color: rivercolors[index]!,
        borderColor: rivercolors[index]!,
        borderWidth: 1,
       
        // splineType: SplineType.natural,
        // gradient: LinearGradient(
        //     colors: [Colors.transparent, Colors.transparent],
        //     begin: Alignment.topCenter,
        //     end: Alignment.bottomCenter),
        dataSource: riversdata.river,
        xValueMapper: (datum, index) {
          return index;
        },
        yValueMapper: (d, i) => toDouble(prov.isSensor == 0
            ? d.usv
            : prov.isSensor == 1
                ? d.hv
                : d.tv));
  }

}

