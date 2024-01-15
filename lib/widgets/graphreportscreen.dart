import 'package:flutter/material.dart';

import '../const.dart';

class GraphScreenReport extends StatelessWidget {
  const GraphScreenReport({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Container(
        margin: EdgeInsets.all(regularpadding),
        padding: EdgeInsets.all(regularpadding),
        width: double.infinity,
        decoration:BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(8)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Report',style: TextStyle(fontWeight: FontWeight.bold,fontSize: headersize2),),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Nambul river'),
                Text('200')],
            ),
            Divider(),
            SizedBox(height: 10,),    
                   Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Imphal river'),
                Text('200')],
            ),
            Divider(),
            SizedBox(height: 10,),  
                   Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Iril river'),
                Text('200')],
            ),
          ],
        ),
      ),
    );
  }
}