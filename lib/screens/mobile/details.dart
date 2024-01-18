import 'package:floodsystem/const.dart';

import 'package:floodsystem/providers/riverprovider.dart';
import 'package:floodsystem/widgets/cards.dart';
import 'package:floodsystem/widgets/watercard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';



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
      Provider.of<NambulProvider>(context,listen: false).getdata();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<NambulProvider>(context).getnambulrivers;
    final prov2 = Provider.of<NambulProvider>(context);
    
    if(!prov2.isLoadingall){
      prov2.getdata();
    }
    final args = ModalRoute.of(context)!.settings.arguments as int;
    var textStyle = TextStyle(fontWeight: FontWeight.bold);
    var textStyle2 = TextStyle(fontWeight: FontWeight.bold,fontSize: 20);
    return Scaffold(
      // floatingActionButton: FloatingActionButton(onPressed: (){

        
      // },child: FaIcon(FontAwesomeIcons.arrowUpFromWaterPump)),
      // backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text("Info",style: TextStyle(fontSize: headersize),),
        backgroundColor: Theme.of(context).colorScheme.background,
       ),
      body: SingleChildScrollView(
        
        child: Container(
          color: Theme.of(context).colorScheme.background,
          padding: EdgeInsets.all(regularpadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(prov[args].name.replaceFirst(' ', '\n'),style: TextStyle(fontWeight: FontWeight.bold,fontSize: headersize),),
            SizedBox(height: 20,),
            prov[args].river.isEmpty?Text('No information',style: textStyle,):
            Container(
              child:Row(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                          Text(prov[args].river.last.usv,style: textStyle2,),
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
                          Text(prov[args].river.last.hv,style: textStyle2,),
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
                          Text(prov[args].river.last.tv,style: textStyle2,),
                        ],
                      ),
                    ),
                  ),
                  // ElevatedButton(onPressed:()=>showNotification( notificationsPlugin: flutterLocalNotificationsPlugin,title: appname, body: 'Water Level Raised'), child: Text('notifications'))
                ],
              ),
            ),
            SizedBox(height: 40,),

            CardsContainer(
              cardcolor: Theme.of(context).colorScheme.primary.withOpacity(0.5),
              
              childs: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: Text("Date/time",textAlign: TextAlign.center,)),
                        Expanded(child: Text("Water\nLevel",textAlign: TextAlign.center,)),
                        Expanded(child: Text("humidity",textAlign: TextAlign.center,)),
                        Expanded(child: Text("Temp",textAlign: TextAlign.center,)),
                      ],
                    ),
                  ),
                    prov2.isLoadingall? Center(child: CircularProgressIndicator(color: Theme.of(context).colorScheme.secondary,)):args>=prov2.rivergraph.length?SizedBox():ListView(
                      controller:_listcontroller,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: prov2.allrivers[args].river.asMap().entries.map((e) => Container(
                    
                        padding: EdgeInsets.all(8),
                        child:Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center ,
                            
                            children: [
                              Text('${getDate(e.value.date)}',style: TextStyle(fontSize:12,fontWeight: FontWeight.bold),),
                            
                              Text('${gethour(e.value.date)}',style: TextStyle(fontSize:12,),),
                           
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(
                            
                            padding: EdgeInsets.all(4),
                           
                            child: Text('${e.value.usv}',textAlign: TextAlign.center,)),
                        ),
                        
                             Expanded(
                               child: Container(
                                                   
                                                   padding: EdgeInsets.all(4),
                                                  
                                                   child: Text('${e.value.hv}',textAlign: TextAlign.center,)),
                             ),
                          
                     Expanded(
                       child: Container(
                            
                            padding: EdgeInsets.all(4),
                           
                            child: Text('${e.value.tv}',textAlign: TextAlign.center,)),
                     ),
                         
                      ],), color:toDouble(e.value.usv)>prov2.getThreshold?Theme.of(context).colorScheme.error.withOpacity(0.2) :e.key%2==0?Theme.of(context).colorScheme.secondary.withOpacity(0.1):Theme.of(context).colorScheme.secondary.withOpacity(0.2)),).toList().sublist(0, prov2.allrivers[args].river.length>10?10:prov2.allrivers[args].river.length)
                    ),
                ],
              ),
            ),
        
        
        
          ],
          ),
          
        ),
      ),
    );
  }


}