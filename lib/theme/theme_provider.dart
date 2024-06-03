import 'package:flutter/material.dart';
import 'package:flutter_notes_app/theme/theme.dart';

class ThemeProvider with ChangeNotifier {
  //set theme to light mode initially
  ThemeData _themeData = lightMode;

  //getter method to access theme from other parts of code
  ThemeData get themeData => _themeData;

  //getter method to see if we are in dark mode or not
  bool get isDarkMode => _themeData == darkMode;

  //setter method to use the new theme
  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  //we will use this toggle in a switch later on
  void toggleTheme() {
    if (_themeData == lightMode) {
      themeData = darkMode;
    } else {
      themeData = lightMode;
    }
  }
}
