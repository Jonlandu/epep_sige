import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class ThemeProvider extends ChangeNotifier {
  final box = GetStorage();
  static const String _darkModeKey = 'darkMode';

  bool _isDarkMode = false;
  ThemeMode _themeMode = ThemeMode.light;

  bool get isDarkMode => _isDarkMode;
  ThemeMode get themeMode => _themeMode;

  ThemeProvider() {
    //Change the dark mode value stored at initialisation
    _isDarkMode = box.read(_darkModeKey) ?? false;
    _themeMode = _isDarkMode ? ThemeMode.dark : ThemeMode.light;
  }

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    _themeMode = _isDarkMode ? ThemeMode.dark : ThemeMode.light;
    // Store the dark mode value into get_storage
    box.write(_darkModeKey, _isDarkMode);
    notifyListeners();
  }
}