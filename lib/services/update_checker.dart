import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

const _kRepo = 'Carchofo/AirSnap';

class UpdateChecker {
  static Future<void> check(BuildContext context) async {
    try {
      final info = await PackageInfo.fromPlatform();
      final current = _parseVersion(info.version);

      final res = await http
          .get(Uri.parse('https://api.github.com/repos/$_kRepo/releases/latest'))
          .timeout(const Duration(seconds: 8));

      if (res.statusCode != 200) return;

      final data = jsonDecode(res.body) as Map<String, dynamic>;
      final tag = (data['tag_name'] as String?)?.replaceFirst('v', '') ?? '';
      final latest = _parseVersion(tag);
      final downloadUrl = (data['assets'] as List?)
          ?.whereType<Map>()
          .firstWhere(
            (a) => (a['name'] as String).endsWith('.apk'),
            orElse: () => {},
          )['browser_download_url'] as String?;

      if (_isNewer(latest, current) && context.mounted && downloadUrl != null) {
        _showBanner(context, tag, downloadUrl);
      }
    } catch (_) {
      // Silencioso — no bloquea el arranque
    }
  }

  static void _showBanner(BuildContext context, String version, String url) {
    ScaffoldMessenger.of(context).showMaterialBanner(
      MaterialBanner(
        backgroundColor: const Color(0xFF1C1C1E),
        content: Text(
          'Nueva versión v$version disponible',
          style: const TextStyle(color: Colors.white),
        ),
        actions: [
          TextButton(
            onPressed: () =>
                ScaffoldMessenger.of(context).hideCurrentMaterialBanner(),
            child: const Text('Ahora no', style: TextStyle(color: Colors.white54)),
          ),
          TextButton(
            onPressed: () async {
              ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
              await launchUrl(Uri.parse(url),
                  mode: LaunchMode.externalApplication);
            },
            child: const Text('Actualizar',
                style: TextStyle(color: Color(0xFF0A84FF))),
          ),
        ],
      ),
    );
  }

  static List<int> _parseVersion(String v) {
    final parts = v.split('.');
    return parts.map((p) => int.tryParse(p) ?? 0).toList();
  }

  static bool _isNewer(List<int> latest, List<int> current) {
    for (var i = 0; i < 3; i++) {
      final l = i < latest.length ? latest[i] : 0;
      final c = i < current.length ? current[i] : 0;
      if (l > c) return true;
      if (l < c) return false;
    }
    return false;
  }
}
