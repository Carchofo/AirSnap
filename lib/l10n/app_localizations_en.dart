// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get app_title => 'AirSnap';

  @override
  String get home_welcome => 'Welcome to AirSnap';

  @override
  String get status_waiting => 'Waiting for Bluetooth signal…';

  @override
  String get status_detected => 'Signal detected!';

  @override
  String get btn_calibrate => 'Calibrate device';

  @override
  String get section_bluetooth => 'Bluetooth';

  @override
  String get section_camera => 'Camera';

  @override
  String get lbl_language => 'Language';

  @override
  String get lbl_settings => 'Settings';

  @override
  String get btn_scan => 'Scan for devices';

  @override
  String get btn_connect => 'Connect';

  @override
  String get btn_disconnect => 'Disconnect';

  @override
  String get msg_no_devices => 'No devices found nearby';

  @override
  String msg_connected(String deviceName) {
    return 'Connected to $deviceName';
  }

  @override
  String get err_bluetooth_off => 'Please enable Bluetooth to continue';

  @override
  String get err_permission_denied => 'Bluetooth permission denied';

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
