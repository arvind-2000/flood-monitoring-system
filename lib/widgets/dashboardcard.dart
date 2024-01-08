import 'package:floodsystem/models/riverdetails.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../const.dart';


class DashboardCard extends StatelessWidget {
  const DashboardCard({
    super.key,
    required this.riverlist,
    required this.floodindicator
  });
  final RiverDetails riverlist;
  final floodindicator;
  @override
  Widget build(BuildContext context) {


    return Container(
      
      decoration: BoxDecoration(
       color: cardcolor,
       borderRadius: BorderRadius.circular(radius)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:  [
           Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.all(regularpadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(riverlist.name.replaceFirst(' ', '\n'),style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                  floodindicator?FaIcon(FontAwesomeIcons.triangleExclamation,color: errorColor,):SizedBox()
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              padding: EdgeInsets.all(regularpadding),
              width: double.infinity,
              decoration: BoxDecoration(
                color:  floodindicator?errorColor:normalColor,
                borderRadius: BorderRadius.circular(radius)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Water Level',style: TextStyle(fontWeight: FontWeight.bold,fontSize: regularfontsize)),
                  Text(riverlist.river.isEmpty?'No data':riverlist.river.last.usv,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14)),
                  Text('Humidity',style: TextStyle(fontWeight: FontWeight.bold,fontSize: regularfontsize)),
                  Text(riverlist.river.isEmpty?'No data':riverlist.river.last.hv,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14)),
                  SizedBox(height: 10,),
                  Text(floodindicator?alertbannertext:normalbanner,style: TextStyle(fontWeight: FontWeight.bold,fontSize: regularfontsize),),
                ],
              ),
            ),
          )
        ],
      ),
      
    );
  }
}