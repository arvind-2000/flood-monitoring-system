import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../const.dart';

class IndicatorCard extends StatelessWidget {
  const IndicatorCard({
    super.key,
    this.value = 0,
    required this.color,
    required this.heights,
    required this.text
  });
  final double value;
  final double heights;
  final String text;
  final color;
  @override
  Widget build(BuildContext context) {
    return Animate(
      effects: [SlideEffect(duration: Duration(milliseconds:1500),begin: Offset(0,1))],
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        padding: EdgeInsets.all(8),
        alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(16),topRight: Radius.circular(16)),
          color: color,
          gradient: LinearGradient(colors: [value>=threshold?Theme.of(context).colorScheme.error:Theme.of(context).colorScheme.secondary,Theme.of(context).colorScheme.primary],begin: Alignment.topCenter,end: Alignment.bottomCenter)
        ),
        child: Text(textAlign: TextAlign.center,text.replaceFirst(' ', '\n'),style: TextStyle(
          fontWeight: FontWeight.bold,
          wordSpacing: 0.2,color: Theme.of(context).colorScheme.onSurface),),
        height:value<=0?100:value>300?300:value),
    );
      
  }
}
