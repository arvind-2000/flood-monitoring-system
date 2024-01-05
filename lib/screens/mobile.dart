import 'package:floodsystem/const.dart';
import 'package:floodsystem/dummy.dart';
import 'package:floodsystem/models/river.dart';
import 'package:flutter/material.dart';

import '../widgets/dashboardcard.dart';

class MobileScreen extends StatelessWidget {
  const MobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
     child: Container(
       margin: const EdgeInsets.all(regularpadding),
       width: double.infinity,
       child: Column(
         children: [
           GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
             crossAxisCount: 2,
             childAspectRatio: 6/7,
             crossAxisSpacing: 16,
             mainAxisSpacing: 16
    
           ), 
           shrinkWrap: true,
           itemBuilder:(context,index){
               return DashboardCard(riverlist: nambulList,);
           },
           itemCount: 3,
           ),
           
         ],
       ),
     ),
    );
  }
}

