import 'package:floodsystem/const.dart';
import 'package:floodsystem/providers/riverprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:provider/provider.dart';

import '../../widgets/cards.dart';
import '../../widgets/tablelist.dart';

import 'package:quiver/time.dart';

class TableScreen extends StatefulWidget {
  const TableScreen({super.key});
  static const String routename = "Tablescreen";

  @override
  State<TableScreen> createState() => _TableScreenState();
}

class _TableScreenState extends State<TableScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  int sensor = 0;
  int i = 0;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<NambulProvider>(context, listen: false)
          .filterData(0, DateTime.now());
      Provider.of<NambulProvider>(context, listen: false)
          .settableFilter(0, DateTime.now());
    });
    super.initState();
  }

  void changesensor(int val) {
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

        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
                context: context,
                builder: (c) {
                  return StatefulBuilder(builder: (context, setstates) {
                    return Container(
                      padding: EdgeInsets.all(16),
                      height: 420,
                      width: double.infinity,
                      color: Theme.of(context).colorScheme.primary,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  FaIcon(FontAwesomeIcons.filter, size: 16),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Filter",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ],
                              ),
                              IconButton(
                                onPressed: (){
                                  Future.delayed(const Duration(milliseconds: 500)).then((value) =>  Navigator.pop(context));
                                 
                                },
                                icon: FaIcon(FontAwesomeIcons.xmark)),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondary
                                    .withOpacity(0.3)),
                            child: Animate(
                                effects: [FadeEffect()],
                                delay: Duration(milliseconds: 300),
                                child: Text(
                                  prov.tableFilters == 0
                                      ? "This table is filtered based on yearly records for each river."
                                      : prov.tableFilters == 1
                                          ? "This table is filtered based on monthly records for each year."
                                          : "This table is filtered based on day for a specific month and year records for each river.",
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .surface
                                          .withOpacity(0.4)),
                                )),
                          ),
                          SizedBox(height: 20,),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setstates(() {
                                    prov.settableFilter(0, DateTime(2024));
                                  });
                                },
                                child: CardsContainer(
                                  paddings: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  childs: Text(
                                    "Year",
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                  cardcolor: Colors.transparent,
                                  isBorder: prov.tableFilters == 0,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              GestureDetector(
                                onTap: () {
                                  setstates(() {
                                    prov.settableFilter(
                                        1, DateTime(prov.graphchooseDate.year));
                                  });
                                },
                                child: CardsContainer(
                                  paddings: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  childs: Text("Months",
                                      style: TextStyle(
                                        fontSize: 16,
                                      )),
                                  cardcolor: Colors.transparent,
                                  isBorder: prov.tableFilters == 1,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              GestureDetector(
                                onTap: () {
                                  setstates(() {
                                    prov.settableFilter(
                                        2, DateTime(prov.graphchooseDate.year));
                                  });
                                },
                                child: CardsContainer(
                                  paddings: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  childs: Text("Days",
                                      style: TextStyle(
                                        fontSize: 16,
                                      )),
                                  cardcolor: Colors.transparent,
                                  isBorder: prov.tableFilters == 2,
                                ),
                              ),
                            ],
                          ),
                          prov.tableFilters == 1
                              ? Animate(
                                  effects: [FadeEffect()],
                                  child: Expanded(
                                    child: ListView(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        children: List.generate(
                                            DateTime.now().year - 2022,
                                            (index) => GestureDetector(
                                                  onTap: () {
                                                    setstates(() {
                                                      prov.settableFilter(
                                                          1,
                                                          DateTime(
                                                              index + 2023));
                                                    });
                                                  },
                                                  child: Container(
                                                    child: CardsContainer(
                                                        isBorder: prov
                                                                .graphchooseDate
                                                                .year ==
                                                            index + 2023,
                                                        cardcolor:
                                                            Colors.transparent,
                                                        paddings:
                                                            EdgeInsets.all(8),
                                                        margins:
                                                            EdgeInsets.all(8),
                                                        childs: Text(
                                                            '${index + 2023}')),
                                                  ),
                                                )).reversed.toList()),
                                  ),
                                )
                              : prov.tableFilters == 2
                                  ? Animate(
                                      effects: [FadeEffect()],
                                      child: Expanded(
                                        child: ListView(
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                            children: List.generate(
                                                12,
                                                (index) => GestureDetector(
                                                      onTap: () {
                                                        setstates(() {
                                                          prov.settableFilter(
                                                              2,
                                                              DateTime(
                                                                  prov.graphchooseDate
                                                                      .year,
                                                                  index + 1));
                                                        });
                                                      },
                                                      child: Container(
                                                        child: CardsContainer(
                                                            isBorder: prov
                                                                    .graphchooseDate
                                                                    .month ==
                                                                index + 1,
                                                            cardcolor: Colors
                                                                .transparent,
                                                            paddings:
                                                                EdgeInsets.all(
                                                                    8),
                                                            margins:
                                                                EdgeInsets.all(
                                                                    8),
                                                            childs: Text(
                                                                months[index])),
                                                      ),
                                                    ))),
                                      ),
                                    )
                                  : SizedBox(),
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Levels',style: TextStyle(fontWeight: FontWeight.bold),),
                                SizedBox(height: 10,),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setstates(() {
                                          prov.setTableSensor(0);
                                        });
                                      },
                                      child: CardsContainer(
                                        paddings: EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 8),
                                        childs: Text(
                                          "USV",
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                        cardcolor: Colors.transparent,
                                        isBorder: prov.tablesensor == 0,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setstates(() {
                                          prov.setTableSensor(1);
                                        });
                                      },
                                      child: CardsContainer(
                                        paddings: EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 8),
                                        childs: Text("Humidity",
                                            style: TextStyle(
                                              fontSize: 16,
                                            )),
                                        cardcolor: Colors.transparent,
                                        isBorder: prov.tablesensor == 1,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setstates(() {
                                          prov.setTableSensor(2);
                                        });
                                      },
                                      child: CardsContainer(
                                        paddings: EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 8),
                                        childs: Text("Temp",
                                            style: TextStyle(
                                              fontSize: 16,
                                            )),
                                        cardcolor: Colors.transparent,
                                        isBorder: prov.tablesensor == 2,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    );
                  });
                });
          },
          mouseCursor: MouseCursor.uncontrolled,
          focusColor: Theme.of(context).colorScheme.secondary,
          backgroundColor: Theme.of(context).colorScheme.secondary,
          child:const FaIcon(
            FontAwesomeIcons.filter,
            color: Colors.white,
          ),
        ),
        body: prov.isLoadingall && prov.tablegraph.isNotEmpty
            ? const Center(child: CircularProgressIndicator())
            : Animate(
              effects: const [FadeEffect()],
              child: SingleChildScrollView(
                  child: Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    
                        prov.tableFilters!=0?Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text( prov.tableFilters==1?"${prov.graphchooseDate.year}":"${months[prov.graphchooseDate.month-1]}/ ${prov.graphchooseDate.year}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                        ):SizedBox(),
                         CardsContainer(
                          margins: EdgeInsets.all(8),
                          paddings: EdgeInsets.only(top: 8),
                          cardcolor:
                              Theme.of(context).colorScheme.primary.withOpacity(0.3),
                          childs: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: ListView(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  children: [
                                      Center(child: FaIcon(FontAwesomeIcons.calendar,size: 16,)),
                                      SizedBox(height: 3,),
                                    Center(child: Text(prov.day())),
                                  
                                    ...prov.tablegraph[prov.getindexs(prov.tablegraph)]
                                        .river
                                        .map((e) => Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  vertical: 16, horizontal: 8),
                                              child: InkWell(
                                                hoverColor: Theme.of(context)
                                                    .colorScheme
                                                    .secondary,
                                                onTap: () {
                                                  prov.tableFilters == 0
                                                      ? prov.settableFilter(
                                                          1, DateTime(e.date.year))
                                                      : prov.tableFilters == 1
                                                          ? prov.settableFilter(
                                                              2,
                                                              DateTime(e.date.year,
                                                                  e.date.month))
                                                          : prov.settableFilter(
                                                              0, DateTime.now());
                                                },
                                                child: Container(
                                                    width: double.infinity,
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                        '${prov.tableFilters == 0 ? e.date.year : prov.tableFilters == 1 ? months[e.date.month - 1] : e.date.day}')),
                                              ),
                                            ))
                                  ],
                                ),
                              ),
                              ...prov.tablegraph
                                  .asMap()
                                  .entries
                                  .map((e) =>
                                      TableList(filterRiver: e.value, index: e.key))
                                  .toList()
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ));
  }
}
