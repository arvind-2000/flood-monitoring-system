import 'package:floodsystem/providers/riverprovider.dart';
import 'package:floodsystem/widgets/cards.dart';
import 'package:floodsystem/widgets/graphreportscreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../../const.dart';
import '../../widgets/linechart.dart';

class GraphScreen extends StatefulWidget {
  const GraphScreen({super.key});

  @override
  State<GraphScreen> createState() => _GraphScreenState();
}

class _GraphScreenState extends State<GraphScreen> {
     int isSensor = 0;
    ScrollController scrollController = new ScrollController();
    @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) { 
      Provider.of<NambulProvider>(context,listen: false).getdata();
    });

    super.initState();
  }


    void scrollOntap(){

      setState(() {
          scrollController.animateTo(scrollController.position.minScrollExtent, duration: Duration(milliseconds: 400), curve: Curves.easeIn);
      });
    
    }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<NambulProvider>(context);
    return SingleChildScrollView(
      controller: scrollController,
      child: Container(
        // margins: EdgeInsets.all(regularpadding),
      
        child: Column(
          children: [
            Container(
              height: 500,
              width: double.infinity,
              padding: EdgeInsets.all(regularpadding),
              margin: EdgeInsets.all(regularpadding),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(radius)
              ),
              child:prov.isLoadingall?Center(child: CircularProgressIndicator(color: Theme.of(context).colorScheme.secondary,)):Column(
                children: [
            
                  Expanded(
                    flex: 5,
                    child: Container(
                      
                      // padding: EdgeInsets.only(right: regularpadding,top: regularpadding,bottom: regularpadding),
                      child: LineCharts(isPinching: false,showcolorindicator: true,chooseSensor: isSensor,),
                    ),
                  ),
                 Expanded(child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                   children: sensorslist.asMap().entries.map((e) => InkWell(
                    onTap: (){
                      scrollOntap();
                      setState(() {
                        isSensor = e.key;
                      });
                    },
                    child: CardsContainer(childs: Text(e.value,style: TextStyle(fontWeight: FontWeight.bold),), cardcolor: Theme.of(context).colorScheme.onSecondary.withOpacity(0.3),paddings: EdgeInsets.all(8),margins: EdgeInsets.all(8),isBorder:e.key==isSensor,)),).toList(),
                 ))
                ],
              ),
            ),
            GraphScreenReport(onpress: scrollOntap,)
          ],
        ),
      ),
    );
  }
}



