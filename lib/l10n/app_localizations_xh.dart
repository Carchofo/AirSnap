// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Xhosa (`xh`).
class AppLocalizationsXh extends AppLocalizations {
  AppLocalizationsXh([String locale = 'xh']) : super(locale);

  @override
  String get app_title => 'AirSnap';

  @override
  String get home_welcome => 'Wamkelekile ku-AirSnap';

  @override
  String get status_waiting => 'Ilindele umqondiso we-Bluetooth…';

  @override
  String get status_detected => 'Umqondiso uфunyenwe!';

  @override
  String get btn_calibrate => 'Lungelelanisa isixhobo';

  @override
  String get section_bluetooth => 'Bluetooth';

  @override
  String get section_camera => 'Ikhamera';

  @override
  String get lbl_language => 'Ulwimi';

  @override
  String get lbl_settings => 'Iinqobo';

  @override
  String get btn_scan => 'Skena izixhobo';

  @override
  String get btn_connect => 'Qhagamshela';

  @override
  String get btn_disconnect => 'Nqamla';

  @override
  String get msg_no_devices => 'Azikho izixhobo ezifunyenweyo kufutshane';

  @override
  String msg_connected(String deviceName) {
    return 'Kuqhagamshelwe ku-$deviceName';
  }

  @override
  String get err_bluetooth_off => 'Nceda uvule i-Bluetooth ukuze uqhubeke';

  @override
  String get err_permission_denied => 'Imvume ye-Bluetooth iyaliwe';
}
