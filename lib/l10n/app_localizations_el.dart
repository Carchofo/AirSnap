// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Modern Greek (`el`).
class AppLocalizationsEl extends AppLocalizations {
  AppLocalizationsEl([String locale = 'el']) : super(locale);

  @override
  String get app_title => 'AirSnap';

  @override
  String get home_welcome => 'Καλώς ήρθατε στο AirSnap';

  @override
  String get status_waiting => 'Αναμονή για σήμα Bluetooth…';

  @override
  String get status_detected => 'Σήμα εντοπίστηκε!';

  @override
  String get btn_calibrate => 'Βαθμονόμηση συσκευής';

  @override
  String get section_bluetooth => 'Bluetooth';

  @override
  String get section_camera => 'Κάμερα';

  @override
  String get lbl_language => 'Γλώσσα';

  @override
  String get lbl_settings => 'Ρυθμίσεις';

  @override
  String get btn_scan => 'Αναζήτηση συσκευών';

  @override
  String get btn_connect => 'Σύνδεση';

  @override
  String get btn_disconnect => 'Αποσύνδεση';

  @override
  String get msg_no_devices => 'Δεν βρέθηκαν συσκευές στην περιοχή';

  @override
  String msg_connected(String deviceName) {
    return 'Συνδέθηκε με $deviceName';
  }

  @override
  String get err_bluetooth_off =>
      'Ενεργοποιήστε το Bluetooth για να συνεχίσετε';

  @override
  String get err_permission_denied => 'Η άδεια Bluetooth απορρίφθηκε';
}
