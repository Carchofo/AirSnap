// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get app_title => 'AirSnap';

  @override
  String get home_welcome => 'AirSnap में आपका स्वागत है';

  @override
  String get status_waiting => 'Bluetooth सिग्नल का इंतज़ार है…';

  @override
  String get status_detected => 'सिग्नल मिल गया!';

  @override
  String get btn_calibrate => 'डिवाइस को कैलिब्रेट करें';

  @override
  String get section_bluetooth => 'Bluetooth';

  @override
  String get section_camera => 'कैमरा';

  @override
  String get lbl_language => 'भाषा';

  @override
  String get lbl_settings => 'सेटिंग्स';

  @override
  String get btn_scan => 'डिवाइस खोजें';

  @override
  String get btn_connect => 'कनेक्ट करें';

  @override
  String get btn_disconnect => 'डिस्कनेक्ट करें';

  @override
  String get msg_no_devices => 'आस-पास कोई डिवाइस नहीं मिली';

  @override
  String msg_connected(String deviceName) {
    return '$deviceName से कनेक्ट हो गया';
  }

  @override
  String get err_bluetooth_off => 'जारी रखने के लिए Bluetooth चालू करें';

  @override
  String get err_permission_denied => 'Bluetooth की अनुमति अस्वीकार की गई';

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
