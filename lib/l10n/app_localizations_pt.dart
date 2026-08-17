// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get app_title => 'AirSnap';

  @override
  String get home_welcome => 'Bem-vindo ao AirSnap';

  @override
  String get status_waiting => 'Aguardando sinal de Bluetooth…';

  @override
  String get status_detected => 'Sinal detectado!';

  @override
  String get btn_calibrate => 'Calibrar dispositivo';

  @override
  String get section_bluetooth => 'Bluetooth';

  @override
  String get section_camera => 'Câmera';

  @override
  String get lbl_language => 'Idioma';

  @override
  String get lbl_settings => 'Configurações';

  @override
  String get btn_scan => 'Procurar dispositivos';

  @override
  String get btn_connect => 'Conectar';

  @override
  String get btn_disconnect => 'Desconectar';

  @override
  String get msg_no_devices => 'Nenhum dispositivo encontrado nas proximidades';

  @override
  String msg_connected(String deviceName) {
    return 'Conectado a $deviceName';
  }

  @override
  String get err_bluetooth_off => 'Ative o Bluetooth para continuar';

  @override
  String get err_permission_denied => 'Permissão de Bluetooth negada';

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
