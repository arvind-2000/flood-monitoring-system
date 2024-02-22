import 'package:flutter/material.dart';

import '../providers/riverprovider.dart';
import 'rivercardswidget.dart';

class TopDashboardWidgets extends StatelessWidget {
  const TopDashboardWidgets({
    super.key,
    required this.prov,
  });

  final NambulProvider prov;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: prov.getnambulrivers
            .map((e) => Expanded(
                    child: GestureDetector(
                        child: RiversCardDesktop(
                  riverdetails: e,
                ))))
            .toList(),
      ),
    );
  }
}