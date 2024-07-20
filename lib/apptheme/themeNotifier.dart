import 'package:fitness_ui/apptheme/app_theme.dart';
import 'package:flutter/material.dart';

class ThemeModeNotifier with ChangeNotifier {
  late ThemeMode _themeMode;

  @override
  notifyListeners();

  ThemeModeNotifier(this._themeMode);

  ThemeMode get getThemeMode => _themeMode;

  void setThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    notifyListeners();
    AppTheme.setSystemUIOverlayStyle(mode);
  }
}
