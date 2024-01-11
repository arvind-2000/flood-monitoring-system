import 'package:flutter/material.dart';

class CardsContainer extends StatelessWidget {
  const CardsContainer({super.key,
  required this.childs,
  required this.cardcolor,
  this.paddings =const EdgeInsets.all(0.0),
  this.margins =const EdgeInsets.all(0.0),
  });
  final Widget childs;
  final Color? cardcolor;
  final EdgeInsets paddings;
  final EdgeInsets margins;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margins,
      padding: paddings,
      decoration: BoxDecoration(
        
        color: cardcolor,
        borderRadius: BorderRadius.circular(8)
      ),
      child: childs,
    );
  }
}