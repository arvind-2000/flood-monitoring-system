import 'dart:convert';

import 'package:floodsystem/const.dart';
import 'package:http/http.dart' as http;
class Service{
  
  Future getdata(String url) async{
    try{

    var response = await http.get(Uri.parse(url));
    if(response.statusCode == 200){
      var data = jsonDecode(response.body) as Map<String,dynamic>;
      print(data['feeds'].length);
    }else{
      print('Error connecting to the server');
    }

    }
    catch(e){
      print('ebngb');
    }
  

  
  }
}