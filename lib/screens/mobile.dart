import 'package:floodsystem/const.dart';

import 'package:floodsystem/models/river.dart';
import 'package:floodsystem/providers/imphalriverprovider.dart';
import 'package:floodsystem/providers/irilprovider.dart';
import 'package:floodsystem/providers/riverprovider.dart';
import 'package:floodsystem/services/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/dashboardcard.dart';

class MobileScreen extends StatefulWidget {
  const MobileScreen({super.key});

  @override
  State<MobileScreen> createState() => _MobileScreenState();
}

class _MobileScreenState extends State<MobileScreen> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  @override
  Widget build(BuildContext context) {
    final nambulprov = Provider.of<NambulProvider>(context);
    final imphalprov = Provider.of<ImphalRiverProvider>(context);
    final irilprov = Provider.of<IrilRiverProvider>(context);
    
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: () {
        imphalprov.getdata();
        irilprov.getdata();
        return nambulprov.getdata();
      },
      child: Container(
        margin: const EdgeInsets.all(regularpadding),
        width: double.infinity,
        child: Column(
          children: [
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 6 / 7,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                
                if (index == 0) {
                  print(index);
                  return DashboardCard(
                    riverlist: nambulprov.getnambulrivers
                  );
                } else if (index == 1) {
                  return DashboardCard(
                    riverlist: Provider.of<ImphalRiverProvider>(context).getallimphalrivers,
                  );
                } else {
                  return DashboardCard(
                  riverlist: Provider.of<IrilRiverProvider>(context).getallirilrivers,
                  );
                }
              },
              itemCount: 3,
            ),
          ],
        ),
      ),
    );
  }
}
