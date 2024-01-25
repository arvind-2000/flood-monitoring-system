import 'package:floodsystem/const.dart';
import 'package:flutter/material.dart';

final darktheme = ThemeData(
    appBarTheme: AppBarTheme(
   
    backgroundColor: Colors.black,
    elevation: 0
  ),
  colorScheme: ColorScheme.dark(brightness:Brightness.dark, primary:Colors.grey[900]!, onPrimary: Colors.grey[800]!, secondary: Colors.blue, onSecondary: Colors.blue[100]!, error: errorColor, onError: errorColor.withOpacity(0.3), background: Colors.black, onBackground:Colors.black, surface: Colors.white, onSurface: Colors.white)

); 

