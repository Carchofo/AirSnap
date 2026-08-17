// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get app_title => 'AirSnap';

  @override
  String get home_welcome => 'Bienvenue sur AirSnap';

  @override
  String get status_waiting => 'En attente du signal Bluetooth…';

  @override
  String get status_detected => 'Signal détecté !';

  @override
  String get btn_calibrate => 'Calibrer l\'appareil';

  @override
  String get section_bluetooth => 'Bluetooth';

  @override
  String get section_camera => 'Appareil photo';

  @override
  String get lbl_language => 'Langue';

  @override
  String get lbl_settings => 'Paramètres';

  @override
  String get btn_scan => 'Rechercher des appareils';

  @override
  String get btn_connect => 'Connecter';

  @override
  String get btn_disconnect => 'Déconnecter';

  @override
  String get msg_no_devices => 'Aucun appareil trouvé à proximité';

  @override
  String msg_connected(String deviceName) {
    return 'Connecté à $deviceName';
  }

  @override
  String get err_bluetooth_off =>
      'Veuillez activer le Bluetooth pour continuer';

  @override
  String get err_permission_denied => 'Permission Bluetooth refusée';

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
