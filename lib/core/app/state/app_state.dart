import 'package:cost_o_matic/ui/utils/styles/app_theme.dart';
import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  ThemeType _themeType = ThemeType.Light;
  ThemeType get themeType => _themeType;

  
}
