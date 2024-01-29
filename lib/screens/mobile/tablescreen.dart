import 'dart:io';

import 'package:floodsystem/const.dart';
import 'package:floodsystem/models/river.dart';
import 'package:floodsystem/models/riverdetails.dart';
import 'package:floodsystem/providers/riverprovider.dart';
import 'package:floodsystem/widgets/tables.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/retry.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

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



  late bool isWebOrDesktop;

  List<GridColumn> _getColumns() {
    List<GridColumn> columns;
    columns = <GridColumn>[
      GridColumn(
          columnName: 'customerName',
          width: isWebOrDesktop ? 180 : 140,
          label: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(8.0),
            child: const Text(
              'Customer Name',
              overflow: TextOverflow.ellipsis,
            ),
          )),
      GridColumn(
          columnName: 'city',
          width: isWebOrDesktop ? 140 : 100,
          label: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(8.0),
            child: const Text(
              'City',
              overflow: TextOverflow.ellipsis,
            ),
          )),
      GridColumn(
          columnName: 'orderId',
          width: isWebOrDesktop ? 140 : 90,
          label: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.all(8.0),
            child: const Text(
              'Order ID',
              overflow: TextOverflow.ellipsis,
            ),
          )),
      GridColumn(
          columnName: 'orderDate',
          width: isWebOrDesktop ? 140 : 110,
          label: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.all(8.0),
            child: const Text(
              'Order Date',
              overflow: TextOverflow.ellipsis,
            ),
          )),
      GridColumn(
          columnName: 'product',
          width: isWebOrDesktop ? 160 : 100,
          label: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(8.0),
            child: const Text(
              'Product',
              overflow: TextOverflow.ellipsis,
            ),
          )),
      GridColumn(
          columnName: 'productId',
          width: isWebOrDesktop ? 150 : 100,
          label: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.all(8.0),
            child: const Text(
              'Product ID',
              overflow: TextOverflow.ellipsis,
            ),
          )),
      GridColumn(
          columnName: 'quantity',
          width: isWebOrDesktop ? 150 : 90,
          label: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.all(8.0),
            child: const Text(
              'Quantity',
              overflow: TextOverflow.ellipsis,
            ),
          )),
      GridColumn(
          columnName: 'unitPrice',
          width: isWebOrDesktop ? 140 : 100,
          label: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.all(8.0),
            child: const Text(
              'Unit Price',
              overflow: TextOverflow.ellipsis,
            ),
          )),
    ];
    return columns;
  }

  Color _getHeaderCellBackgroundColor() {
    return Theme.of(context).colorScheme.brightness == Brightness.light
        ? const Color(0xFFF1F1F1)
        : const Color(0xFF3A3A3A);
  }

  Widget _getWidgetForStackedHeaderCell(String title) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        alignment: Alignment.centerLeft,
        child: Text(title));
  }

  List<StackedHeaderRow> _getStackedHeaderRows() {
    List<StackedHeaderRow> stackedHeaderRows;
    stackedHeaderRows = <StackedHeaderRow>[
      StackedHeaderRow(cells: <StackedHeaderCell>[
        StackedHeaderCell(columnNames: <String>[
          'customerName',
          'city',
        ], child: _getWidgetForStackedHeaderCell('Customer Details')),
        StackedHeaderCell(columnNames: <String>[
          'orderId',
          'orderDate',
        ], child: _getWidgetForStackedHeaderCell('Order Details')),
        StackedHeaderCell(columnNames: <String>[
          'product',
          'productId',
          'quantity',
          'unitPrice'
        ], child: _getWidgetForStackedHeaderCell('Product Details'))
      ])
    ];
    return stackedHeaderRows;
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) { 

      Provider.of<NambulProvider>(context,listen: false).filterData(0, DateTime.now());
    });
    super.initState();
    isWebOrDesktop = false;
  }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<NambulProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Table Data"),
        actions: [
          IconButton(onPressed: (){prov.sort();}, icon: Icon(FontAwesomeIcons.sort))
        ],
      ),
      body:DataTable(columns: [DataColumn(label: Text("Year")),...prov.allrivers.map((e) => DataColumn(label: Text(e.name))).toList()], rows: [])
      
    );
  }
}

class TableList extends StatelessWidget {
  const TableList({
    super.key,
    required this.filterRiver
  });
  final RiverDetails filterRiver;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: (MediaQuery.of(context).size.width-0)/3,
        color: Theme.of(context).colorScheme.primary,
        child: Column(
          children: [
           Text(filterRiver.name),
           const Padding(
             padding: EdgeInsets.symmetric(horizontal:16.0),
             child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      Text('usv'),
                      Text('hv'),
                      Text('tv')
             ], 
             ),
           ),
            Expanded(
              child: ListView(
                children:
                  filterRiver.river.map((e) => Container(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    Wrap(
        
                      
                      children: [
                        Text(toDouble( e.usv).toStringAsFixed(2)),
                        Text(toDouble( e.hv).toStringAsFixed(2)),
                        Text(toDouble( e.tv).toStringAsFixed(2))
                      ],
                    ),
                                      ]), color: Theme.of(context).colorScheme.primary)).toList(),
              ),

            ),
          ],
        ),
      ),
    );
  }
}

