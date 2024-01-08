import 'package:fl_chart/fl_chart.dart';
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
    final prov = Provider.of<ImphalRiverProvider>(context);
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
            maxX: prov.getallimphalrivers.river.length.toDouble(),
            minX: 0,
            maxY: 30,
            minY: 0,
            
            lineBarsData: [
              LineChartBarData(
                  curveSmoothness: 0.5,
                  isCurved: true,
                  barWidth: 2,
                  isStrokeCapRound: true,
                  spots:ser.datapoints(prov.getallimphalrivers).asMap().entries.map((e) => FlSpot(e.key.toDouble(),e.value*0.1)).toList())
            ]));
  }
}
