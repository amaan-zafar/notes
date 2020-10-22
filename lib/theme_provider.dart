import 'package:flutter/cupertino.dart';
import 'package:notes/shared_preferences.dart';

class DarkThemeProvider with ChangeNotifier {
  bool _darkTheme = false;

  DarkThemePreference darkThemePreference = DarkThemePreference();

  bool get darkTheme => _darkTheme;

  set darkTheme(bool value) {
    _darkTheme = value;
    darkThemePreference.setDarkTheme(value);
    notifyListeners();
  }
}
