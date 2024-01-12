import 'package:floodsystem/const.dart';
import 'package:flutter/material.dart';

class WaterCard extends StatelessWidget {
  final Color colors;
  final Widget child;
  const WaterCard({super.key,
  required this.colors,
  required this.child
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
     
      padding: EdgeInsets.all(regularpadding),
      decoration: BoxDecoration(
        color: colors,
        borderRadius: BorderRadius.circular(8)
      ),
      child: child,
    );
  }
}