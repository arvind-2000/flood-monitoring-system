import 'package:floodsystem/const.dart';
import 'package:floodsystem/models/river.dart';
import 'package:floodsystem/models/riverdetails.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  static const String routename = 'DetailsScreen';
  const DetailsScreen({super.key,

  });

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as RiverDetails;
    var textStyle = TextStyle(fontWeight: FontWeight.bold);
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text("Info"),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(regularpadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(args.name,style: TextStyle(fontWeight: FontWeight.bold,fontSize: headersize),),
            SizedBox(height: 20,),
            args.river.isEmpty?Text('No information',style: textStyle,):
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Water Level',style: textStyle,),
                  Text(args.river.last.usv),
                  Text('Humidity',style: textStyle,),
                  Text(args.river.last.usv),
                  Text('Temperature',style: textStyle,),
                  Text(args.river.last.usv),
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