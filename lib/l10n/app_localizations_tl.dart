// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Tagalog (`tl`).
class AppLocalizationsTl extends AppLocalizations {
  AppLocalizationsTl([String locale = 'tl']) : super(locale);

  @override
  String get app_title => 'AirSnap';

  @override
  String get home_welcome => 'Maligayang pagdating sa AirSnap';

  @override
  String get status_waiting => 'Naghihintay ng Bluetooth na signal…';

  @override
  String get status_detected => 'Natukoy ang signal!';

  @override
  String get btn_calibrate => 'I-calibrate ang device';

  @override
  String get section_bluetooth => 'Bluetooth';

  @override
  String get section_camera => 'Camera';

  @override
  String get lbl_language => 'Wika';

  @override
  String get lbl_settings => 'Mga Setting';

  @override
  String get btn_scan => 'Mag-scan ng mga device';

  @override
  String get btn_connect => 'Ikonekta';

  @override
  String get btn_disconnect => 'Idiskonekta';

  @override
  String get msg_no_devices => 'Walang device na natagpuan sa malapit';

  @override
  String msg_connected(String deviceName) {
    return 'Nakakonekta sa $deviceName';
  }

  @override
  String get err_bluetooth_off => 'Pakibukas ang Bluetooth para magpatuloy';

  @override
  String get err_permission_denied => 'Tinanggihan ang pahintulot sa Bluetooth';

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
