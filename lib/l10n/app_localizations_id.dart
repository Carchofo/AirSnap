// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get app_title => 'AirSnap';

  @override
  String get home_welcome => 'Selamat datang di AirSnap';

  @override
  String get status_waiting => 'Menunggu sinyal Bluetooth…';

  @override
  String get status_detected => 'Sinyal terdeteksi!';

  @override
  String get btn_calibrate => 'Kalibrasi perangkat';

  @override
  String get section_bluetooth => 'Bluetooth';

  @override
  String get section_camera => 'Kamera';

  @override
  String get lbl_language => 'Bahasa';

  @override
  String get lbl_settings => 'Pengaturan';

  @override
  String get btn_scan => 'Cari perangkat';

  @override
  String get btn_connect => 'Hubungkan';

  @override
  String get btn_disconnect => 'Putuskan';

  @override
  String get msg_no_devices => 'Tidak ada perangkat ditemukan di sekitar';

  @override
  String msg_connected(String deviceName) {
    return 'Terhubung ke $deviceName';
  }

  @override
  String get err_bluetooth_off => 'Aktifkan Bluetooth untuk melanjutkan';

  @override
  String get err_permission_denied => 'Izin Bluetooth ditolak';

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
