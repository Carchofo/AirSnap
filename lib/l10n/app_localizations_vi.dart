// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get app_title => 'AirSnap';

  @override
  String get home_welcome => 'Chào mừng đến với AirSnap';

  @override
  String get status_waiting => 'Đang chờ tín hiệu Bluetooth…';

  @override
  String get status_detected => 'Đã phát hiện tín hiệu!';

  @override
  String get btn_calibrate => 'Hiệu chỉnh thiết bị';

  @override
  String get section_bluetooth => 'Bluetooth';

  @override
  String get section_camera => 'Máy ảnh';

  @override
  String get lbl_language => 'Ngôn ngữ';

  @override
  String get lbl_settings => 'Cài đặt';

  @override
  String get btn_scan => 'Quét thiết bị';

  @override
  String get btn_connect => 'Kết nối';

  @override
  String get btn_disconnect => 'Ngắt kết nối';

  @override
  String get msg_no_devices => 'Không tìm thấy thiết bị nào gần đây';

  @override
  String msg_connected(String deviceName) {
    return 'Đã kết nối với $deviceName';
  }

  @override
  String get err_bluetooth_off => 'Vui lòng bật Bluetooth để tiếp tục';

  @override
  String get err_permission_denied => 'Quyền Bluetooth bị từ chối';

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
