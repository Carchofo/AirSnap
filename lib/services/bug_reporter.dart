import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

/// Abre un GitHub Issue prefilled desde la app.
/// El DevTeam (pipeline en el PC) recoge las issues, genera el fix con LLMs
/// locales y publica una release nueva automáticamente.
class BugReporter {
  static const _repo = 'Carchofo/AirSnap';

  static Future<void> report({String? extra}) async {
    final info = await PackageInfo.fromPlatform();
    final body = Uri.encodeComponent('''
**Describe el problema:**


**Qué esperabas que pasara:**


---
_Datos del dispositivo (no borrar):_
- App: ${info.version}+${info.buildNumber}
- Android: ${Platform.operatingSystemVersion}
- Modo: ${kReleaseMode ? 'release' : 'debug'}
''');
    final url = Uri.parse(
        'https://github.com/$_repo/issues/new?labels=bug&title=${Uri.encodeComponent("[Bug] ")}&body=$body');
    await launchUrl(url, mode: LaunchMode.externalApplication);
  }
}
