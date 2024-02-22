import 'package:fl_chart/fl_chart.dart';
import 'package:floodsystem/providers/logics.dart';
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

import '../../const.dart';
import '../../widgets/dashboarddesktop.dart';
import '../../widgets/linechartdesktop.dart';
import '../../widgets/rivercardswidget.dart';

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

  int index = 0;
  Widget switchCases(int i) {
    switch (i) {
      case 0:
        return HomeDesktop();
      case 1:
        return GraphScreen();
      case 2:
        return GraphScreen();
      default:
        return HomeDesktop();
    }
  }

  void changeIndex(int i) {
    setState(() {
      index = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<NambulProvider>(context);
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SizedBox(
            child: Row(
          children: [
            Container(
              width: 60,
              color: Theme.of(context).colorScheme.primary,
              child: Column(
                  
                children: [
                  SizedBox(height: 100,),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 24),
                    child: IconButton(onPressed: (){}, icon: const FaIcon(FontAwesomeIcons.house))),
                  
                    Container(
                    padding: EdgeInsets.symmetric(vertical: 24),
                    child: IconButton(onPressed: (){}, icon: const FaIcon(FontAwesomeIcons.chartLine))),
                       Container(
                    padding: EdgeInsets.symmetric(vertical: 24),
                    child: IconButton(onPressed: (){}, icon: const FaIcon(FontAwesomeIcons.table))),
                       Container(
                    padding: EdgeInsets.symmetric(vertical: 24),
                    child: IconButton(onPressed: (){}, icon: const FaIcon(FontAwesomeIcons.toolbox))),
                ],
              ),
            ),
            Expanded(
              child: SizedBox(
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      //first row for river cards
                      child: TopDashboardWidgets(prov: prov),
                    ),
                    Expanded(
                      flex: 3,
                      child: SizedBox(
                        child: Row(
                          children: [
                            //graph
                            Expanded(
                                child: CardsContainer(
                                  margins: const EdgeInsets.symmetric(horizontal: 16,vertical:8),
                              cardcolor: Theme.of(context).colorScheme.primary,
                            childs: linechartdesktop(prov: prov),)),
                            const Expanded(
                                child: SizedBox(
                              height: double.infinity,
                              child: Column(
                                children: [
                                  //bar graph
                                  Expanded(
                                    flex: 2,
                                    child: BarGraphDesktop(),
                                  ),
                                  //tables
                                  Expanded(
                                    flex: 1,
                                    child: TablesDesktop(),
                                  ),
                                ],
                              )
                            )),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        )));
  }
}

class TablesDesktop extends StatelessWidget {
  const TablesDesktop({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<NambulProvider>(context);
    return CardsContainer(
      margins: EdgeInsets.symmetric(horizontal:16,vertical: 8),
      cardcolor: Theme.of(context).colorScheme.primary,
      childs: Container(
        padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Year"),
                  ...months.map((e) => Text(e)).toList(),
                
                ],
  
              
              )
            ],
          ),

      ),
    );
  }
}

class BarGraphDesktop extends StatelessWidget {
  const BarGraphDesktop({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<NambulProvider>(context);
    return CardsContainer(
      margins: EdgeInsets.symmetric(horizontal:16,vertical: 8),
      cardcolor: Theme.of(context).colorScheme.primary,
      childs: Container(
        padding: EdgeInsets.all(16),
        child: BarChart(
          
          BarChartData(
            maxY: 400,
            barGroups: Logics().getYear(prov.allrivers).asMap().entries.map((e) => BarChartGroupData(
              barsSpace: 16,
              x: e.key,barRods: [BarChartRodData(
             
              toY: toDouble(e.value.river.last.usv))])).toList())
        ),
      ),
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
                CardsContainer(
                  childs: IndicatorCardWidget(
                    riverprovider: prov,
                    cardwidth: 400,
                    // isDesktop: true,
                  ),
                  cardcolor: Theme.of(context).colorScheme.primary,
                ),
                Expanded(
                    child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                      height: 380,
                      child: Column(
                        children: [
                          Expanded(
                            child: PieChart(PieChartData(
                                centerSpaceRadius: 0,
                                centerSpaceColor:
                                    Theme.of(context).colorScheme.secondary,
                                borderData: FlBorderData(show: true),
                                sectionsSpace: 2.5,
                                startDegreeOffset: 25,
                                sections: prov.getnambulrivers
                                    .asMap()
                                    .entries
                                    .map((e) => PieChartSectionData(
                                        radius: 60,
                                        color: rivercolors[e.key],
                                        value:
                                            toDouble(e.value.river.last.usv)))
                                    .toList())),
                          ),
                          Row(
                            children: prov.getnambulrivers
                                .asMap()
                                .entries
                                .map((e) => Expanded(
                                      child: Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 16),
                                        child: CardsContainer(
                                          cardcolor: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          childs: Container(
                                            padding: EdgeInsets.all(16),
                                            decoration: BoxDecoration(
                                                color: rivercolors[e.key]
                                                // gradient: LinearGradient(colors: [rivercolors[e.key]!,Colors.transparent])
                                                ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(e.value.name),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Text("Level"),
                                                Text(toDouble(
                                                        e.value.river.last.usv)
                                                    .toStringAsFixed(2)),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text("Humidity"),
                                                Text(toDouble(
                                                        e.value.river.last.hv)
                                                    .toStringAsFixed(2)),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text("Temp"),
                                                Text(toDouble(
                                                        e.value.river.last.tv)
                                                    .toStringAsFixed(2)),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ))
                                .toList(),
                          )
                        ],
                      )),
                )),
              ],
            ),
            prov.rivergraph.isEmpty
                ? Center(
                    child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ))
                : Expanded(
                    child: Container(
                    margin: EdgeInsets.only(top: 16, right: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: LineCharts(
                                      isPinching: true,
                                      showcolorindicator: true),
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
                                                    fontWeight:
                                                        FontWeight.bold),
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
