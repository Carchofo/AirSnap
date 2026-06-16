import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../providers/shutter_provider.dart';
import '../widgets/status_badge.dart';
import '../widgets/calibrate_button.dart';
import 'settings_screen.dart';

// Canal nativo que MainActivity.kt escucha para enviar eventos de volumen.
const _kVolumeChannel = EventChannel('com.airsnap.airsnap/volume');

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  StreamSubscription? _volumeSub;

  @override
  void initState() {
    super.initState();
    _startVolumeListener();
  }

  void _startVolumeListener() {
    _volumeSub = _kVolumeChannel.receiveBroadcastStream().listen((_) {
      if (!mounted) return;
      context.read<ShutterProvider>().triggerDetected();
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) context.read<ShutterProvider>().reset();
      });
    });
  }

  @override
  void dispose() {
    _volumeSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isRtl = Directionality.of(context) == TextDirection.rtl;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.app_title),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            tooltip: l10n.lbl_settings,
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SettingsScreen()),
            ),
          ),
          if (isRtl)
            const Padding(
              padding: EdgeInsetsDirectional.only(end: 12),
              child: Center(
                child: Text('RTL', style: TextStyle(fontSize: 11, color: Colors.white54)),
              ),
            ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(24, 32, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.home_welcome,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(height: 32),
              Consumer<ShutterProvider>(
                builder: (_, shutter, __) => StatusBadge(
                  label: shutter.isDetected
                      ? l10n.status_detected
                      : l10n.status_waiting,
                  detected: shutter.isDetected,
                ),
              ),
              const SizedBox(height: 40),
              CalibrateButton(label: l10n.btn_calibrate),
              const Spacer(),
              Center(
                child: Text(
                  l10n.section_bluetooth,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: Colors.white38),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
