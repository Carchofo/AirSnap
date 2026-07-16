// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Danish (`da`).
class AppLocalizationsDa extends AppLocalizations {
  AppLocalizationsDa([String locale = 'da']) : super(locale);

  @override
  String get app_title => 'AirSnap';

  @override
  String get home_welcome => 'Velkommen til AirSnap';

  @override
  String get status_waiting => 'Venter på Bluetooth-signal…';

  @override
  String get status_detected => 'Signal registreret!';

  @override
  String get btn_calibrate => 'Kalibrer enhed';

  @override
  String get section_bluetooth => 'Bluetooth';

  @override
  String get section_camera => 'Kamera';

  @override
  String get lbl_language => 'Sprog';

  @override
  String get lbl_settings => 'Indstillinger';

  @override
  String get btn_scan => 'Søg efter enheder';

  @override
  String get btn_connect => 'Tilslut';

  @override
  String get btn_disconnect => 'Afbryd';

  @override
  String get msg_no_devices => 'Ingen enheder fundet i nærheden';

  @override
  String msg_connected(String deviceName) {
    return 'Tilsluttet $deviceName';
  }

  @override
  String get err_bluetooth_off => 'Slå Bluetooth til for at fortsætte';

  @override
  String get err_permission_denied => 'Bluetooth-tilladelse nægtet';

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
