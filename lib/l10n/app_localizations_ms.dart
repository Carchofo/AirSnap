// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Malay (`ms`).
class AppLocalizationsMs extends AppLocalizations {
  AppLocalizationsMs([String locale = 'ms']) : super(locale);

  @override
  String get app_title => 'AirSnap';

  @override
  String get home_welcome => 'Selamat datang ke AirSnap';

  @override
  String get status_waiting => 'Menunggu isyarat Bluetooth…';

  @override
  String get status_detected => 'Isyarat dikesan!';

  @override
  String get btn_calibrate => 'Kalibrasi peranti';

  @override
  String get section_bluetooth => 'Bluetooth';

  @override
  String get section_camera => 'Kamera';

  @override
  String get lbl_language => 'Bahasa';

  @override
  String get lbl_settings => 'Tetapan';

  @override
  String get btn_scan => 'Imbas peranti';

  @override
  String get btn_connect => 'Sambung';

  @override
  String get btn_disconnect => 'Putuskan sambungan';

  @override
  String get msg_no_devices => 'Tiada peranti ditemui berhampiran';

  @override
  String msg_connected(String deviceName) {
    return 'Disambungkan ke $deviceName';
  }

  @override
  String get err_bluetooth_off => 'Sila aktifkan Bluetooth untuk meneruskan';

  @override
  String get err_permission_denied => 'Kebenaran Bluetooth ditolak';
}
