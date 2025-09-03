import 'package:flutter/material.dart';
import '../color/color.dart';

class ThemeProvider extends ChangeNotifier {

  bool _isDarkMode = false;
  MaterialColor _primaryColor = AppColor.green;

  bool get isDarkMode => _isDarkMode;
  MaterialColor get primaryColor => _primaryColor;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  void setPrimaryColor(MaterialColor color) {
    _primaryColor = color;
    notifyListeners();
  }

  ThemeData get themeData {
    return _isDarkMode
        ? ThemeData.dark().copyWith(
            primaryColor: _primaryColor,
            colorScheme: ColorScheme.dark(primary: _primaryColor),
            appBarTheme: AppBarTheme(backgroundColor: _primaryColor),
          )
        : ThemeData.light().copyWith(
            primaryColor: _primaryColor,
            colorScheme: ColorScheme.light(primary: _primaryColor),
            appBarTheme: AppBarTheme(backgroundColor: _primaryColor),
          );
  }
}
