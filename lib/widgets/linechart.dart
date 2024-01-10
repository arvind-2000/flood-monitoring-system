import 'package:fl_chart/fl_chart.dart';
import 'package:floodsystem/const.dart';
import 'package:floodsystem/models/river.dart';
import 'package:floodsystem/models/riverdetails.dart';
import 'package:floodsystem/providers/riverprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../providers/imphalriverprovider.dart';
import '../services/services.dart';

class LineCharts extends StatelessWidget {
LineCharts({
    super.key,
  });

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
    return SfCartesianChart(
      zoomPanBehavior:ZoomPanBehavior(enablePinching: true,
      zoomMode: ZoomMode.x
      ),
      borderColor: Colors.transparent,
      borderWidth: 0,
      primaryXAxis: NumericAxis(
        minimum: 0,
        maximum: 11,
        isVisible: false,
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

      series:<CartesianSeries<River,int>>[
        SplineAreaSeries(
          splineType: SplineType.natural,
          gradient: LinearGradient(colors: [Colors.blue.withOpacity(0.3),Colors.transparent],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter
          ),
          dataSource: data,
          xValueMapper: (datum, index) => int.parse(datum.hv), yValueMapper: (d,i)=>toDouble(d.usv))
          
      ]
        
    );
  }
}

