import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../const.dart';
import '../../providers/riverprovider.dart';

class LineChartDesktop extends StatelessWidget {
  const LineChartDesktop({
    super.key,
    required this.barDotData
  });
  
  final bool barDotData;
  @override
  Widget build(BuildContext context) {

    final prov = Provider.of<NambulProvider>(context);
    return Container(
      padding: EdgeInsets.all(16),
      child: LineChart(LineChartData(
        showingTooltipIndicators: prov.allrivers.asMap().entries.map((e) => ShowingTooltipIndicators([LineBarSpot(LineChartBarData(show: false), e.key,FlSpot(e.key.toDouble(),200.00))])).toList(),
        borderData:FlBorderData(show: false) ,
    
        gridData: FlGridData(
          show: false
        ),
        titlesData: FlTitlesData(
          show: false
        ),
        lineBarsData: prov.allrivers.asMap().entries.map((e) => LineChartBarData(
          preventCurveOverShooting: true,
          
        aboveBarData: BarAreaData(
          color: Theme.of(context).colorScheme.surface
        ),
          curveSmoothness: 0.35,
          isCurved: true,
          dotData: FlDotData(show: barDotData),
          color: rivercolors[e.key],
        spots: e.value.river.asMap().entries.map((d) => FlSpot(
          
          d.key.toDouble(),toDouble(d.value.usv))).toList()
      )).toList())),
    );
  }
}
