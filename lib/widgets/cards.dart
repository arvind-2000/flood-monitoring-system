import 'package:floodsystem/const.dart';
import 'package:flutter/material.dart';

class CardsContainer extends StatelessWidget {
  const CardsContainer({super.key,
  required this.childs,
  required this.cardcolor,
  this.paddings =const EdgeInsets.all(0.0),
  this.isBorder = false,
  this.margins =const EdgeInsets.all(0.0),
  });
  final Widget childs;
  final Color? cardcolor;
  final EdgeInsets paddings;
  final EdgeInsets margins;
  final isBorder;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      margin: margins,
      padding: paddings,
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        border: Border.all(color: isBorder?normalColor:Colors.transparent,),
        color:cardcolor,
        borderRadius: BorderRadius.circular(8)
      ),
      child: childs,
    );
  }
}