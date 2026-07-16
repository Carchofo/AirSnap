// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Afrikaans (`af`).
class AppLocalizationsAf extends AppLocalizations {
  AppLocalizationsAf([String locale = 'af']) : super(locale);

  @override
  String get app_title => 'AirSnap';

  @override
  String get home_welcome => 'Welkom by AirSnap';

  @override
  String get status_waiting => 'Wag vir Bluetooth-sein…';

  @override
  String get status_detected => 'Sein opgespoor!';

  @override
  String get btn_calibrate => 'Kalibreer toestel';

  @override
  String get section_bluetooth => 'Bluetooth';

  @override
  String get section_camera => 'Kamera';

  @override
  String get lbl_language => 'Taal';

  @override
  String get lbl_settings => 'Instellings';

  @override
  String get btn_scan => 'Soek vir toestelle';

  @override
  String get btn_connect => 'Verbind';

  @override
  String get btn_disconnect => 'Ontkoppel';

  @override
  String get msg_no_devices => 'Geen toestelle gevind in die omgewing nie';

  @override
  String msg_connected(String deviceName) {
    return 'Verbind met $deviceName';
  }

  @override
  String get err_bluetooth_off => 'Aktiveer Bluetooth om voort te gaan';

  @override
  String get err_permission_denied => 'Bluetooth-toestemming geweier';

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
