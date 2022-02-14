import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
   ThemeMode themeMode = ThemeMode.system;

  bool get isDarkMode {
    if (themeMode == ThemeMode.system) {
      final brightness = SchedulerBinding.instance!.window.platformBrightness;
      return brightness == Brightness.dark;
    } else {
      return themeMode == ThemeMode.dark;
    }
  }

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class AppThemes {
  static final darkTheme = ThemeData(
    fontFamily: "Roboto",
    backgroundColor: const Color(0xFF212121),
    scaffoldBackgroundColor: Colors.grey.shade900,
    primaryColor: Colors.black,
    colorScheme: const ColorScheme.dark(),
  );
  static final lightTheme = ThemeData(
    fontFamily: "Roboto",
    backgroundColor: const Color(0xFFE5E5E5),
    scaffoldBackgroundColor: const Color(0xFFE5E5E5),
    primaryColor: Colors.white,
    colorScheme: const ColorScheme.light(),
  );

  
}
