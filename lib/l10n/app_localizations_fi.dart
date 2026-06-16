// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Finnish (`fi`).
class AppLocalizationsFi extends AppLocalizations {
  AppLocalizationsFi([String locale = 'fi']) : super(locale);

  @override
  String get app_title => 'AirSnap';

  @override
  String get home_welcome => 'Tervetuloa AirSnapiin';

  @override
  String get status_waiting => 'Odotetaan Bluetooth-signaalia…';

  @override
  String get status_detected => 'Signaali havaittu!';

  @override
  String get btn_calibrate => 'Kalibroi laite';

  @override
  String get section_bluetooth => 'Bluetooth';

  @override
  String get section_camera => 'Kamera';

  @override
  String get lbl_language => 'Kieli';

  @override
  String get lbl_settings => 'Asetukset';

  @override
  String get btn_scan => 'Etsi laitteita';

  @override
  String get btn_connect => 'Yhdistä';

  @override
  String get btn_disconnect => 'Katkaise yhteys';

  @override
  String get msg_no_devices => 'Läheltä ei löytynyt laitteita';

  @override
  String msg_connected(String deviceName) {
    return 'Yhdistetty laitteeseen $deviceName';
  }

  @override
  String get err_bluetooth_off => 'Ota Bluetooth käyttöön jatkaaksesi';

  @override
  String get err_permission_denied => 'Bluetooth-lupa evätty';
}
