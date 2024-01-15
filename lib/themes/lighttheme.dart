
import 'package:flutter/material.dart';

import '../const.dart';

final lighttheme = ThemeData(
  appBarTheme: AppBarTheme(
    
    backgroundColor: Colors.grey[300],
    elevation: 0
  ),
  colorScheme: ColorScheme.light(brightness: Brightness.light, primary: Colors.grey[100]!, onPrimary: Colors.grey[700]!, secondary: Colors.blue, onSecondary: Colors.blue[100]!, error: errorColor, onError: errorColor.withOpacity(0.3), background: Colors.grey[300]!, onBackground: Colors.grey, surface: Colors.black, onSurface: Colors.black87));