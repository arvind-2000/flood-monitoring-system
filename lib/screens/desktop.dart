import 'package:fl_chart/fl_chart.dart';
import 'package:floodsystem/providers/riverprovider.dart';
import 'package:floodsystem/screens/desktop/tablescreendesktop.dart';
import 'package:floodsystem/screens/home.dart';
import 'package:floodsystem/screens/mobile.dart';
import 'package:floodsystem/screens/mobile/graphscreen.dart';
import 'package:floodsystem/widgets/cards.dart';
import 'package:floodsystem/widgets/linechart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<NambulProvider>(context, listen: false).getdata();
      Provider.of<NambulProvider>(context, listen: false).getlatest();
      Provider.of<NambulProvider>(context, listen: false).getprefs();
    });

    // TODO: implement initState
    super.initState();
  }

  int index=0;
  Widget switchCases(int i){

    switch(i){
      case 0:
      return HomeDesktop();
      case 1:
      return GraphScreen();
      case 2:
      return TableScreenDesktop();
       default:
        return HomeDesktop();

    }
  }
  void changeIndex(int i){
    setState(() {
      index = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<NambulProvider>(context);
    return Scaffold(
      body: Container(
        // padding: EdgeInsets.symmetric(horizontal: 40),
        color: Theme.of(context).colorScheme.background,
        child: SafeArea(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: Container(
                      
                      color: Theme.of(context).colorScheme.background,
                      // margins: EdgeInsets.all(16),
                      child: SizedBox(
                          height: double.infinity,
                          child: SafeArea(
                            child: Container(
                              child: ListTileTheme(
                                textColor: Theme.of(context).colorScheme.surface,
                                iconColor:Theme.of(context).colorScheme.surface,
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          ListTile(
                                            contentPadding: EdgeInsets.all(16),
                                            onTap: () {
                                              changeIndex(0);
                                            },
                                            hoverColor: Theme.of(context)
                                                .colorScheme
                                                .secondary
                                                .withOpacity(0.2),
                                            leading: Icon(Icons.home),
                                            title: Text('Home'),
                                          ),
                                          ListTile(
                                            contentPadding: EdgeInsets.all(16),
                                            onTap: () {
                                                    changeIndex(1);
                                            },
                                            focusColor: Theme.of(context)
                                                .colorScheme
                                                .secondary
                                                .withOpacity(0.5),
                                            hoverColor: Theme.of(context)
                                                .colorScheme
                                                .secondary
                                                .withOpacity(0.5),
                                            leading: FaIcon(
                                                FontAwesomeIcons.chartLine),
                                            title: Text('Charts'),
                                          ),
                                          ListTile(
                                            contentPadding: EdgeInsets.all(16),
                                            onTap: () {
                                                    changeIndex(2);
                                            },
                                            hoverColor: Theme.of(context)
                                                .colorScheme
                                                .secondary
                                                .withOpacity(0.2),
                                            leading:
                                                FaIcon(FontAwesomeIcons.table),
                                            title: Text('Tables'),
                                          ),
                                          ListTile(
                                            contentPadding: EdgeInsets.all(16),
                                            onTap: () {
                                              // Navigator.pushNamed(context, MobileSettings.routename);
                                            },
                                            hoverColor: Theme.of(context)
                                                .colorScheme
                                                .secondary
                                                .withOpacity(0.2),
                                            leading: Icon(Icons.settings),
                                            title: Text('Settings'),
                                          ),
                                          Spacer(),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )))),
              Expanded(
                  flex: 4,
                  child:switchCases(index).animate().fade()),
              Expanded(
                  child: CardsContainer(
                      margins: EdgeInsets.all(16),
                      childs: SizedBox(
                        height: double.infinity,
                      ),
                      cardcolor: Theme.of(context).colorScheme.primary)),
              // PredictionWidget(prov: prov),
              // SizedBox(
              //   height: 10,
              // ),

              // Row(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     Expanded(child: CardsContainer(childs:Expanded(child: Container(height: double.infinity,)), cardcolor: cardcolor)),
              //         SizedBox(width: 20,),
              //     Padding(
              //       padding: const EdgeInsets.symmetric(vertical:8.0),
              //       child: IndicatorCardWidget(riverprovider: prov, cardwidth: 450),
              //     ),
              //     SizedBox(width: 20,),
              //     Expanded(
              //       child: RiverListHome(
              //       riverprovider: prov,
              //       showlist: false,
              //                         ),
              //     )
              //   ],
              // ),
              // SizedBox(height: 20,)
              // Expanded(
              //   child: Row(
              //                   crossAxisAlignment: CrossAxisAlignment.start,
              //                   children: [
              //   Padding(
              //     padding: const EdgeInsets.symmetric(vertical: 8),
              //     child:
              //         IndicatorCardWidget(riverprovider: prov, cardwidth: 400),
              //   ),
              //   SizedBox(
              //     width: 20,
              //   ),
              //   Expanded(
              //       child: RiverListHome(

              //     riverprovider: prov,
              //     showlist: false,
              //   ))
              //                   ],
              //                 ),
              // ),
            ],
          ),
        ),
      ).animate().fade(),
    );
  }
}

class HomeDesktop extends StatelessWidget {
  const HomeDesktop({
    super.key,

  });


  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<NambulProvider>(context);
    return Container(
        margin: EdgeInsets.all(16),
        child: SizedBox(
          height: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CardsContainer(childs: IndicatorCardWidget(riverprovider: prov, cardwidth: 400,isDesktop: true,),cardcolor: Theme.of(context).colorScheme.primary,),
                  Expanded(child:Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                   
                    child: Container(
    
                            height: 380,
                      child: Column(
                      children: [
                        Expanded(
                          child: PieChart(PieChartData(
                            centerSpaceRadius: 0,
                          
                            centerSpaceColor: Theme.of(context).colorScheme.secondary,
                            borderData: FlBorderData(
                              show: true
                            ),
                            sectionsSpace: 2.5,
                            startDegreeOffset: 25,
                            sections:prov.getnambulrivers.asMap().entries.map((e) => PieChartSectionData(
                              radius: 60,
                              color: rivercolors[e.key],
                              value: toDouble(e.value.river.last.usv))).toList() 
                          )),
                        ),
                        Row(
                          children: prov.getnambulrivers.asMap().entries.map((e) => Expanded(
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal:16),
                            child: CardsContainer(
                              cardcolor: Theme.of(context).colorScheme.primary,
                              childs: Container(
                               padding: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: rivercolors[e.key]
                                  // gradient: LinearGradient(colors: [rivercolors[e.key]!,Colors.transparent])
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                
                                  children: [
                                   
                                    Text(e.value.name),
                                     SizedBox(height: 20,),
                                     Text("Level"),
                                    Text(toDouble(e.value.river.last.usv).toStringAsFixed(2)),
                                    SizedBox(height: 10,),
                                      Text("Humidity"),
                                    Text(toDouble(e.value.river.last.hv).toStringAsFixed(2)),
                                    SizedBox(height: 10,),
                                    Text("Temp"),
                                    Text(toDouble(e.value.river.last.tv).toStringAsFixed(2)),
                          
                                  ],
                                ),
                              ),
                            ),
                                                    ),
                          )).toList(),
                        )
                        
                    
                      ],
                    )),
                  )),
                ],
              ),
              prov.rivergraph.isEmpty?Center(child: CircularProgressIndicator(strokeWidth: 2,)):Expanded(child:  Container(
                margin: EdgeInsets.only(top: 16,right: 16),
               
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                  
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: LineCharts(isPinching: true, showcolorindicator: true),
                            ),
                            Expanded(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: sensorslist
                          .asMap()
                          .entries
                          .map(
                            (e) => InkWell(
                                onTap: () {
                                  // scrollOntap();
                              
                                    prov.changesensor(e.key);
                           
                                },
                                child: CardsContainer(
                                  childs: Text(
                                    e.value,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  cardcolor: Theme.of(context)
                                      .colorScheme
                                      .onSecondary
                                      .withOpacity(0.3),
                                  paddings: EdgeInsets.all(8),
                                  margins: EdgeInsets.all(8),
                                  isBorder: e.key == prov.isSensor,
                                )),
                          )
                          .toList(),
                                                )),
                          ],
                        ),
                      ),
                    ),
                    // Expanded(child: Container())
                  ],
                ),
              ))
            ],
          ),
        ),
       );
  }
}

class PredictionWidget extends StatelessWidget {
  const PredictionWidget({
    super.key,
    required this.prov,
  });

  final NambulProvider prov;

  @override
  Widget build(BuildContext context) {
    return CardsContainer(
      cardcolor: Theme.of(context).colorScheme.primary.withOpacity(0.3),
      childs: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
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
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              Text(e.usv + levelunit,
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ))
                      .toList(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
