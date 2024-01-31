import 'dart:developer';
import 'dart:isolate';


import 'package:floodsystem/const.dart';
import 'package:floodsystem/models/riverdetails.dart';
import 'package:floodsystem/providers/riverprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:provider/provider.dart';

import '../../services/services.dart';
import '../../widgets/cards.dart';
import '../../widgets/tablelist.dart';

class TableScreen extends StatefulWidget {
  const TableScreen({super.key});
  static const  String routename = "Tablescreen";

  @override
  State<TableScreen> createState() => _TableScreenState();
}

class _TableScreenState extends State<TableScreen> {

  int sensor = 0;
  int i = 0;
  

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) { 
      Provider.of<NambulProvider>(context,listen: false).filterData(0, DateTime.now());
      Provider.of<NambulProvider>(context,listen: false).settableFilter(0, DateTime.now());
    });
    super.initState();  
  }


    void changesensor(int val){
        setState(() {
          sensor = val;
        });
    }


  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<NambulProvider>(context);
    // prov.getYear(prov.allrivers);
    // prov.settableFilter(0,DateTime(2024));
    return Scaffold(
      appBar: AppBar(
        title: Text("Table Data"),
        actions: [
          IconButton(onPressed: (){
                   if(sensor>2){
              changesensor(0);
            }else{
              changesensor(sensor++);
            }

          }, icon: Icon(FontAwesomeIcons.sort)),
           IconButton(onPressed: (){
            if(i>2){
              i = 0;
            }
            prov.settableFilter(i, DateTime(2024));
            i++;
            }, icon: Icon(FontAwesomeIcons.sort))
        ],
      ),

      body:prov.isLoadingall?Center(child: CircularProgressIndicator()):SingleChildScrollView(
        child: CardsContainer(

          margins: EdgeInsets.all(8),
          cardcolor: Theme.of(context).colorScheme.primary.withOpacity(0.3),
          childs: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: 
          [Expanded(
            child: ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [Center(child: Text(prov.day())),Center(child: Text('/')),...prov.tablegraph[prov.getindexs(prov.tablegraph)].river.map((e) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 8),
                child: InkWell(
                  hoverColor: Theme.of(context).colorScheme.secondary,
                  onTap: (){
                    prov.tableFilters==0?prov.settableFilter(1,DateTime(e.date.year)):prov.tableFilters==1?prov.settableFilter(2,DateTime(e.date.year,e.date.month)):prov.settableFilter(0,DateTime.now());
                  },
                  child: Container(
                  
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Text('${prov.tableFilters==0?e.date.year:prov.tableFilters==1?e.date.month:e.date.day}')),
                ),
              ))],
            ),
          )
          ,...
          prov.tablegraph.asMap().entries.map((e) => TableList(filterRiver: e.value,index: e.key,sensor:sensor)).toList()
          ]
          ,),
        ),
      )
      
    );
  }
}


