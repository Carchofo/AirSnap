// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class AppLocalizationsPl extends AppLocalizations {
  AppLocalizationsPl([String locale = 'pl']) : super(locale);

  @override
  String get app_title => 'AirSnap';

  @override
  String get home_welcome => 'Witaj w AirSnap';

  @override
  String get status_waiting => 'Oczekiwanie na sygnał Bluetooth…';

  @override
  String get status_detected => 'Wykryto sygnał!';

  @override
  String get btn_calibrate => 'Kalibruj urządzenie';

  @override
  String get section_bluetooth => 'Bluetooth';

  @override
  String get section_camera => 'Aparat';

  @override
  String get lbl_language => 'Język';

  @override
  String get lbl_settings => 'Ustawienia';

  @override
  String get btn_scan => 'Szukaj urządzeń';

  @override
  String get btn_connect => 'Połącz';

  @override
  String get btn_disconnect => 'Rozłącz';

  @override
  String get msg_no_devices => 'Nie znaleziono urządzeń w pobliżu';

  @override
  String msg_connected(String deviceName) {
    return 'Połączono z $deviceName';
  }

  @override
  String get err_bluetooth_off => 'Włącz Bluetooth, aby kontynuować';

  @override
  String get err_permission_denied => 'Odmówiono dostępu do Bluetooth';
}
