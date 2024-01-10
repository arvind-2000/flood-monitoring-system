import 'package:floodsystem/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MobileSettings extends StatelessWidget {
  const MobileSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color:cardcolor,
        borderRadius: BorderRadius.circular(radius)
      ),
      margin: EdgeInsets.all(regularpadding),
      padding: EdgeInsets.all(regularpadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
           
            children: [
              
              Text('Settings',style: TextStyle(fontSize: headersize3,fontWeight: FontWeight.bold),),
              SizedBox(width: 10,),
              FaIcon(FontAwesomeIcons.gear)
            ],
          ),
         const SizedBox(height: 20,),
         const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              
              Text('Threshold',style: TextStyle(fontSize: headersize2),),
              FaIcon(FontAwesomeIcons.penToSquare)
            ],
          ),
          TextFormField(
          initialValue: '$threshold',
          decoration: InputDecoration(
            
          ),
          
          ),

          ElevatedButton(onPressed: (){
            FlutterBackgroundService().invoke('AsForeGround');
          }, child: Padding(
            padding: const EdgeInsets.all(regularpadding),
            child: Text('AsForeGround'),
          ),),
           ElevatedButton(onPressed: (){
            FlutterBackgroundService().invoke('AsBackGround');
          }, child: Padding(
            padding: const EdgeInsets.all(regularpadding),
            child: Text('Background'),
          ),),
           ElevatedButton(onPressed: () async{
            final service = FlutterBackgroundService();
            bool isRunning = await service.isRunning();
            if(isRunning){
                service.invoke('StopService');
            }else{
              service.startService();
            }

            if(!isRunning){
              service.invoke('StopService');
              print("service stop");
            }
            else{
              print('start service');
            }
          }, child
          : Padding(
            padding: const EdgeInsets.all(regularpadding),
            child: Text('Periodic'),
          ),)
        ],
      )

    );
  }
}