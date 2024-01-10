import 'package:fl_chart/fl_chart.dart';
import 'package:floodsystem/providers/imphalriverprovider.dart';
import 'package:floodsystem/services/services.dart';
import 'package:floodsystem/widgets/graphreportscreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../const.dart';
import '../../widgets/linechart.dart';

class GraphScreen extends StatelessWidget {
  const GraphScreen({super.key});

  @override
  Widget build(BuildContext context) {
  
    return Container(
      child: Column(
        children: [
          Expanded(
              flex: 5,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(regularpadding),
                margin: EdgeInsets.all(regularpadding),
                decoration: carddecoration,
                child: Column(
                  children: [

                    Expanded(
                      flex: 3,
                      child: Container(
                        // padding: EdgeInsets.only(right: regularpadding,top: regularpadding,bottom: regularpadding),
                        child: LineCharts(),
                      ),
                    ),
                    // Expanded(
                    //     child: Container(
                    //       padding: EdgeInsets.symmetric(horizontal: regularpadding),
                    //   child: Column(
                    //     children: [
                    //       Row(
                    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //         children: [
                    //           Expanded(
                    //             child: Container(
                                  
                    //               child: Column(
                    //                 crossAxisAlignment: CrossAxisAlignment.start,
                    //                 children: [
                    //                   Text(
                    //                     'Monthly',
                    //                     style: TextStyle(fontWeight: FontWeight.bold),
                                        
                    //                   ),
                    //                    Text('Jan',style: TextStyle(color: Colors.grey,fontSize: regularfontsize-4),),
                    //                   Text('200.0',style: TextStyle(fontWeight: FontWeight.bold,fontSize: headersize3),)
                    //                 ],
                    //               ),
                    //             ),
                    //           ),
                    //           Expanded(
                    //             child: Container(
                    //               child: Column(
                    //                 crossAxisAlignment: CrossAxisAlignment.start,
                    //                 children: [
                    //                   Text(
                    //                     'Yearly',
                    //                     style: TextStyle(fontWeight: FontWeight.bold),
                    //                   ),
                    //                   Text('2000',style: TextStyle(color: Colors.grey,fontSize: regularfontsize-4),),
                    //                   Text('200.0',style: TextStyle(fontWeight: FontWeight.bold,fontSize: headersize3),)
                    //                 ],
                    //               ),
                    //             ),
                    //           ),
                    //         ],
                    //       )
                    //     ],
                    //   ),
                    // ))
                  ],
                ),
              )),
          GraphScreenReport()
        ],
      ),
    );
  }
}



