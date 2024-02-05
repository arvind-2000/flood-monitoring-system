import 'package:floodsystem/providers/riverprovider.dart';
import 'package:floodsystem/screens/mobile.dart';
import 'package:floodsystem/widgets/cards.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';

import '../const.dart';

class DesktopScreen extends StatefulWidget {
  const DesktopScreen({super.key});

  @override
  State<DesktopScreen> createState() => _DesktopScreenState();
}

class _DesktopScreenState extends State<DesktopScreen> {

  @override
  void initState() {
    Provider.of<NambulProvider>(context,listen: false).getdata();
    Provider.of<NambulProvider>(context,listen: false).getlatest();
    Provider.of<NambulProvider>(context,listen: false).getprefs();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<NambulProvider>(context);
    return Container(
    
      padding: EdgeInsets.symmetric(horizontal:40),
      color:Theme.of(context).colorScheme.background,
      child: ListView(
        shrinkWrap: true,
                children: [
                  Expanded(
                    child:         CardsContainer(
                cardcolor:
                    Theme.of(context).colorScheme.primary.withOpacity(0.3),
                childs: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.secondary.withOpacity(0.2),
                      Theme.of(context).colorScheme.primary.withOpacity(0.3)
                    ],
                    end: Alignment.bottomRight,
                    begin: Alignment.topLeft,
                  )),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Prediction',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          Text(
                            'Next $checktime mins',
                            style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .surface
                                    .withOpacity(0.5)),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: prov.getPredictions
                                .map((e) => Column(
                                      children: [
                                        Text(e.name,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        Text(e.usv+levelunit,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ))
                                .toList(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),),
              SizedBox(height: 10,),  
                  Expanded(child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: IndicatorCardWidget(riverprovider: prov, cardwidth: 400),
                      ),
                      SizedBox(width: 20,),
                      Expanded(child: RiverListHome(riverprovider: prov,showlist: false,))
                    ],
                  )),
                  
                ],
      ),
    ).animate().fade();
  }
}