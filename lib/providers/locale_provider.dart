import 'package:flutter/material.dart';

/// Manages the active [Locale] for the whole app.
/// Exposes [setLocale] so any screen can switch languages at runtime.
class LocaleProvider extends ChangeNotifier {
  Locale _locale = const Locale('en');

  Locale get locale => _locale;

  void setLocale(Locale locale) {
    if (_locale == locale) return;
    _locale = locale;
    notifyListeners();
  }

  void clearLocale() {
    _locale = const Locale('en');
    notifyListeners();
  }
}
