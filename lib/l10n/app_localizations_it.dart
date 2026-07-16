// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get app_title => 'AirSnap';

  @override
  String get home_welcome => 'Benvenuto su AirSnap';

  @override
  String get status_waiting => 'In attesa del segnale Bluetooth…';

  @override
  String get status_detected => 'Segnale rilevato!';

  @override
  String get btn_calibrate => 'Calibra dispositivo';

  @override
  String get section_bluetooth => 'Bluetooth';

  @override
  String get section_camera => 'Fotocamera';

  @override
  String get lbl_language => 'Lingua';

  @override
  String get lbl_settings => 'Impostazioni';

  @override
  String get btn_scan => 'Cerca dispositivi';

  @override
  String get btn_connect => 'Connetti';

  @override
  String get btn_disconnect => 'Disconnetti';

  @override
  String get msg_no_devices => 'Nessun dispositivo trovato nelle vicinanze';

  @override
  String msg_connected(String deviceName) {
    return 'Connesso a $deviceName';
  }

  @override
  String get err_bluetooth_off => 'Attiva il Bluetooth per continuare';

  @override
  String get err_permission_denied => 'Autorizzazione Bluetooth negata';

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
