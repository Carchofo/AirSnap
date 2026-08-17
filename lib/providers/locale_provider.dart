import 'package:flutter/material.dart';

class LocaleProvider extends ChangeNotifier {
  Locale? _locale; // null = usa el idioma del sistema

  Locale? get locale => _locale;

  void setLocale(Locale locale) {
    if (_locale == locale) return;
    _locale = locale;
    notifyListeners();
  }

  void clearLocale() {
    _locale = null;
    notifyListeners();
  }
}
