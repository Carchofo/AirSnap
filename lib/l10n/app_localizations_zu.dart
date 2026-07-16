// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Zulu (`zu`).
class AppLocalizationsZu extends AppLocalizations {
  AppLocalizationsZu([String locale = 'zu']) : super(locale);

  @override
  String get app_title => 'AirSnap';

  @override
  String get home_welcome => 'Siyakwamukela ku-AirSnap';

  @override
  String get status_waiting => 'Ilinda uphawu lwe-Bluetooth…';

  @override
  String get status_detected => 'Uphawu lutholakele!';

  @override
  String get btn_calibrate => 'Lungisa idivayisi';

  @override
  String get section_bluetooth => 'Bluetooth';

  @override
  String get section_camera => 'Ikhamera';

  @override
  String get lbl_language => 'Ulimi';

  @override
  String get lbl_settings => 'Izilungiselelo';

  @override
  String get btn_scan => 'Skena amadivayisi';

  @override
  String get btn_connect => 'Xhuma';

  @override
  String get btn_disconnect => 'Nqamula';

  @override
  String get msg_no_devices => 'Awekho amadivayisi atholakele eduze';

  @override
  String msg_connected(String deviceName) {
    return 'Kuxhunyiwe ku-$deviceName';
  }

  @override
  String get err_bluetooth_off => 'Sicela uvule i-Bluetooth ukuze uqhubeke';

  @override
  String get err_permission_denied => 'Imvume ye-Bluetooth yenqatshelwe';

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
