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
  Widget build(BuildContext context) {
    final prov = Provider.of<NambulProvider>(context).getnambulrivers;
    final args = ModalRoute.of(context)!.settings.arguments as int;
    var textStyle = TextStyle(fontWeight: FontWeight.bold);
    var textStyle2 = TextStyle(fontWeight: FontWeight.bold,fontSize: 20);
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){

        
      },child: FaIcon(FontAwesomeIcons.arrowUpFromWaterPump)),
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
                      colors:Theme.of(context).colorScheme.onSecondary,
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
        
              ListView(
                controller:_listcontroller,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: prov[args].river.map((e) => CardsContainer(
                  margins: EdgeInsets.symmetric(vertical: 16,),
                  paddings: EdgeInsets.all(8),
                  childs: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Text('${getDate(e.date)}',style: TextStyle(fontSize:16,fontWeight: FontWeight.bold),),
                  SizedBox(height: 10,),
                  Text('${gethour(e.date)}',style: TextStyle(fontSize:16,fontWeight: FontWeight.bold),),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children:[
                    CardsContainer(
                      paddings: EdgeInsets.all(4),
                      cardcolor:normalColor.withOpacity(0.4),
                      childs: Text('${e.usv}')),
                      SizedBox(width: 20,),
                  CardsContainer(
                      paddings: EdgeInsets.all(4),
                      cardcolor:normalColor.withOpacity(0.4),
                      childs: Text('${e.hv}')),
                      SizedBox(width: 20,),
                      CardsContainer(
                      paddings: EdgeInsets.all(4),
                      cardcolor:normalColor.withOpacity(0.4),
                      childs: Text('${e.tv}')),
                      SizedBox(width: 20,),
                  ])
                ],), cardcolor: Theme.of(context).colorScheme.primary),).toList().sublist(0, prov[args].river.length>10?10:prov[args].river.length)
              ),
        
        
        
          ],
          ),
          
        ),
      ),
    );
  }


}