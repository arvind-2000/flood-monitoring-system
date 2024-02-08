import 'dart:developer';
import 'dart:io';
import 'dart:isolate';


import 'package:floodsystem/providers/riverprovider.dart';
import 'package:floodsystem/widgets/cards.dart';
import 'package:floodsystem/widgets/graphreportscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';

import '../../const.dart';
import '../../models/riverdetails.dart';
import '../../services/services.dart';
import '../../widgets/linechart.dart';

class GraphScreen extends StatefulWidget {
  const GraphScreen({super.key});
  static const String routename = "Graphscreen";
  @override
  State<GraphScreen> createState() => _GraphScreenState();
}

class _GraphScreenState extends State<GraphScreen> {
  ScrollController scrollController = new ScrollController();
  @override
  void initState() {

// if (Platform.isAndroid) {
//       RootIsolateToken? rootIsolateToken ;
//       rootIsolateToken= RootIsolateToken.instance!;
//       isolatesRun(rootIsolateToken);
// }

  WidgetsBinding.instance.addPostFrameCallback((timeStamp) { 
    Provider.of<NambulProvider>(context,listen: false).getdata();
  });

    super.initState();
  }

  // Future<void> isolatesRun(RootIsolateToken? rootIsolateToken) async {
  //   Service ser = Service();
  //   ReceivePort receivePort = ReceivePort();

  //   List<RiverDetails> rivers = [];
  //   await Isolate.spawn(getDataIsolates,[receivePort.sendPort,rootIsolateToken]);
  //   final response = await receivePort.first;
  //   // print("In listen isolates:${response[1]}");

  //   try{
  //     Provider.of<NambulProvider>(context,listen: false).setfromIsolates(response[0],response[1]);

  //   }catch(e){
  //     log('Error in isolates:${response[0].length}');
  //   }
  



  // }

  // void scrollOntap() {
  //   setState(() {
  //     // scrollController.animateTo(scrollController.position.minScrollExtent,
  //     //     duration: Duration(milliseconds: 400), curve: Curves.easeIn);
  //   });
  // }

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
      body: SingleChildScrollView(
        controller: scrollController,
        child: Container(
          // margins: EdgeInsets.all(regularpadding),
      
          child: Column(
            children: [
              Container(
                height:450,
                width: double.infinity,
                padding: EdgeInsets.all(regularpadding),
                margin: EdgeInsets.all(regularpadding),
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(8)),
                child: prov.rivergraph.isEmpty
                    ? Center(
                        child: CircularProgressIndicator(
                        color: Theme.of(context).colorScheme.secondary,
                      ))
                    : Column(
                        children: [
                          Expanded(
                            flex: 5,
                            child: Container(
                              // padding: EdgeInsets.only(right: regularpadding,top: regularpadding,bottom: regularpadding),
                              child: LineCharts(  
                                  isPinching: false, showcolorindicator: true),
                            ),
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
      
                          //  Container(
      
                          //    child: Row(
                          //     children: [
                          //           DropdownMenu(
                          //                  menuStyle: MenuStyle(
                          //             backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.primary)
                          //           ),
                          //           menuHeight: 200,
                          //             initialSelection: 0,
                          //             enableFilter: true,
                          //             textStyle: TextStyle(color: Theme.of(context).colorScheme.onSecondary),
                          //             onSelected: (value) {
                          //               prov.graphChooseDates(DateTime(prov.graphChooseDate.year,value!+1));
                          //             },
                          //             dropdownMenuEntries:months.asMap().entries.map((e) => DropdownMenuEntry(
      
                          //               value: e.key, label: e.value)).toList()),
      
                          //               DropdownMenu(
                          //           menuStyle: MenuStyle(
                          //             backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.primary)
                          //           ),
                          //             enableFilter: true,
                          //             initialSelection:0,
      
                          //              textStyle: TextStyle(color: Theme.of(context).colorScheme.onSecondary),
                          //             onSelected: (value) {
                          //               prov.graphChooseDates(DateTime(value!,prov.graphChooseDate.month));
                          //             },
                          //             dropdownMenuEntries:List.generate(DateTime.now().year-2022, (index) => DropdownMenuEntry(
                          //               style: ButtonStyle(
      
                          //               ),
                          //               // labelWidget: Text('${prov.graphChooseDate.year}'),
                          //               value:2023+index, label: '${2023+index}')).toList())
                          //               // SelectDay(text: 'Month'),
                          //               // SelectDay(text: 'Year'),
      
                          //     ],
                          //    ),
                          //  ) 
                        ],
                      ),
              ),

              prov.isLoadingall?SizedBox():
              GraphScreenReport(
                // onpress: scrollOntap,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SelectDay extends StatelessWidget {
  const SelectDay({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 8,
      ),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          border: BorderDirectional(
              bottom:
                  BorderSide(color: Theme.of(context).colorScheme.secondary))),
      child: Column(
        children: [
          Text(text),
        ],
      ),
    );
  }
}

// Future<void> getDataIsolates(List args) async{

//   if(Platform.isAndroid){
//   BackgroundIsolateBinaryMessenger.ensureInitialized(args[1]);
//   NambulProvider prov = NambulProvider();
//   SendPort resultPort = args[0] as SendPort;
//   Service ser = Service();
//   List<RiverDetails> response = await ser.getdata(apicalls);



//   List<dynamic> d = [prov.getDays(response, DateTime(2024)), ser.responsecode];
//   Isolate.exit(resultPort, d);
//   }

// }
