import 'package:flutter/material.dart';

import '../const.dart';
import '../models/river.dart';

class DashboardCard extends StatelessWidget {
  const DashboardCard({
    super.key,
    required this.riverlist
  });
  final List<River> riverlist;
  @override
  Widget build(BuildContext context) {
    return Container(
      
      decoration: BoxDecoration(
       color: cardcolor,
       borderRadius: BorderRadius.circular(radius)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(regularpadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(riverlist[0].name.replaceFirst(' ', '\n'),style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                  Icon(Icons.dangerous)
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
                color: normalColor,
                borderRadius: BorderRadius.circular(radius)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Humidity',style: TextStyle(fontWeight: FontWeight.bold,fontSize: regularfontsize)),
                  Text(riverlist.last.hv,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14)),
                  SizedBox(height: 10,),
                  Text('Normal',style: TextStyle(fontWeight: FontWeight.bold,fontSize: regularfontsize),),
                ],
              ),
            ),
          )
        ],
      ),
      
    );
  }
}