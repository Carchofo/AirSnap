// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get app_title => 'AirSnap';

  @override
  String get home_welcome => 'AirSnapへようこそ';

  @override
  String get status_waiting => 'Bluetooth信号を待っています…';

  @override
  String get status_detected => '信号を検出しました！';

  @override
  String get btn_calibrate => 'デバイスをキャリブレーション';

  @override
  String get section_bluetooth => 'Bluetooth';

  @override
  String get section_camera => 'カメラ';

  @override
  String get lbl_language => '言語';

  @override
  String get lbl_settings => '設定';

  @override
  String get btn_scan => 'デバイスをスキャン';

  @override
  String get btn_connect => '接続';

  @override
  String get btn_disconnect => '切断';

  @override
  String get msg_no_devices => '近くにデバイスが見つかりません';

  @override
  String msg_connected(String deviceName) {
    return '$deviceNameに接続しました';
  }

  @override
  String get err_bluetooth_off => '続行するにはBluetoothを有効にしてください';

  @override
  String get err_permission_denied => 'Bluetoothの許可が拒否されました';
}
