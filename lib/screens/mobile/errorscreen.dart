import 'dart:developer';

import 'package:floodsystem/const.dart';
import 'package:floodsystem/providers/riverprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<NambulProvider>(context);
    log("error");
    return Scaffold(
      body: SafeArea(
        child: prov.isLoading
            ? Container(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Lottie.asset('assets/lottie/loading.json',
                    // width: 80,
                    // height: 80,
                    // animate: prov.isLoading
                    // ),
                    CircularProgressIndicator(
                        strokeWidth: 1,
                        
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 80,
                      width: 200,
                      child: Image.asset(
                        'assets/images/logodark.png',
                        fit: BoxFit.contain,
                      ),
                    ).animate().fade().then().shimmer(duration: Duration(seconds: 2)),
          
                  ],
                ))
            : ErrorLaoding(),
      ),
    );
  }
}

class ErrorLaoding extends StatelessWidget {
  const ErrorLaoding({super.key});

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<NambulProvider>(context);
    return Animate(
      // delay: Duration(seconds: 2),
      effects: [FadeEffect(duration: Duration(seconds: 2))],
      child: Container(
        width: double.infinity,
        child: Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20,),
              Text("Error with the Connection",
                  style: TextStyle(fontSize: 24)),
              Text(
                "You may not be connected to the internet\nCheck your internet settings",
                textAlign: TextAlign.center,
                style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Container(
                    margin: EdgeInsets.all(regularpadding),
                    height: 200,
                    width: 200,
                    child: Image.asset(
                      'assets/images/error.png',
                      fit: BoxFit.contain,
                    )),
              ),
          
            //   Text("Possible Issues",style:TextStyle(fontSize: 20,color: Theme.of(context).colorScheme.onPrimary,fontWeight: FontWeight.bold) ,),
            //   Text(
            //     "* Not connected to the internet\n* Error on the Server\n* Check internet settings.",
        
            //     style: TextStyle(color: Theme.of(context).colorScheme.surface,fontSize: 14),
            
            // ),
          
              GestureDetector(
                onTap: () {
                  prov.errorreconnect();
                },
                child: Container(
                 
                  // width: double.infinity,
                  margin: EdgeInsets.symmetric(
                      vertical: regularpadding, horizontal: 24),
                  padding: EdgeInsets.all(regularpadding),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Theme.of(context).colorScheme.secondary),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Refresh',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      FaIcon(FontAwesomeIcons.arrowsRotate,size: 14,)
                    ],
                  ),
                ),
              ),
        
        
        
        
        
              
            ],
          ),
        ),
      ),
    );
  }
}
