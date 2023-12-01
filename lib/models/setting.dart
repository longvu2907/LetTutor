import 'package:flutter/material.dart';

class Setting extends ChangeNotifier {
  bool isDarkMode = false;
  String language = 'English';

  void setDarkMode(bool isDarkMode) {
    this.isDarkMode = isDarkMode;
    notifyListeners();
  }

  void setLanguage(String language) {
    this.language = language;
    notifyListeners();
  }
}
