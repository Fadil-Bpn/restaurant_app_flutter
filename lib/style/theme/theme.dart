import 'package:flutter/material.dart';
import '../color/color.dart';

class ThemeProvider extends ChangeNotifier {
  // Default theme
  bool _isDarkMode = false;
  MaterialColor _primaryColor = AppColor.green;

  bool get isDarkMode => _isDarkMode;
  MaterialColor get primaryColor => _primaryColor;

  // Toggle light/dark
  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  // Ganti warna primer
  void setPrimaryColor(MaterialColor color) {
    _primaryColor = color;
    notifyListeners();
  }

  // Dapatkan ThemeData sesuai kondisi
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
