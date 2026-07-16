// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Romanian Moldavian Moldovan (`ro`).
class AppLocalizationsRo extends AppLocalizations {
  AppLocalizationsRo([String locale = 'ro']) : super(locale);

  @override
  String get app_title => 'AirSnap';

  @override
  String get home_welcome => 'Bun venit la AirSnap';

  @override
  String get status_waiting => 'Se așteaptă semnalul Bluetooth…';

  @override
  String get status_detected => 'Semnal detectat!';

  @override
  String get btn_calibrate => 'Calibrați dispozitivul';

  @override
  String get section_bluetooth => 'Bluetooth';

  @override
  String get section_camera => 'Cameră';

  @override
  String get lbl_language => 'Limbă';

  @override
  String get lbl_settings => 'Setări';

  @override
  String get btn_scan => 'Căutați dispozitive';

  @override
  String get btn_connect => 'Conectați';

  @override
  String get btn_disconnect => 'Deconectați';

  @override
  String get msg_no_devices => 'Nu s-au găsit dispozitive în apropiere';

  @override
  String msg_connected(String deviceName) {
    return 'Conectat la $deviceName';
  }

  @override
  String get err_bluetooth_off => 'Activați Bluetooth pentru a continua';

  @override
  String get err_permission_denied => 'Permisiunea Bluetooth refuzată';

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
