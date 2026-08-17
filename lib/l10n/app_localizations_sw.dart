// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Swahili (`sw`).
class AppLocalizationsSw extends AppLocalizations {
  AppLocalizationsSw([String locale = 'sw']) : super(locale);

  @override
  String get app_title => 'AirSnap';

  @override
  String get home_welcome => 'Karibu kwenye AirSnap';

  @override
  String get status_waiting => 'Inasubiri ishara ya Bluetooth…';

  @override
  String get status_detected => 'Ishara imegunduliwa!';

  @override
  String get btn_calibrate => 'Rekebisha kifaa';

  @override
  String get section_bluetooth => 'Bluetooth';

  @override
  String get section_camera => 'Kamera';

  @override
  String get lbl_language => 'Lugha';

  @override
  String get lbl_settings => 'Mipangilio';

  @override
  String get btn_scan => 'Tafuta vifaa';

  @override
  String get btn_connect => 'Unganisha';

  @override
  String get btn_disconnect => 'Tenganisha';

  @override
  String get msg_no_devices => 'Hakuna vifaa vilivyopatikana karibu';

  @override
  String msg_connected(String deviceName) {
    return 'Imeunganishwa na $deviceName';
  }

  @override
  String get err_bluetooth_off => 'Tafadhali washa Bluetooth kuendelea';

  @override
  String get err_permission_denied => 'Ruhusa ya Bluetooth imekataliwa';

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
