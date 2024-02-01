import 'package:floodsystem/const.dart';

import 'package:floodsystem/providers/riverprovider.dart';
import 'package:floodsystem/widgets/cards.dart';
import 'package:floodsystem/widgets/watercard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../widgets/tables.dart';



class DetailsScreen extends StatefulWidget {
  static const String routename = 'DetailsScreen';
  const DetailsScreen({super.key,

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
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) { 
 
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<NambulProvider>(context).getnambulrivers;
    final prov2 = Provider.of<NambulProvider>(context);
    final args = ModalRoute.of(context)!.settings.arguments as int;
    var textStyle = TextStyle(fontWeight: FontWeight.bold);
    var textStyle2 = TextStyle(fontWeight: FontWeight.bold,fontSize: 20);
    return Scaffold(
      // floatingActionButton: FloatingActionButton(onPressed: (){

          body: prov2.isLoadingall?Center(child: CircularProgressIndicator(),):Animate(
            effects: [FadeEffect()],
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 300,
                  floating: true,
                  pinned: true,
                  collapsedHeight: 56,
                    toolbarHeight: 56,
                      title: Text(prov[args].name,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,wordSpacing: 8,letterSpacing: 4),),
                  flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
             
                           
                    background:prov[args].river.isEmpty?Text('No information',style: textStyle,): Container(
                  
                 
                      child: Stack(
                        children: [
                         
                          Positioned.fill(child: Image.asset('assets/images/rivers.png',fit: BoxFit.cover,filterQuality: FilterQuality.medium)),
                           Container(     decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [Colors.blue.withOpacity(0.1),Theme.of(context).colorScheme.background],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter                      )
            
                      ),),
                        ],
                      ),
                    ),
                    
                  ),
              
                  
                ),
            
                    // prov2.isLoadingall?Center(child: CircularProgressIndicator(),) :Container(
                    //   color: Theme.of(context).colorScheme.background,
                    //   padding: EdgeInsets.all(regularpadding),
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     Text(prov[args].name.replaceFirst(' ', '\n'),style: TextStyle(fontWeight: FontWeight.bold,fontSize: headersize),),
                    //     SizedBox(height: 20,),
                    //     prov[args].river.isEmpty?Text('No information',style: textStyle,):
                    //     Container(
                    //       child:Row(
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //         children: [
                    //           Expanded(
                    //             child: WaterCard(
                    //               colors:Theme.of(context).colorScheme.secondary.withOpacity(0.3),
                    //               child: Column(
                    //                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //                 children: [
                    //                   Text('USV',style: textStyle,),
                    //                   SizedBox(height: 20,),
                    //                   Text(toDouble(prov[args].river.last.usv).toStringAsFixed(2),style: textStyle2,),
                    //                 ],
                    //               ),
                    //             ),
                    //           ),
                    //           SizedBox(width: 20,),
                    //           Expanded(
                    //             child: WaterCard(
                    //               colors:Theme.of(context).colorScheme.secondary.withOpacity(0.3),
                    //               child: Column(
                    //                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //                 children: [
                    //                   Text('HV',style: textStyle,),
                    //                   SizedBox(height: 20,),
                    //                   Text(toDouble(prov[args].river.last.hv).toStringAsFixed(2),style: textStyle2,),
                    //                 ],
                    //               ),
                    //             ),
                    //           ),
                    //            SizedBox(width: 20,),
                    //           Expanded(
                    //             child: WaterCard(
                    //              colors:Theme.of(context).colorScheme.secondary.withOpacity(0.3),
                    //               child: Column(
                    //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //                 children: [
                    //                   Text('TV',style: textStyle,),
                    //                   SizedBox(height: 20,),
                    //                   Text(toDouble(prov[args].river.last.tv).toStringAsFixed(2),style: textStyle2,),
                    //                 ],
                    //               ),
                    //             ),
                    //           ),
                    //           // ElevatedButton(onPressed:()=>showNotification( notificationsPlugin: flutterLocalNotificationsPlugin,title: appname, body: 'Water Level Raised'), child: Text('notifications'))
                    //         ],
                    //       ),
                    //     ),
                    //     SizedBox(height: 40,),
                    
                    //     Tables( args: args, listcontroller: _listcontroller),
                    
                    
                    
                    //   ],
                    //   ),
                      
                    // ),
                    SliverToBoxAdapter(
                      child: Container(
                        padding: EdgeInsets.all(16),
                        child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: WaterCard(
                                    colors:Theme.of(context).colorScheme.secondary.withOpacity(0.3),
                                    child: Column(
                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('USV',style: textStyle,),
                                        SizedBox(height: 20,),
                                        Text(toDouble(prov[args].river.last.usv).toStringAsFixed(2),style: textStyle2,),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(width: 20,),
                                Expanded(
                                  child: WaterCard(
                                    colors:Theme.of(context).colorScheme.secondary.withOpacity(0.3),
                                    child: Column(
                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('HV',style: textStyle,),
                                        SizedBox(height: 20,),
                                        Text(toDouble(prov[args].river.last.hv).toStringAsFixed(2),style: textStyle2,),
                                      ],
                                    ),
                                  ),
                                ),
                                 SizedBox(width: 20,),
                                Expanded(
                                  child: WaterCard(
                                   colors:Theme.of(context).colorScheme.secondary.withOpacity(0.3),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('TV',style: textStyle,),
                                        SizedBox(height: 20,),
                                        Text(toDouble(prov[args].river.last.tv).toStringAsFixed(2),style: textStyle2,),
                                      ],
                                    ),
                                  ),
                                ),
                                // ElevatedButton(onPressed:()=>showNotification( notificationsPlugin: flutterLocalNotificationsPlugin,title: appname, body: 'Water Level Raised'), child: Text('notifications'))
                              ],
                            ),
                      ),
                    ),
                    SliverToBoxAdapter(
            
                      child:Tables( args: args, listcontroller: _listcontroller),
                    )
              ],
            ),
          ),
        
      // },child: FaIcon(FontAwesomeIcons.arrowUpFromWaterPump)),
      // backgroundColor: Theme.of(context).colorScheme.background,
      //   title: Text("Info",style: TextStyle(fontSize: headersize),),
      // appBar: AppBar(
      //   backgroundColor: Theme.of(context).colorScheme.background,
      //  ),
    );
  }


}

