import 'package:floodsystem/providers/riverprovider.dart';
import 'package:floodsystem/widgets/cards.dart';
import 'package:floodsystem/widgets/linechartprediction.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../const.dart';

class PredictionScreen extends StatefulWidget {
  const PredictionScreen({super.key});
  static const String routename = "PredictionScreen";

  @override
  State<PredictionScreen> createState() => _PredictionScreenState();
}

class _PredictionScreenState extends State<PredictionScreen> {
  bool isLine = false;
  void isLinechange(){
    setState(() {
      isLine = !isLine;
    });
  }
  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<NambulProvider>(context);
    return Scaffold(
      appBar: AppBar(
             backgroundColor: Colors.transparent,
        title: const Text(
          appname,
          style: TextStyle(fontSize: headersize),
        ),
      ),
      body:prov.predictionlist.isEmpty?SizedBox():Container(
          child: SingleChildScrollView(
            child: Column(
              children: [ 
                const Text("Forecast"),
                CardsContainer(childs:Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    IconButton(onPressed: isLinechange, icon: FaIcon(isLine?FontAwesomeIcons.chartLine:FontAwesomeIcons.chartBar,size: 16,)),
                    LineChartsPredWidget(isPinching: false, showcolorindicator:true,isLine: isLine),
                  ],
                ), cardcolor:Theme.of(context).colorScheme.background,isBorder: false,paddings: EdgeInsets.all(16),margins: EdgeInsets.all(16),),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: prov.predictionlist.length,
                  itemBuilder: (c,i){
                    return CardsContainer(childs: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(prov.predictionlist[i].name,style:const TextStyle(fontSize: 16),),
                        SizedBox(height: 10,),
                        const Text('Now'),
                        Text("${toDouble(prov.predictionlist[i].river.first.usv).toStringAsFixed(0)} ft"),
                        SizedBox(height: 20,),
                        Text('Next ${prov.durationtime} ${prov.durationtime>1?"mins":"min"}'),
                        Text("${toDouble(prov.predictionlist[i].river.last.usv).toStringAsFixed(0)} ft"),
                      ],
                    ), cardcolor: Theme.of(context).colorScheme.background,margins: EdgeInsets.symmetric(vertical: 8,horizontal: 16),paddings: EdgeInsets.all(16),);
                  })
              ],
            ),
          ),

      ),
    );
  }
}