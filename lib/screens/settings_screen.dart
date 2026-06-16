import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../providers/locale_provider.dart';

/// All 31 supported locales with their human-readable display names.
/// The list is ordered: English first, then alphabetically by region.
const _kSupportedLocales = <(String tag, String name)>[
  ('en',    'English'),
  ('af',    'Afrikaans'),
  ('ar',    'العربية'),
  ('cs',    'Čeština'),
  ('da',    'Dansk'),
  ('de',    'Deutsch'),
  ('el',    'Ελληνικά'),
  ('es',    'Español'),
  ('fi',    'Suomi'),
  ('fr',    'Français'),
  ('hi',    'हिन्दी'),
  ('hu',    'Magyar'),
  ('id',    'Bahasa Indonesia'),
  ('it',    'Italiano'),
  ('ja',    '日本語'),
  ('ko',    '한국어'),
  ('ms',    'Bahasa Melayu'),
  ('nl',    'Nederlands'),
  ('no',    'Norsk'),
  ('pl',    'Polski'),
  ('pt',    'Português'),
  ('ro',    'Română'),
  ('sv',    'Svenska'),
  ('sw',    'Kiswahili'),
  ('th',    'ภาษาไทย'),
  ('tl',    'Filipino'),
  ('vi',    'Tiếng Việt'),
  ('xh',    'IsiXhosa'),
  ('zh',    '中文（简体）'),
  ('zh_TW', '中文（繁體）'),
  ('zu',    'IsiZulu'),
];

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final localeProvider = context.watch<LocaleProvider>();
    final currentTag = localeProvider.locale.toLanguageTag().replaceAll('-', '_');

    return Scaffold(
      appBar: AppBar(title: Text(l10n.lbl_settings)),
      body: ListView(
        children: [
          // ── Language section header ────────────────────────────────────
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(16, 20, 16, 8),
            child: Text(
              l10n.lbl_language,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),

          // ── Locale tiles ───────────────────────────────────────────────
          ..._kSupportedLocales.map((entry) {
            final (tag, name) = entry;
            final isSelected = tag == currentTag ||
                (currentTag.isEmpty && tag == 'en');

            return ListTile(
              title: Text(name),
              // Show the BCP-47 tag as subtitle for developer clarity.
              subtitle: Text(
                tag,
                style: const TextStyle(fontSize: 11, color: Colors.white38),
              ),
              trailing: isSelected
                  ? Icon(
                      Icons.check_circle,
                      color: Theme.of(context).colorScheme.primary,
                    )
                  : null,
              onTap: () {
                final parts = tag.split('_');
                final locale = parts.length == 2
                    ? Locale(parts[0], parts[1])
                    : Locale(parts[0]);
                context.read<LocaleProvider>().setLocale(locale);
              },
            );
          }),

          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
