// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get app_title => 'AirSnap';

  @override
  String get home_welcome => '欢迎使用 AirSnap';

  @override
  String get status_waiting => '等待蓝牙信号…';

  @override
  String get status_detected => '检测到信号！';

  @override
  String get btn_calibrate => '校准设备';

  @override
  String get section_bluetooth => '蓝牙';

  @override
  String get section_camera => '相机';

  @override
  String get lbl_language => '语言';

  @override
  String get lbl_settings => '设置';

  @override
  String get btn_scan => '扫描设备';

  @override
  String get btn_connect => '连接';

  @override
  String get btn_disconnect => '断开连接';

  @override
  String get msg_no_devices => '附近未找到设备';

  @override
  String msg_connected(String deviceName) {
    return '已连接到 $deviceName';
  }

  @override
  String get err_bluetooth_off => '请启用蓝牙以继续';

  @override
  String get err_permission_denied => '蓝牙权限被拒绝';

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

/// The translations for Chinese, as used in Taiwan (`zh_TW`).
class AppLocalizationsZhTw extends AppLocalizationsZh {
  AppLocalizationsZhTw() : super('zh_TW');

  @override
  String get app_title => 'AirSnap';

  @override
  String get home_welcome => '歡迎使用 AirSnap';

  @override
  String get status_waiting => '等待藍牙訊號…';

  @override
  String get status_detected => '偵測到訊號！';

  @override
  String get btn_calibrate => '校準裝置';

  @override
  String get section_bluetooth => '藍牙';

  @override
  String get section_camera => '相機';

  @override
  String get lbl_language => '語言';

  @override
  String get lbl_settings => '設定';

  @override
  String get btn_scan => '掃描裝置';

  @override
  String get btn_connect => '連線';

  @override
  String get btn_disconnect => '中斷連線';

  @override
  String get msg_no_devices => '附近未找到裝置';

  @override
  String msg_connected(String deviceName) {
    return '已連線至 $deviceName';
  }

  @override
  String get err_bluetooth_off => '請啟用藍牙以繼續';

  @override
  String get err_permission_denied => '藍牙權限被拒絕';
}
