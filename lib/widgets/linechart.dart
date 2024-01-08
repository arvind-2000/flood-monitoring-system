import 'package:fl_chart/fl_chart.dart';
import 'package:floodsystem/const.dart';
import 'package:floodsystem/models/riverdetails.dart';
import 'package:floodsystem/providers/riverprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/imphalriverprovider.dart';
import '../services/services.dart';

class LineCharts extends StatelessWidget {
  const LineCharts({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
      Service ser = Service();
    final prov = Provider.of<NambulProvider>(context);
    return LineChart(
       
        LineChartData(
            
            borderData: FlBorderData(show: false),
            gridData: FlGridData(
              show: false,
          
            ),
    
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(
                axisNameWidget: Text("Water Level",style: TextStyle(fontWeight: FontWeight.bold),)
              ),
              rightTitles: AxisTitles(
                
                sideTitles: SideTitles(showTitles: false)
              ),
              topTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false)
              )
            ),
            maxX: 500,
            minX: 0,
            maxY:10,
            minY: 0,
            
            lineBarsData:prov.getnambulrivers.asMap().entries.map((e) => LineChartBars(ser,e.key,e.value)).toList()));
  }

  LineChartBarData LineChartBars(Service ser,int index, RiverDetails rivers) {
    return LineChartBarData(
                curveSmoothness: 0.5,
                isCurved: true,
                barWidth: 2,
                isStrokeCapRound: true,
                color: rivercolors[index],
                spots:ser.datapoints(rivers).asMap().entries.map((e) => FlSpot(e.key.toDouble(),e.value*0.1)).toList());
  }
}
