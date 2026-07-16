// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hungarian (`hu`).
class AppLocalizationsHu extends AppLocalizations {
  AppLocalizationsHu([String locale = 'hu']) : super(locale);

  @override
  String get app_title => 'AirSnap';

  @override
  String get home_welcome => 'Üdvözöljük az AirSnapben';

  @override
  String get status_waiting => 'Bluetooth-jel várakozása…';

  @override
  String get status_detected => 'Jel észlelve!';

  @override
  String get btn_calibrate => 'Eszköz kalibrálása';

  @override
  String get section_bluetooth => 'Bluetooth';

  @override
  String get section_camera => 'Kamera';

  @override
  String get lbl_language => 'Nyelv';

  @override
  String get lbl_settings => 'Beállítások';

  @override
  String get btn_scan => 'Eszközök keresése';

  @override
  String get btn_connect => 'Csatlakozás';

  @override
  String get btn_disconnect => 'Lecsatlakozás';

  @override
  String get msg_no_devices => 'Nem találhatók eszközök a közelben';

  @override
  String msg_connected(String deviceName) {
    return 'Csatlakozva ehhez: $deviceName';
  }

  @override
  String get err_bluetooth_off => 'Kapcsolja be a Bluetooth-t a folytatáshoz';

  @override
  String get err_permission_denied => 'Bluetooth-engedély megtagadva';

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
