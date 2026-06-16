// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get app_title => 'AirSnap';

  @override
  String get home_welcome => 'مرحبًا بك في AirSnap';

  @override
  String get status_waiting => 'في انتظار إشارة البلوتوث…';

  @override
  String get status_detected => 'تم اكتشاف الإشارة!';

  @override
  String get btn_calibrate => 'معايرة الجهاز';

  @override
  String get section_bluetooth => 'البلوتوث';

  @override
  String get section_camera => 'الكاميرا';

  @override
  String get lbl_language => 'اللغة';

  @override
  String get lbl_settings => 'الإعدادات';

  @override
  String get btn_scan => 'البحث عن أجهزة';

  @override
  String get btn_connect => 'اتصال';

  @override
  String get btn_disconnect => 'قطع الاتصال';

  @override
  String get msg_no_devices => 'لم يتم العثور على أجهزة قريبة';

  @override
  String msg_connected(String deviceName) {
    return 'متصل بـ $deviceName';
  }

  @override
  String get err_bluetooth_off => 'يرجى تفعيل البلوتوث للمتابعة';

  @override
  String get err_permission_denied => 'تم رفض إذن البلوتوث';
}
