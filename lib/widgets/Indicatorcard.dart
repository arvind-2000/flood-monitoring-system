import 'package:floodsystem/providers/riverprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';

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
    final prov = Provider.of<NambulProvider>(context);
    return Animate(
      effects: [SlideEffect(duration: Duration(seconds:1),begin: Offset(0,0.5)),FadeEffect(duration: Duration(seconds: 1))],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 8),
            padding: EdgeInsets.all(8),
            alignment: Alignment.bottomCenter,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(16),topRight: Radius.circular(16)),
              color: color,
              gradient: LinearGradient(colors: [value>=prov.getThreshold?Theme.of(context).colorScheme.error:Theme.of(context).colorScheme.secondary,Theme.of(context).colorScheme.primary],begin: Alignment.topCenter,end: Alignment.bottomCenter)
            ), 
           
            height:value>=200?200:value),
            
             Text(textAlign: TextAlign.center,"${text.split(' ')[0]}\n$value",style: TextStyle(
              fontWeight: FontWeight.bold,
              wordSpacing: 0.2,color: Theme.of(context).colorScheme.onSurface),),
        ],
      ),
    );
      
  }
}
