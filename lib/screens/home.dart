import 'package:floodsystem/const.dart';
import 'package:floodsystem/services/services.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Service ser = Service();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flood Monitoring System'),
      ),
      body: Center(
        child: ElevatedButton(onPressed: (){
          ser.getdata(nambulriver);
        }, child: Text('get Data')),
      ),
    );
  }
}