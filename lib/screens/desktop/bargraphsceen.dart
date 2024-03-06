import 'package:fl_chart/fl_chart.dart';
import 'package:floodsystem/const.dart';
import 'package:floodsystem/models/riverdetails.dart';
import 'package:flutter/material.dart';

class BarGraphDesktopScreen extends StatelessWidget {
  BarGraphDesktopScreen({super.key, required this.riverdetails});
  final List<RiverDetails> riverdetails;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            flex: 2,
            child: Container(
              child: BarChart(
                  swapAnimationCurve: Curves.bounceIn,
                  BarChartData(
                    alignment: BarChartAlignment.center, 
                    maxY: 400,      
                    
    
                      borderData: FlBorderData(show: false),
                      titlesData: FlTitlesData(
                          show: true,
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false)
                          ),
                          topTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false)),
                          rightTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false)),
                          bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                  showTitles: true,
                                  getTitlesWidget: (value, meta) =>
                                      Text(months[value.toInt()]),
                                  interval: 2))),
                      gridData: FlGridData(show: false),
                      barGroups: riverdetails[0].river.asMap().entries.map((e) => BarChartGroupData(
                    
                        x: e.key,barRods: [
                        BarChartRodData(
                          
                          color:(e.value.date.year ==  DateTime.now().year && e.value.date.month ==  DateTime.now().month) ?Theme.of(context).colorScheme.secondary.withOpacity(0.5):Theme.of(context).colorScheme.surface.withOpacity(0.5),
                          width: 40,
                          borderRadius: BorderRadius.circular(4),
                          toY:toDouble(e.value.usv).roundToDouble()),
                        // BarChartRodData(
                        //   color: Theme.of(context).colorScheme.secondary.withOpacity(0.3),
                        //   width: 17,
                        //   toY:toDouble(e.value.hv)),
                        // BarChartRodData(
                        //   color: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
                        //   width: 14,
                        //   toY:toDouble(e.value.tv)),
                        
                        ])).toList(),
            )),)),
        // Expanded(child: Container())
      ],
    );
  }
}
