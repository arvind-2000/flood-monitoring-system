import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../const.dart';
import '../providers/riverprovider.dart';

class linechartdesktop extends StatelessWidget {
  const linechartdesktop({
    super.key,
    required this.prov,
  });

  final NambulProvider prov;

  @override
  Widget build(BuildContext context) {
    print('River graph:${prov.rivergraph.length}');
    return Container(
      padding: EdgeInsets.all(16),
      child: LineChart(LineChartData(
        lineBarsData:prov.rivergraph.map((e) => LineChartBarData(spots: e.river.asMap().entries.map((e) => FlSpot(e.key.toDouble(), toDouble( e.value.usv))).toList())).toList() 
      )),
    );
  }
}
