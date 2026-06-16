import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'l10n/app_localizations.dart';
import 'providers/camera_provider.dart';
import 'providers/locale_provider.dart';
import 'providers/shutter_provider.dart';
import 'screens/camera_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Forzar orientación portrait para la cámara
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
        ChangeNotifierProvider(create: (_) => ShutterProvider()),
        ChangeNotifierProvider(create: (_) => CameraProvider()),
      ],
      child: const AirSnapApp(),
    ),
  );
}

class AirSnapApp extends StatelessWidget {
  const AirSnapApp({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = context.watch<LocaleProvider>().locale;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AirSnap',
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), Locale('af'), Locale('ar'), Locale('cs'),
        Locale('da'), Locale('de'), Locale('el'), Locale('es'),
        Locale('fi'), Locale('fr'), Locale('hi'), Locale('hu'),
        Locale('id'), Locale('it'), Locale('ja'), Locale('ko'),
        Locale('ms'), Locale('nl'), Locale('no'), Locale('pl'),
        Locale('pt'), Locale('ro'), Locale('sv'), Locale('sw'),
        Locale('th'), Locale('tl'), Locale('vi'), Locale('xh'),
        Locale('zh'), Locale('zh', 'TW'), Locale('zu'),
      ],
      locale: locale,
      localeResolutionCallback: (deviceLocale, supportedLocales) {
        if (deviceLocale == null) return const Locale('en');
        for (final s in supportedLocales) {
          if (s.languageCode == deviceLocale.languageCode &&
              s.countryCode == deviceLocale.countryCode) return s;
        }
        for (final s in supportedLocales) {
          if (s.languageCode == deviceLocale.languageCode) return s;
        }
        return const Locale('en');
      },
      themeMode: ThemeMode.dark,
      darkTheme: _buildTheme(),
      home: const CameraScreen(),
    );
  }

  ThemeData _buildTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF0A84FF),
        brightness: Brightness.dark,
      ),
      scaffoldBackgroundColor: Colors.black,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
    );
  }
}
