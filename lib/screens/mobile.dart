import 'package:floodsystem/const.dart';
import 'package:floodsystem/providers/imphalriverprovider.dart';
import 'package:floodsystem/providers/irilprovider.dart';
import 'package:floodsystem/providers/riverprovider.dart';
import 'package:floodsystem/screens/mobile/details.dart';
import 'package:floodsystem/services/notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

import '../widgets/dashboardcard.dart';

class MobileScreen extends StatefulWidget {
  const MobileScreen({super.key});

  @override
  State<MobileScreen> createState() => _MobileScreenState();
}

class _MobileScreenState extends State<MobileScreen> {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  @override
  Widget build(BuildContext context) {
    final riverprovider = Provider.of<NambulProvider>(context);
    // final imphalprov = Provider.of<ImphalRiverProvider>(context);
    // final irilprov = Provider.of<IrilRiverProvider>(context);
    
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: () {
        // imphalprov.getdata();
        // irilprov.getdata();
        showNotification(notificationsPlugin: _flutterLocalNotificationsPlugin, title: "Flood System", body: 'Water Level Raised:200');
        return riverprovider.getdata();
      },
      child: Container(
        margin: const EdgeInsets.all(regularpadding),
        width: double.infinity,
        child: Column(
          children: [
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 6 / 9,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                
                  return InkWell(
                    onTap: (){
                      Navigator.pushNamed(context,DetailsScreen.routename,arguments: riverprovider.getnambulrivers[index]);
                    },
                    child: DashboardCard(
                      riverlist: riverprovider.getnambulrivers[index],
                      floodindicator: riverprovider.floodindicator[index],
                    ),
                  );
             
              },
              itemCount: riverprovider.getnambulrivers.length,
            ),
          ],
        ),
      ),
    );
  }
}
