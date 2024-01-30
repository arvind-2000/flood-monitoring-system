import 'dart:io';

import 'package:floodsystem/const.dart';
import 'package:floodsystem/models/river.dart';
import 'package:floodsystem/models/riverdetails.dart';
import 'package:floodsystem/providers/riverprovider.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:provider/provider.dart';

import '../../widgets/cards.dart';

class TableScreen extends StatefulWidget {
  const TableScreen({super.key});
  static const  String routename = "Tablescreen";

  @override
  State<TableScreen> createState() => _TableScreenState();
}

class _TableScreenState extends State<TableScreen> {
  void ontap(){

  }


  int i = 0;
  

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) { 

      Provider.of<NambulProvider>(context,listen: false).filterData(0, DateTime.now());
      Provider.of<NambulProvider>(context,listen: false).settableFilter(0, DateTime.now());
    });
    super.initState();  
  }


  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<NambulProvider>(context);
    // prov.getYear(prov.allrivers);
    prov.settableFilter(2,DateTime(2024));
    return Scaffold(
      appBar: AppBar(
        title: Text("Table Data"),
        actions: [
          IconButton(onPressed: (){prov.sort();}, icon: Icon(FontAwesomeIcons.sort))
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
          prov.settableFilter(i, DateTime(2024));
          i++;
          if(i>2){
            i = 0;
          }
      },backgroundColor: Theme.of(context).colorScheme.secondary.withOpacity(0.5),autofocus: true,hoverElevation: 0.5,child: FaIcon(FontAwesomeIcons.filter,color: Colors.white,),tooltip: "Filter",),
      body:SingleChildScrollView(
        child: CardsContainer(

          margins: EdgeInsets.all(16),
          cardcolor: Theme.of(context).colorScheme.primary.withOpacity(0.3),
          childs: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: 
          [Expanded(
            child: ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [Center(child: Text(prov.day())),Center(child: Text('/')),...prov.tablegraph[prov.getindexs(prov.tablegraph)].river.map((e) => Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(child: Text('${prov.tableFilters==0?e.date.year:prov.tableFilters==1?e.date.month:e.date.day}')),
              ))],
            ),
          )
          ,...
          prov.tablegraph.asMap().entries.map((e) => TableList(filterRiver: e.value,index: e.key,)).toList()
          ]
          ,),
        ),
      )
      
    );
  }
}

class TableList extends StatelessWidget {
  const TableList({
    super.key,
    required this.filterRiver,
    required this.index
  });
  final int index;
  final RiverDetails filterRiver;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        
        // width: (MediaQuery.of(context).size.width-0)/3,
        color:       Theme.of(context).colorScheme.secondary.withOpacity(index%2==0?0.1:0.2),
        child: Column(
          children: [
           Center(child: Text(filterRiver.name.split(' ')[0])),
           const Padding(
             padding: EdgeInsets.symmetric(horizontal:16.0),
             child: Center(child: Text('usv')),
           ),
            ListView(
             shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children:
                filterRiver.river.map((e) => Container(
                  
                padding: EdgeInsets.all(16),
                       
               
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        
                        children: [
                        Text(toDouble( e.usv).toStringAsFixed(2)),
                      
                                          ]),

                                          
              Container(
                      height: 1,
                      width: double.infinity,
                      color: Theme.of(context).colorScheme.secondary.withOpacity(0.3),
                    ),
                    ],
                  ),
            )).toList(),
            ),

          ],
        ),
      ),
    );
  }
}

