import 'package:floodsystem/providers/riverprovider.dart';
import 'package:floodsystem/screens/mobile/tablescreen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../const.dart';

class GraphScreenReport extends StatelessWidget {
  const GraphScreenReport({
    super.key,
    required this.onpress
  });
  final Function onpress;
  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<NambulProvider>(context);
    return Container(
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.all(regularpadding),
      // padding: EdgeInsets.all(regularpadding),
      width: double.infinity,
      decoration:BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(8)
      ),
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            Padding(
              padding: const EdgeInsets.all(16), 
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Report',style: TextStyle(fontWeight: FontWeight.bold,fontSize: headersize2),),
                     
                            //   Text('Table',style: TextStyle(fontSize: 16,color: Colors.white),),
                            // SizedBox(width: 10,),
                            IconButton(onPressed: (){
                              Navigator.pushNamed(context, TableScreen.routename);
                            },icon: FaIcon(FontAwesomeIcons.arrowRight,size: 16,color: Theme.of(context).colorScheme.secondary,))],
                          
                
              ),
            ),
              SizedBox(height: 10,),
          ListView(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: prov.getnambulrivers.asMap().entries.map((e) => GestureDetector(
              onTap: (){
               
                  prov.rivergraphs(e.key);
                   onpress();
              },
              child: Container(
                color: Theme.of(context).colorScheme.secondary.withOpacity(e.key%2==0?0.2:0.3),
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Text(e.value.name),
                     SizedBox(height: 10,),
                     Padding(
                       padding: const EdgeInsets.symmetric(horizontal: 16),
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Text('${e.value.river.last.usv}'),
                           Text('${e.value.river.last.hv}'),
                           Text('${e.value.river.last.tv}'),
                         ],
                       ),
                     )
                     
                     ],
                 ),
              ),
            ),
          ).toList(),
          ),
        ],
      )
      );
  }
}