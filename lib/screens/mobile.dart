import 'package:floodsystem/const.dart';
import 'package:floodsystem/providers/imphalriverprovider.dart';
import 'package:floodsystem/providers/irilprovider.dart';
import 'package:floodsystem/providers/riverprovider.dart';
import 'package:floodsystem/screens/mobile/details.dart';
import 'package:floodsystem/services/notifications.dart';
import 'package:floodsystem/widgets/cards.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../widgets/Indicatorcard.dart';
import '../widgets/dashboardcard.dart';

class MobileScreen extends StatefulWidget {
  const MobileScreen({super.key,
required this.onchanged});
  final onchanged;
  @override
  State<MobileScreen> createState() => _MobileScreenState();

}

class _MobileScreenState extends State<MobileScreen> {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  @override
  Widget build(BuildContext context) {
    final riverprovider = Provider.of<NambulProvider>(context);
    // final imphalprov = Provider.of<ImphalRiverProvider>(context);
    // final irilprov = Provider.of<IrilRiverProvider>(context);
    
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      backgroundColor: Theme.of(context).colorScheme.secondary,
      onRefresh: () {
      

        showNotification(notificationsPlugin: _flutterLocalNotificationsPlugin, title: "Flood System", body: 'Water Level Raised:200');
        return riverprovider.getdata();
      },
      child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(regularpadding),
          width: double.infinity,
          child: Column(
            children: [
              SizedBox(height: 10,),
            Container(
              height:350,
              width: double.infinity,
              // margin: EdgeInsets.all(8),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(8)
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Indicator",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                      GestureDetector(
                        onTap: (){
                          
                          widget.onchanged(1);
                        },
                        child: Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Theme.of(context).colorScheme.secondary
                          ),
                          child: Row(
                            children: [Text('Charts',style: TextStyle(fontSize: 16,color: Colors.white),),
                            SizedBox(width: 10,),
                            FaIcon(FontAwesomeIcons.arrowRight,size: 16,color: Colors.white,)],
                          ),
                        ),
                      )
                    ],
                  ),
                SizedBox(height: 10,),
                  Expanded(
                        child: Stack(

                          children: [
                           
                            Container(
                              height: 250,
                              width: double.infinity,
                             
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children:riverprovider.getnambulrivers.map((e) => 
                                    // Expanded(child: IndicatorCard(value: 100,heights: 300,color: Colors.amber,text:'fhjdhfj',)),
                                     Expanded(child: IndicatorCard(value: e.river.length>0?toDouble(e.river.last.usv):0,heights: 300,color: Colors.amber,text: e.name,)),
                                ).toList(),
                              )
                            ),
                             Positioned(
                              bottom: 200,
                              
                              child: Container(height: 5,width: MediaQuery.of(context).size.width, 
                              decoration: BoxDecoration(
                                      color: Theme.of(context).colorScheme.error.withOpacity(0.4),
                                
                              ),
                              )),
                          ],
                        ),
                      )
                    
                  
                ],
              ),
            ),
            SizedBox(height: 60,),
              ListView.builder(
                       
                shrinkWrap: true,  
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  
                    return CardsContainer(
                      cardcolor: Theme.of(context).colorScheme.primary,
                      paddings: EdgeInsets.all(16),
                      margins: EdgeInsets.symmetric(vertical: 8),
                      childs: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(riverprovider.getnambulrivers[index].name.replaceFirst(' ', '\n'),style: TextStyle(height: 1,fontWeight: FontWeight.bold,fontSize: 20),),
                            GestureDetector(
                              onTap: (){
                                 Navigator.pushNamed(context,DetailsScreen.routename,arguments:index);
                              },
                              child: CardsContainer(
                                paddings: EdgeInsets.all(16),
                                childs: FaIcon(FontAwesomeIcons.arrowRight,size: 16,color: Colors.white,),cardcolor: Theme.of(context).colorScheme.secondary,),
                            )
                          ],
                        ),
                          SizedBox(height: 30,),
                         Text(riverprovider.getnambulrivers[index].river.isEmpty?'No data':'${DateFormat('dd/mm/yyyy').format(riverprovider.getnambulrivers[index].river.last.date)}\n${DateFormat('h:mm a').format(riverprovider.getnambulrivers[index].river.last.date)}',style: TextStyle(height: 1,fontSize: 12),),
                        SizedBox(height: 10,),
                        riverprovider.getnambulrivers[index].river.isEmpty?SizedBox():Row(
                          
                          
                          children:[
                            CardsContainer(
                              paddings: EdgeInsets.all(8),
                              childs: Column(children: [Text('Lev',style: TextStyle(color: Theme.of(context).colorScheme.secondary.withOpacity(0.4))),Text(riverprovider.getnambulrivers[index].river.last.usv,style: TextStyle(fontWeight: FontWeight.bold,color: Theme.of(context).colorScheme.secondary)),],), cardcolor: Theme.of(context).colorScheme.secondary.withOpacity(0.2)),
                             SizedBox(width: 20,),
                               CardsContainer(
                              paddings: EdgeInsets.all(8),
                              childs: Column(children: [Text('Humidity',style: TextStyle(color: Theme.of(context).colorScheme.secondary.withOpacity(0.4)),),Text(riverprovider.getnambulrivers[index].river.last.hv,style: TextStyle(fontWeight: FontWeight.bold,color: Theme.of(context).colorScheme.secondary)),],), cardcolor: Theme.of(context).colorScheme.secondary.withOpacity(0.2)),
                             SizedBox(width: 20,),
                                   
                                     CardsContainer(
                              paddings: EdgeInsets.all(8),
                              childs: Column(children: [Text('Temp',style: TextStyle(color: Theme.of(context).colorScheme.secondary.withOpacity(0.4))),Text(riverprovider.getnambulrivers[index].river.last.tv,style: TextStyle(fontWeight: FontWeight.bold,color: Theme.of(context).colorScheme.secondary)),],), cardcolor: Theme.of(context).colorScheme.secondary.withOpacity(0.2)),
                             SizedBox(width: 20,),
                                   
                                   
                          ],
                        )
                      ],
                    )
                    
                    );
               
                },
                itemCount: riverprovider.getnambulrivers.length,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

