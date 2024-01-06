import 'package:floodsystem/const.dart';
import 'package:flutter/material.dart';
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
          Row(
           
            children: [
              
              Text('Settings',style: TextStyle(fontSize: headersize3,fontWeight: FontWeight.bold),),
              SizedBox(width: 10,),
              FaIcon(FontAwesomeIcons.gear)
            ],
          ),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              
              Text('Threshold',style: TextStyle(fontSize: headersize2),),
              FaIcon(FontAwesomeIcons.penToSquare)
            ],
          ),
          TextFormField(
          initialValue: '0.0',
          decoration: InputDecoration(
            
          ),
          
          )
        ],
      )
    );
  }
}