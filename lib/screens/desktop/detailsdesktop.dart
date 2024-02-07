import 'package:floodsystem/const.dart';

import 'package:floodsystem/providers/riverprovider.dart';

import 'package:floodsystem/widgets/watercard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

import '../../widgets/tables.dart';



class DetailsDesktop extends StatefulWidget {
  static const String routename = 'DetailsScreenRoute';
  const DetailsDesktop({super.key,

  });

  @override
  State<DetailsDesktop> createState() => _DetailsDesktopState();
}

class _DetailsDesktopState extends State<DetailsDesktop> {
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
      appBar: AppBar(
        title:   Text(prov2.getnambulrivers[args].name),
      ),
      // floatingActionButton: FloatingActionButton(onPressed: (){

          body: prov2.allrivers.isEmpty?Center(child: CircularProgressIndicator(),):Animate(
            effects: [FadeEffect()],
            child: SingleChildScrollView(
           
              child:Container(
                padding: EdgeInsets.all(30),
                child: Column(
                  children: [
                    // Container(
                        
                       
                    //         child: Stack(
                    //           children: [
                               
                    //             Positioned.fill(child: Image.asset('assets/images/rivers.png',fit: BoxFit.cover,filterQuality: FilterQuality.medium)),
                    //              Container(     decoration: BoxDecoration(
                    //           gradient: LinearGradient(colors: [Theme.of(context).colorScheme.background,Colors.blue.withOpacity(0.2),Theme.of(context).colorScheme.background],
                    //           begin: Alignment.topLeft,
                    //           end: Alignment.bottomLeft                       )
                                
                    //         ),),
                    //           ],
                    //         ),
                    //       ),
                        
                                
                          Container(
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
                                            Text("${toDouble(prov[args].river.last.usv).toStringAsFixed(0)} $levelunit",style: textStyle2,),
                                          ],
                                        ),
                                      ).animate().shimmer(duration: Duration(seconds: 2)),
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
                                            Text("${toDouble(prov[args].river.last.hv).toStringAsFixed(0)} $humiditylevel",style: textStyle2,),
                                          ],
                                        ),
                                      ).animate().shimmer(duration: Duration(seconds: 2)),
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
                                            Text("${toDouble(prov[args].river.last.tv).toStringAsFixed(0)} $templevel",style: textStyle2,),
                                          ],
                                        ),
                                      ).animate().shimmer(duration: Duration(seconds: 2)),
                                    ),
                                    // ElevatedButton(onPressed:()=>showNotification( notificationsPlugin: flutterLocalNotificationsPlugin,title: appname, body: 'Water Level Raised'), child: Text('notifications'))
                                  ],
                                ),
                          ),
                         
                                
                     Tables( args: args, listcontroller: _listcontroller),
                  ],
                ),
              ),
                    
              
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

