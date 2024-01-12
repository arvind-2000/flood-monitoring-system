import 'package:floodsystem/const.dart';
import 'package:floodsystem/models/river.dart';
import 'package:floodsystem/models/riverdetails.dart';
import 'package:floodsystem/widgets/cards.dart';
import 'package:floodsystem/widgets/watercard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../services/notifications.dart';

class DetailsScreen extends StatefulWidget {
  static const String routename = 'DetailsScreen';
  const DetailsScreen({super.key,

  });

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {

   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as RiverDetails;
    var textStyle = TextStyle(fontWeight: FontWeight.bold);
    var textStyle2 = TextStyle(fontWeight: FontWeight.bold,fontSize: 20);
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){},child: FaIcon(FontAwesomeIcons.arrowUpFromWaterPump)),
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text("Info",style: TextStyle(fontSize: headersize),),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        
        child: Container(
          padding: EdgeInsets.all(regularpadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(args.name.replaceFirst(' ', '\n'),style: TextStyle(fontWeight: FontWeight.bold,fontSize: headersize),),
            SizedBox(height: 20,),
            args.river.isEmpty?Text('No information',style: textStyle,):
            Container(
              child:Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: WaterCard(
                      colors:normalColor.withOpacity(0.2),
                      child: Column(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('USV',style: textStyle,),
                          SizedBox(height: 20,),
                          Text(args.river.last.usv,style: textStyle2,),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 20,),
                  Expanded(
                    child: WaterCard(
                      colors: normalColor.withOpacity(0.2),
                      child: Column(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('HV',style: textStyle,),
                          SizedBox(height: 20,),
                          Text(args.river.last.hv,style: textStyle2,),
                        ],
                      ),
                    ),
                  ),
                   SizedBox(width: 20,),
                  Expanded(
                    child: WaterCard(
                      colors:normalColor.withOpacity(0.2),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('TV',style: textStyle,),
                          SizedBox(height: 20,),
                          Text(args.river.last.tv,style: textStyle2,),
                        ],
                      ),
                    ),
                  ),
                  // ElevatedButton(onPressed:()=>showNotification( notificationsPlugin: flutterLocalNotificationsPlugin,title: appname, body: 'Water Level Raised'), child: Text('notifications'))
                ],
              ),
            ),

              ListView(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: args.river.map((e) => CardsContainer(
                  margins: EdgeInsets.symmetric(vertical: 16,),
                  paddings: EdgeInsets.all(8),
                  childs: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Text('${e.date.day}/${e.date.month}/${e.date.year}',style: TextStyle(fontSize:16,fontWeight: FontWeight.bold),),
                  SizedBox(height: 10,),
                  Text('${e.date.hour}:${e.date.minute}:${e.date.second}',style: TextStyle(fontSize:16,fontWeight: FontWeight.bold),),
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
                ],), cardcolor: Colors.white.withOpacity(0.6)),).toList()
              ),



          ],
          ),
          
        ),
      ),
    );
  }


}