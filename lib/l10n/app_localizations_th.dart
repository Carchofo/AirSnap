// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Thai (`th`).
class AppLocalizationsTh extends AppLocalizations {
  AppLocalizationsTh([String locale = 'th']) : super(locale);

  @override
  String get app_title => 'AirSnap';

  @override
  String get home_welcome => 'ยินดีต้อนรับสู่ AirSnap';

  @override
  String get status_waiting => 'กำลังรอสัญญาณ Bluetooth…';

  @override
  String get status_detected => 'ตรวจพบสัญญาณแล้ว!';

  @override
  String get btn_calibrate => 'ปรับเทียบอุปกรณ์';

  @override
  String get section_bluetooth => 'บลูทูธ';

  @override
  String get section_camera => 'กล้อง';

  @override
  String get lbl_language => 'ภาษา';

  @override
  String get lbl_settings => 'การตั้งค่า';

  @override
  String get btn_scan => 'ค้นหาอุปกรณ์';

  @override
  String get btn_connect => 'เชื่อมต่อ';

  @override
  String get btn_disconnect => 'ยกเลิกการเชื่อมต่อ';

  @override
  String get msg_no_devices => 'ไม่พบอุปกรณ์ในบริเวณใกล้เคียง';

  @override
  String msg_connected(String deviceName) {
    return 'เชื่อมต่อกับ $deviceName แล้ว';
  }

  @override
  String get err_bluetooth_off => 'กรุณาเปิดใช้บลูทูธเพื่อดำเนินการต่อ';

  @override
  String get err_permission_denied => 'การอนุญาต Bluetooth ถูกปฏิเสธ';

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
