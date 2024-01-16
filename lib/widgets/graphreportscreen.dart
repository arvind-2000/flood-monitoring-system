import 'package:floodsystem/providers/riverprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../const.dart';

class GraphScreenReport extends StatelessWidget {
  const GraphScreenReport({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<NambulProvider>(context);
    return Expanded(
      flex: 3,
      child: Container(
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
                child: Text('Report',style: TextStyle(fontWeight: FontWeight.bold,fontSize: headersize2),),
              ),
                SizedBox(height: 10,),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: prov.getnambulrivers.asMap().entries.map((e) => Container(
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
              ).toList(),
              ),
            ),
          ],
        )
        ),
      
    );
  }
}