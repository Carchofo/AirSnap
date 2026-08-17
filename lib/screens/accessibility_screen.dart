import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../l10n/app_localizations.dart';
import 'pairing_screen.dart';

class AccessibilityScreen extends StatefulWidget {
  const AccessibilityScreen({super.key});

  @override
  State<AccessibilityScreen> createState() => _AccessibilityScreenState();
}

class _AccessibilityScreenState extends State<AccessibilityScreen> {
  static const _kChannel = MethodChannel('com.airsnap.airsnap/accessibility');
  Timer? _pollTimer;
  bool _checking = false;

  @override
  void initState() {
    super.initState();
    _checkOnResume();
  }

  void _checkOnResume() {
    // Poll every 500ms while screen is visible (user may return from Settings)
    _pollTimer = Timer.periodic(const Duration(milliseconds: 500), (_) async {
      final enabled = await _isEnabled();
      if (enabled && mounted) {
        _pollTimer?.cancel();
        _goToPairing();
      }
    });
  }

  Future<bool> _isEnabled() async {
    try {
      return await _kChannel.invokeMethod('isAccessibilityEnabled') as bool;
    } catch (_) {
      return false;
    }
  }

  void _openSettings() {
    _kChannel.invokeMethod('openAccessibilitySettings');
  }

  void _goToPairing() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => const PairingScreen(),
        transitionsBuilder: (_, anim, __, child) =>
            FadeTransition(opacity: anim, child: child),
        transitionDuration: const Duration(milliseconds: 400),
      ),
    );
  }

  @override
  void dispose() {
    _pollTimer?.cancel();
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

              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF0A84FF).withOpacity(0.15),
                  border: Border.all(color: const Color(0xFF0A84FF), width: 2),
                ),
                child: const Icon(
                  Icons.bluetooth,
                  color: Color(0xFF0A84FF),
                  size: 56,
                ),
              ),

              const SizedBox(height: 40),

              Text(
                AppLocalizations.of(context).access_title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 16),

              Text(
                AppLocalizations.of(context).access_body,
                style: const TextStyle(
                  color: Colors.white60,
                  fontSize: 15,
                  height: 1.6,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 20),

              // Declaración de privacidad requerida por Google Play
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white12),
                ),
                child: const Text(
                  '🔒 AirSnap only uses this permission to detect button presses from your Bluetooth peripheral. '
                  'It does not read, store or transmit any screen content, text or personal data.',
                  style: TextStyle(
                    color: Colors.white38,
                    fontSize: 12,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              const SizedBox(height: 24),

              _Step(number: '1', text: AppLocalizations.of(context).access_step1),
              const SizedBox(height: 12),
              _Step(number: '2', text: AppLocalizations.of(context).access_step2),
              const SizedBox(height: 12),
              _Step(number: '3', text: AppLocalizations.of(context).access_step3),

              const Spacer(flex: 3),

              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _openSettings,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0A84FF),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    AppLocalizations.of(context).access_btn,
                    style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              TextButton(
                onPressed: _goToPairing,
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

class _Step extends StatelessWidget {
  const _Step({required this.number, required this.text});
  final String number;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFF0A84FF).withOpacity(0.2),
            border: Border.all(color: const Color(0xFF0A84FF).withOpacity(0.5)),
          ),
          child: Center(
            child: Text(
              number,
              style: const TextStyle(
                color: Color(0xFF0A84FF),
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        const SizedBox(width: 14),
        Text(
          text,
          style: const TextStyle(color: Colors.white70, fontSize: 15),
        ),
      ],
    );
  }
}
