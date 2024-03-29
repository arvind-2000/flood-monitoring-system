import 'dart:developer';
import 'dart:io';
import 'dart:isolate';
import 'package:floodsystem/const.dart';
import 'package:floodsystem/models/riverdetails.dart';

import 'package:floodsystem/providers/riverprovider.dart';
import 'package:floodsystem/screens/mobile/details.dart';
import 'package:floodsystem/screens/mobile/graphscreen.dart';
import 'package:floodsystem/screens/mobile/predictionscreen.dart';
import 'package:floodsystem/widgets/cards.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../models/river.dart';
import '../widgets/Indicatorcard.dart';

import '../services/services.dart';

class MobileScreen extends StatefulWidget {
  const MobileScreen({
    super.key,
// required this.onchanged
  });
  // final onchanged;
  @override
  State<MobileScreen> createState() => _MobileScreenState();
}

class _MobileScreenState extends State<MobileScreen> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
 

  @override
  void initState() {

    if(Platform.isAndroid){
       RootIsolateToken? rootIsolateToken;
     rootIsolateToken = RootIsolateToken.instance!;
    isolatesRun(rootIsolateToken);

    }
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) { 
      Provider.of<NambulProvider>(context,listen: false).getdata();

    });
  
    // TODO: implement initState
    super.initState();
  }

  Future<void> isolatesRun(RootIsolateToken? rootIsolateToken) async {
    ReceivePort receivePort = ReceivePort();

    // List<RiverDetails> rivers = [];
    await Isolate.spawn(
        getDataIsolatesHome, [receivePort.sendPort, rootIsolateToken]);
    final response = await receivePort.first;
    print("In listen isolates:${response[1]}");

    try {
      Provider.of<NambulProvider>(context, listen: false)
          .setAllfromIsolates(response[0], response[1]);
    } catch (e) {
      log('Error in isolates:${response[0].length}   ');
    }
  }

  @override
  Widget build(BuildContext context) {
    final riverprovider = Provider.of<NambulProvider>(context);
    // final imphalprov = Provider.of<ImphalRiverProvider>(context);
    // final irilprov = Provider.of<IrilRiverProvider>(context);
    print('in home: ${riverprovider.isLoadingall}');
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      backgroundColor: Theme.of(context).colorScheme.secondary,
      onRefresh: () {

            if(Platform.isAndroid){
       RootIsolateToken? rootIsolateToken;
     rootIsolateToken = RootIsolateToken.instance!;
    isolatesRun(rootIsolateToken);

    }
        // showNotification(
        //     notificationsPlugin: _flutterLocalNotificationsPlugin,
        //     title: "Flood System",
        //     body: 'Water Level Raised:200');
        return riverprovider.reconnect();
      },
      child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(regularpadding),
          width: double.infinity,
          child: Column(
            children: [
             riverprovider.predictionswitch && riverprovider.getPredictions.isNotEmpty?CardsContainer(
                cardcolor:
                    Theme.of(context).colorScheme.primary.withOpacity(0.3),
                childs: GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, PredictionScreen.routename);
                    log('in prediction');
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                    //     gradient: LinearGradient(
                    //   colors: [
                    //     Theme.of(context).colorScheme.secondary.withOpacity(0.2),
                    //     Theme.of(context).colorScheme.primary.withOpacity(0.3)
                    //   ],
                    //   end: Alignment.bottomRight,
                    //   begin: Alignment.topLeft,
                    // )
                    color: Theme.of(context).colorScheme.secondary.withOpacity(0.7)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Prediction',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Text(
                          'Next ${riverprovider.durationtime} ${riverprovider.durationtime>1?"mins":"min"}',
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
                          children: riverprovider.getPredictions
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
                  ),
                ),
              ).animate().fade():SizedBox(),
              SizedBox(
                height: 20,
              ),
              IndicatorCardWidget(riverprovider: riverprovider,cardwidth: double.infinity,),
              SizedBox(
                height: 60,
              ),
              RiverListHome(riverprovider: riverprovider),
            ],
          ),
        ),
      ),
    );
  }

  List<ColumnSeries<River, String>> _getColumnSeries(
      List<RiverDetails> r, NambulProvider prov) {
    return r
        .map((e) => ColumnSeries<River, String>(
            width: 1,
            spacing: 0,
            dataSource: e.river,
            color: toDouble(e.river.last.usv) >= prov.getThreshold
                ? Theme.of(context).colorScheme.error.withOpacity(0.5)
                : Theme.of(context).colorScheme.secondary.withOpacity(0.4),
            xValueMapper: (d, x) => e.name,
            yValueMapper: (r, v) => double.parse(r.usv)))
        .toList();
  }
}

class RiverListHome extends StatelessWidget {
  const RiverListHome({
    super.key,
    required this.riverprovider,
    this.showlist = true
  });
  final showlist;
  final NambulProvider riverprovider;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return CardsContainer(
            cardcolor: Theme.of(context).colorScheme.primary,
            // paddings: EdgeInsets.all(16),
            margins: EdgeInsets.symmetric(vertical: 8),
            childs: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        riverprovider.getnambulrivers[index].name
                            .replaceFirst(' ', '\n'),
                        style: TextStyle(
                        
            
                            fontSize: 16),
                 
                            
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, DetailsScreen.routename,
                              arguments: index);
                        },
                        child: CardsContainer(
                          paddings: EdgeInsets.all(16),
                          childs: FaIcon(
                            FontAwesomeIcons.arrowRight,
                            size: 16,
                            color: Colors.white,
                          ),
                          cardcolor:
                              Theme.of(context).colorScheme.secondary,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
               !showlist? SizedBox():CardsContainer(
                  paddings: EdgeInsets.symmetric(
                      vertical: 8, horizontal: 16),
                  cardcolor: Theme.of(context)
                      .colorScheme
                      .secondary
                      .withOpacity(0.2),
                  childs: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        riverprovider
                                .getnambulrivers[index].river.isEmpty
                            ? 'No data'
                            : '${getDate(riverprovider.getnambulrivers[index].river.last.date)}\n${gethour(riverprovider.getnambulrivers[index].river.last.date)}',
                        style: TextStyle(height: 1, fontSize: 12),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      riverprovider
                              .getnambulrivers[index].river.isEmpty
                          ? SizedBox()
                          : Row(
                              children: [
                                Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text('Lev'),
                                    Text(
                                        toDouble(riverprovider
                                                .getnambulrivers[
                                                    index]
                                                .river
                                                .last
                                                .usv)
                                            .toStringAsFixed(2)+levelunit,
                                        style: TextStyle(
                                            fontWeight:
                                                FontWeight.bold,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary)),
                                  ],
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Humidity',
                                    ),
                                    Text(
                                        toDouble(riverprovider
                                                .getnambulrivers[
                                                    index]
                                                .river
                                                .last
                                                .hv)
                                            .toStringAsFixed(2)+humiditylevel,
                                        style: TextStyle(
                                            fontWeight:
                                                FontWeight.bold,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary)),
                                  ],
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text('Temp'),
                                    Text(
                                        toDouble(riverprovider
                                                .getnambulrivers[
                                                    index]
                                                .river
                                                .last
                                                .tv)
                                            .toStringAsFixed(2)+templevel,
                                        style: TextStyle(
                                            fontWeight:
                                                FontWeight.bold,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary)),
                                  ],
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                              ],
                            ),
                    ],
                  ),
                )
              ],
            ));
      },
      itemCount: riverprovider.getnambulrivers.length,
    );
  }
}




class IndicatorCardWidget extends StatelessWidget {
  const IndicatorCardWidget({
    super.key,
    required this.riverprovider,
    required this.cardwidth,
    this.isDesktop = false
  });
  final bool isDesktop;
  final NambulProvider riverprovider;
  final double cardwidth;
  @override
  Widget build(BuildContext context) {
    return CardsContainer(
      cardcolor:
          Theme.of(context).colorScheme.primary.withOpacity(0.3),
      childs: Container(
        height:400,
        width: cardwidth,
        // margin: EdgeInsets.all(8),
        padding: EdgeInsets.all(16),
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(8)),
    
        // child: SfCartesianChart(
        //     // zoomPanBehavior: ZoomPanBehavior(enablePinching: true,enablePanning: true),
        //     plotAreaBorderWidth: 0,
        //     borderWidth:0,
        //     enableAxisAnimation: true,
        //     primaryXAxis: const CategoryAxis(
        //       borderWidth: 0,
    
        //       majorGridLines: MajorGridLines(width: 0),
        //     ),
        //     primaryYAxis: NumericAxis(
        //       isVisible:true,
    
        //       majorGridLines: MajorGridLines(width: 0),
        //       borderWidth: 0,
        //     ),
        //   series:_getColumnSeries(riverprovider.getnambulrivers,riverprovider),
        // ),
    
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Indicator",
                  style: TextStyle(
                       fontSize: 20),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                        context, GraphScreen.routename);
                    // widget.onchanged(1);
                  },
                  child:isDesktop?const SizedBox():Container(
                    padding: const EdgeInsets.all(12),
                  child:isDesktop?const SizedBox():Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color:
                            Theme.of(context).colorScheme.secondary),
                    child:const  Row(
                      children: [
                        Text(
                          'Charts',
                          style: TextStyle(
                              fontSize: 16, color: Colors.white),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        FaIcon(
                          FontAwesomeIcons.arrowRight,
                          size: 16,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                ))
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: Stack(
                children: [

                  Container(
                      height: 250,
                      width: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: riverprovider.getnambulrivers
                            .map(
                              (e) =>
                                  // Expanded(child: IndicatorCard(value: 100,heights: 300,color: Colors.amber,text:'fhjdhfj',)),
                                  Expanded(
                                      child: IndicatorCard(
                                value:e.river.length > 0
                                    ? toDouble(e.river.last.usv)
                                    : 0,
                                heights: 300,
                                color: Colors.amber,
                                text: e.name,
                              )),
                            )
                            .toList(),
                      )),
    
                   Positioned(
                    // bottom: riverprovider.getThreshold>200?200:riverprovider.getThreshold<0?10:riverprovider.getThreshold,
                      bottom: (riverprovider.getThreshold/200)*100 +20,
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Threshold',style: TextStyle(fontSize: 12),),
                            Text(riverprovider.getThreshold.toStringAsFixed(0),style:const TextStyle(fontWeight: FontWeight.bold),),
                          ],
                        ),
                        SizedBox(width: 20,),
                        Container(height: 2,width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.error.withOpacity(0.3),
                            
                        ),
                        ),
                      ],
                    )),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      FaIcon(
                        FontAwesomeIcons.circle,
                        color:
                            Theme.of(context).colorScheme.secondary,
                        size: 13,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Normal")
                    ],
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Row(
                    children: [
                      FaIcon(
                        FontAwesomeIcons.circle,
                        color: Theme.of(context).colorScheme.error,
                        size: 13,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Danger")
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

Future<void> getDataIsolatesHome(List args) async {
  if(Platform.isAndroid){
  BackgroundIsolateBinaryMessenger.ensureInitialized(args[1]);
  SendPort resultPort = args[0] as SendPort;
  Service ser = Service();
  List<RiverDetails> response = await ser.getdata(apicalls);
// Future<void> getDataIsolatesHome(List args) async {
//   if(Platform.isAndroid){
//   BackgroundIsolateBinaryMessenger.ensureInitialized(args[1]);
//   SendPort resultPort = args[0] as SendPort;
//   Service ser = Service();
//   List<RiverDetails> response = await ser.getdata(apicalls);

  List<dynamic> d = [response, ser.responsecode];
  Isolate.exit(resultPort, d);
  }

}
//   List<dynamic> d = [response, ser.responsecode];
//   Isolate.exit(resultPort, d);
//   }

// }
