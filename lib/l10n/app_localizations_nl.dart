// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Dutch Flemish (`nl`).
class AppLocalizationsNl extends AppLocalizations {
  AppLocalizationsNl([String locale = 'nl']) : super(locale);

  @override
  String get app_title => 'AirSnap';

  @override
  String get home_welcome => 'Welkom bij AirSnap';

  @override
  String get status_waiting => 'Wachten op Bluetooth-signaal…';

  @override
  String get status_detected => 'Signaal gedetecteerd!';

  @override
  String get btn_calibrate => 'Apparaat kalibreren';

  @override
  String get section_bluetooth => 'Bluetooth';

  @override
  String get section_camera => 'Camera';

  @override
  String get lbl_language => 'Taal';

  @override
  String get lbl_settings => 'Instellingen';

  @override
  String get btn_scan => 'Zoek apparaten';

  @override
  String get btn_connect => 'Verbinden';

  @override
  String get btn_disconnect => 'Verbreken';

  @override
  String get msg_no_devices => 'Geen apparaten gevonden in de buurt';

  @override
  String msg_connected(String deviceName) {
    return 'Verbonden met $deviceName';
  }

  @override
  String get err_bluetooth_off => 'Schakel Bluetooth in om door te gaan';

  @override
  String get err_permission_denied => 'Bluetooth-toestemming geweigerd';

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
