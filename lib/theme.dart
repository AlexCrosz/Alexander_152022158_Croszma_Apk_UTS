import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  String _selectedTheme = 'Default';

  String get selectedTheme => _selectedTheme;

  void updateTheme(String newTheme) {
    _selectedTheme = newTheme;
    notifyListeners();
  }
}
