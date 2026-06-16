// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get app_title => 'AirSnap';

  @override
  String get home_welcome => 'Bienvenido a AirSnap';

  @override
  String get status_waiting => 'Esperando señal de Bluetooth…';

  @override
  String get status_detected => '¡Señal detectada!';

  @override
  String get btn_calibrate => 'Calibrar dispositivo';

  @override
  String get section_bluetooth => 'Bluetooth';

  @override
  String get section_camera => 'Cámara';

  @override
  String get lbl_language => 'Idioma';

  @override
  String get lbl_settings => 'Ajustes';

  @override
  String get btn_scan => 'Buscar dispositivos';

  @override
  String get btn_connect => 'Conectar';

  @override
  String get btn_disconnect => 'Desconectar';

  @override
  String get msg_no_devices => 'No se encontraron dispositivos cercanos';

  @override
  String msg_connected(String deviceName) {
    return 'Conectado a $deviceName';
  }

  @override
  String get err_bluetooth_off => 'Activa el Bluetooth para continuar';

  @override
  String get err_permission_denied => 'Permiso de Bluetooth denegado';
}
