// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get app_title => 'AirSnap';

  @override
  String get home_welcome => 'Willkommen bei AirSnap';

  @override
  String get status_waiting => 'Warte auf Bluetooth-Signal…';

  @override
  String get status_detected => 'Signal erkannt!';

  @override
  String get btn_calibrate => 'Gerät kalibrieren';

  @override
  String get section_bluetooth => 'Bluetooth';

  @override
  String get section_camera => 'Kamera';

  @override
  String get lbl_language => 'Sprache';

  @override
  String get lbl_settings => 'Einstellungen';

  @override
  String get btn_scan => 'Geräte suchen';

  @override
  String get btn_connect => 'Verbinden';

  @override
  String get btn_disconnect => 'Trennen';

  @override
  String get msg_no_devices => 'Keine Geräte in der Nähe gefunden';

  @override
  String msg_connected(String deviceName) {
    return 'Verbunden mit $deviceName';
  }

  @override
  String get err_bluetooth_off => 'Bitte Bluetooth aktivieren';

  @override
  String get err_permission_denied => 'Bluetooth-Berechtigung verweigert';

  @override
  String get access_title => 'One-time setup';

  @override
  String get access_body =>
      'To detect button presses from your Bluetooth headset or smartband, AirSnap needs one permission.';

  @override
  String get access_step1 => 'Tap \"Enable\" below';

  @override
  String get access_step2 => 'Find \"AirSnap Shutter\" in the list';

  @override
  String get access_step3 => 'Toggle it ON — done forever';

  @override
  String get access_btn => 'Enable in Settings';

  @override
  String get btn_skip => 'Skip — use tap only';
}
