import 'package:fl_chart/fl_chart.dart';
import 'package:floodsystem/const.dart';

import 'package:floodsystem/providers/riverprovider.dart';
import 'package:floodsystem/screens/desktop/bargraphsceen.dart';
import 'package:floodsystem/screens/desktop/desktop.dart';
import 'package:floodsystem/screens/desktop/detailsdesktop.dart';
import 'package:floodsystem/widgets/bargraph.dart';

import 'package:floodsystem/widgets/watercard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

import '../../widgets/tables.dart';

class DetailsScreen extends StatefulWidget {
  static const String routename = 'DetailsScreen';
  const DetailsScreen({
    super.key,
  });

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final ScrollController _listcontroller = ScrollController();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<NambulProvider>(context).getnambulrivers;
    final prov2 = Provider.of<NambulProvider>(context);
    final args = ModalRoute.of(context)!.settings.arguments as int;
    var textStyle = TextStyle(fontWeight: FontWeight.bold,fontSize: 14);
    var textStyle2 = TextStyle(fontWeight: FontWeight.bold, fontSize: 20);
    return LayoutBuilder(builder: (context, constraints) {
      return constraints.maxWidth > 500
          ? DetailsDesktop()
          : Scaffold(
            appBar: AppBar(
              title: Text(prov[args].name),
            ),
              // floatingActionButton: FloatingActionButton(onPressed: (){

              body: prov2.allrivers.isEmpty
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : prov[args].river.isEmpty
                      ? Text(
                          'No information',
                          style: textStyle,
                        )
                      : SingleChildScrollView(
                        child: Column(
                            children: [
                              Container(
                                height: 200,
                                padding: EdgeInsets.all(16),
                                child: BarGraphDesktopScreen(
                                    riverdetails: prov2.getMonths(
                                        [prov2.allrivers[args]],
                                        DateTime(2024))),
                              ),
                              Container(
                                padding: EdgeInsets.all(16),
                                child: Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.end,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: WaterCard(
                                        colors: Theme.of(context)
                                            .colorScheme
                                            .secondary
                                            .withOpacity(0.3),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                          children: [
                                            Text(
                                              'Level',
                                              style: textStyle,
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Text(
                                              "${toDouble(prov[args].river.last.usv).toStringAsFixed(0)} $levelunit",
                                              style: textStyle2,
                                            ),
                                          ],
                                        ),
                                      ).animate().shimmer(
                                          duration: Duration(seconds: 2)),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                      child: WaterCard(
                                        colors: Theme.of(context)
                                            .colorScheme
                                            .secondary
                                            .withOpacity(0.3),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                          children: [
                                            Text(
                                              'Humidity',
                                              style: textStyle,
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Text(
                                              "${toDouble(prov[args].river.last.hv).toStringAsFixed(0)} $humiditylevel",
                                              style: textStyle2,
                                            ),
                                          ],
                                        ),
                                      ).animate().shimmer(
                                          duration: Duration(seconds: 2)),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                      child: WaterCard(
                                        colors: Theme.of(context)
                                            .colorScheme
                                            .secondary
                                            .withOpacity(0.3),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                          children: [
                                            Text(
                                              'Temp',
                                              style: textStyle,
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Text(
                                              "${toDouble(prov[args].river.last.tv).toStringAsFixed(0)} $templevel",
                                              style: textStyle2,
                                            ),
                                          ],
                                        ),
                                      ).animate().shimmer(
                                          duration: Duration(seconds: 2)),
                                    ),
                                
                                  ],
                                ),
                              ),
                              Tables(
                                  args: args,
                                  listcontroller: _listcontroller)
                        
                                        
                            ],
                          ),
                      ),
            );
    });
  }
}
