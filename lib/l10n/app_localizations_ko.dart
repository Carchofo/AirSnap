// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get app_title => 'AirSnap';

  @override
  String get home_welcome => 'AirSnap에 오신 것을 환영합니다';

  @override
  String get status_waiting => 'Bluetooth 신호 대기 중…';

  @override
  String get status_detected => '신호 감지됨!';

  @override
  String get btn_calibrate => '기기 보정';

  @override
  String get section_bluetooth => 'Bluetooth';

  @override
  String get section_camera => '카메라';

  @override
  String get lbl_language => '언어';

  @override
  String get lbl_settings => '설정';

  @override
  String get btn_scan => '기기 검색';

  @override
  String get btn_connect => '연결';

  @override
  String get btn_disconnect => '연결 해제';

  @override
  String get msg_no_devices => '주변에서 기기를 찾을 수 없습니다';

  @override
  String msg_connected(String deviceName) {
    return '$deviceName에 연결됨';
  }

  @override
  String get err_bluetooth_off => '계속하려면 Bluetooth를 활성화하세요';

  @override
  String get err_permission_denied => 'Bluetooth 권한이 거부되었습니다';

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
