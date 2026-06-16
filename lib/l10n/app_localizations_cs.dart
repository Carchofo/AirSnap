// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Czech (`cs`).
class AppLocalizationsCs extends AppLocalizations {
  AppLocalizationsCs([String locale = 'cs']) : super(locale);

  @override
  String get app_title => 'AirSnap';

  @override
  String get home_welcome => 'Vítejte v AirSnap';

  @override
  String get status_waiting => 'Čekání na Bluetooth signál…';

  @override
  String get status_detected => 'Signál zjištěn!';

  @override
  String get btn_calibrate => 'Kalibrovat zařízení';

  @override
  String get section_bluetooth => 'Bluetooth';

  @override
  String get section_camera => 'Fotoaparát';

  @override
  String get lbl_language => 'Jazyk';

  @override
  String get lbl_settings => 'Nastavení';

  @override
  String get btn_scan => 'Hledat zařízení';

  @override
  String get btn_connect => 'Připojit';

  @override
  String get btn_disconnect => 'Odpojit';

  @override
  String get msg_no_devices => 'V okolí nebyla nalezena žádná zařízení';

  @override
  String msg_connected(String deviceName) {
    return 'Připojeno k $deviceName';
  }

  @override
  String get err_bluetooth_off => 'Povolte Bluetooth pro pokračování';

  @override
  String get err_permission_denied => 'Oprávnění Bluetooth odepřeno';
}
