// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Norwegian (`no`).
class AppLocalizationsNo extends AppLocalizations {
  AppLocalizationsNo([String locale = 'no']) : super(locale);

  @override
  String get app_title => 'AirSnap';

  @override
  String get home_welcome => 'Velkommen til AirSnap';

  @override
  String get status_waiting => 'Venter på Bluetooth-signal…';

  @override
  String get status_detected => 'Signal oppdaget!';

  @override
  String get btn_calibrate => 'Kalibrer enhet';

  @override
  String get section_bluetooth => 'Bluetooth';

  @override
  String get section_camera => 'Kamera';

  @override
  String get lbl_language => 'Språk';

  @override
  String get lbl_settings => 'Innstillinger';

  @override
  String get btn_scan => 'Søk etter enheter';

  @override
  String get btn_connect => 'Koble til';

  @override
  String get btn_disconnect => 'Koble fra';

  @override
  String get msg_no_devices => 'Ingen enheter funnet i nærheten';

  @override
  String msg_connected(String deviceName) {
    return 'Koblet til $deviceName';
  }

  @override
  String get err_bluetooth_off => 'Slå på Bluetooth for å fortsette';

  @override
  String get err_permission_denied => 'Bluetooth-tillatelse avslått';
}
