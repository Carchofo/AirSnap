import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../l10n/app_localizations.dart';
import '../services/update_checker.dart';
import 'camera_screen.dart';

const _kVolumeChannel = EventChannel('com.airsnap.airsnap/volume');

class PairingScreen extends StatefulWidget {
  const PairingScreen({super.key});

  @override
  State<PairingScreen> createState() => _PairingScreenState();
}

class _PairingScreenState extends State<PairingScreen>
    with SingleTickerProviderStateMixin {
  StreamSubscription? _sub;
  _Step _step = _Step.waiting;
  int? _detectedKey;
  late AnimationController _pulseCtrl;
  late Animation<double> _pulse;

  // Debug: lista de todos los keycodes recibidos
  final List<String> _log = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      UpdateChecker.check(context);
    });
    _pulseCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);
    _pulse = Tween(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(parent: _pulseCtrl, curve: Curves.easeInOut),
    );
    _listenForKey();
  }

  void _listenForKey() {
    _sub?.cancel();
    _sub = _kVolumeChannel.receiveBroadcastStream().listen(
      (raw) {
        final keyCode = raw as int;
        final name = _keyName(keyCode);
        setState(() {
          _log.insert(0, '✓ keycode $keyCode ($name)');
          if (_log.length > 8) _log.removeLast();
        });

        if (_step != _Step.waiting) return;
        setState(() {
          _detectedKey = keyCode;
          _step = _Step.detected;
        });
        _pulseCtrl.stop();
        Future.delayed(const Duration(milliseconds: 1500), _goToCamera);
      },
      onError: (e) {
        setState(() => _log.insert(0, '✗ error: $e'));
        _listenForKey();
      },
      onDone: () => _listenForKey(),
      cancelOnError: false,
    );
  }

  String _keyName(int code) => switch (code) {
        24 => 'VOLUME_UP',
        25 => 'VOLUME_DOWN',
        79 => 'HEADSETHOOK',
        85 => 'MEDIA_PLAY_PAUSE',
        86 => 'MEDIA_STOP',
        87 => 'MEDIA_NEXT',
        88 => 'MEDIA_PREVIOUS',
        _ => 'key_$code',
      };

  void _goToCamera() {
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => CameraScreen(pairedKeyCode: _detectedKey),
        transitionsBuilder: (_, anim, __, child) =>
            FadeTransition(opacity: anim, child: child),
        transitionDuration: const Duration(milliseconds: 400),
      ),
    );
  }

  @override
  void dispose() {
    _sub?.cancel();
    _pulseCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: [
              const Spacer(flex: 2),

              const Text(
                'AirSnap',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 36,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 2,
                ),
              ),

              const SizedBox(height: 48),

              _step == _Step.waiting
                  ? ScaleTransition(
                      scale: _pulse,
                      child: Container(
                        width: 140,
                        height: 140,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white24, width: 2),
                          color: Colors.white10,
                        ),
                        child: const Icon(
                          Icons.bluetooth_searching,
                          color: Colors.white54,
                          size: 64,
                        ),
                      ),
                    )
                  : Container(
                      width: 140,
                      height: 140,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFF34C759).withOpacity(0.15),
                        border: Border.all(color: const Color(0xFF34C759), width: 2),
                      ),
                      child: const Icon(
                        Icons.check_rounded,
                        color: Color(0xFF34C759),
                        size: 72,
                      ),
                    ),

              const SizedBox(height: 32),

              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: _step == _Step.waiting
                    ? Column(
                        key: const ValueKey('waiting'),
                        children: [
                          Text(
                            AppLocalizations.of(context).status_waiting,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Press any button on your headset,\nsmartband or remote',
                            style: TextStyle(
                              color: Colors.white38,
                              fontSize: 15,
                              height: 1.5,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      )
                    : Column(
                        key: const ValueKey('detected'),
                        children: [
                          Text(
                            AppLocalizations.of(context).status_detected,
                            style: const TextStyle(
                              color: Color(0xFF34C759),
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Opening camera…',
                            style: TextStyle(color: Colors.white54, fontSize: 15),
                          ),
                        ],
                      ),
              ),

              const SizedBox(height: 24),

              // ── Debug log ─────────────────────────────────────────────
              if (_log.isNotEmpty)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'DEBUG — keycodes recibidos:',
                        style: TextStyle(
                          color: Colors.white30,
                          fontSize: 11,
                          fontFamily: 'monospace',
                        ),
                      ),
                      const SizedBox(height: 6),
                      ..._log.map((l) => Text(
                            l,
                            style: const TextStyle(
                              color: Color(0xFF34C759),
                              fontSize: 12,
                              fontFamily: 'monospace',
                            ),
                          )),
                    ],
                  ),
                ),

              if (_log.isEmpty)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.03),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white12),
                  ),
                  child: const Text(
                    'DEBUG — esperando keycodes…\nPulsa cualquier botón del dispositivo',
                    style: TextStyle(
                      color: Colors.white24,
                      fontSize: 12,
                      fontFamily: 'monospace',
                      height: 1.6,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

              const Spacer(flex: 2),

              TextButton(
                onPressed: _goToCamera,
                child: Text(
                  AppLocalizations.of(context).btn_skip,
                  style: const TextStyle(color: Colors.white30, fontSize: 13),
                ),
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

enum _Step { waiting, detected }
