// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Swedish (`sv`).
class AppLocalizationsSv extends AppLocalizations {
  AppLocalizationsSv([String locale = 'sv']) : super(locale);

  @override
  String get app_title => 'AirSnap';

  @override
  String get home_welcome => 'Välkommen till AirSnap';

  @override
  String get status_waiting => 'Väntar på Bluetooth-signal…';

  @override
  String get status_detected => 'Signal upptäckt!';

  @override
  String get btn_calibrate => 'Kalibrera enhet';

  @override
  String get section_bluetooth => 'Bluetooth';

  @override
  String get section_camera => 'Kamera';

  @override
  String get lbl_language => 'Språk';

  @override
  String get lbl_settings => 'Inställningar';

  @override
  String get btn_scan => 'Sök efter enheter';

  @override
  String get btn_connect => 'Anslut';

  @override
  String get btn_disconnect => 'Koppla från';

  @override
  String get msg_no_devices => 'Inga enheter hittades i närheten';

  @override
  String msg_connected(String deviceName) {
    return 'Ansluten till $deviceName';
  }

  @override
  String get err_bluetooth_off => 'Aktivera Bluetooth för att fortsätta';

  @override
  String get err_permission_denied => 'Bluetooth-behörighet nekad';

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
