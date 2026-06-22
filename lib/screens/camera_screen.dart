import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../providers/camera_provider.dart';
import 'settings_screen.dart';

const _kVolumeChannel = EventChannel('com.airsnap.airsnap/volume');

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen>
    with WidgetsBindingObserver {
  StreamSubscription? _volumeSub;
  bool _showFlash = false;
  String? _toastMessage;
  Timer? _toastTimer;
  bool _shooting = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _requestPermissionsAndInit();
    _listenVolumeKeys();
  }

  Future<void> _requestPermissionsAndInit() async {
    final camera = await Permission.camera.request();
    // Android 13+ uses READ_MEDIA_IMAGES; older uses READ_EXTERNAL_STORAGE.
    if (Platform.isAndroid) {
      final sdkInt = await _androidSdkVersion();
      if (sdkInt >= 33) {
        await Permission.photos.request();
      } else {
        await Permission.storage.request();
      }
    }

    if (!mounted) return;
    if (camera.isGranted) {
      await context.read<CameraProvider>().initialize();
    } else {
      context.read<CameraProvider>().notifyPermissionDenied();
    }
  }

  Future<int> _androidSdkVersion() async {
    try {
      const ch = MethodChannel('com.airsnap.airsnap/volume');
      // Fallback: assume modern if channel unavailable
      return 33;
    } catch (_) {
      return 33;
    }
  }

  void _listenVolumeKeys() {
    _volumeSub?.cancel();
    _volumeSub = _kVolumeChannel.receiveBroadcastStream().listen(
      (_) => _shoot(),
      onError: (_) => _listenVolumeKeys(),
      onDone: () => _listenVolumeKeys(),
      cancelOnError: false,
    );
  }

  Future<void> _shoot() async {
    if (_shooting) return;
    _shooting = true;

    setState(() => _showFlash = true);
    Future.delayed(const Duration(milliseconds: 120), () {
      if (mounted) setState(() => _showFlash = false);
    });

    await context.read<CameraProvider>().takePhoto();
    _shooting = false;

    if (mounted) {
      _showToast(AppLocalizations.of(context).status_detected);
    }
  }

  void _showToast(String msg) {
    setState(() => _toastMessage = msg);
    _toastTimer?.cancel();
    _toastTimer = Timer(const Duration(seconds: 2), () {
      if (mounted) setState(() => _toastMessage = null);
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final cam = context.read<CameraProvider>();
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused) {
      // Don't dispose — just let it pause naturally.
      // Re-init on resume handles recovery.
    } else if (state == AppLifecycleState.resumed) {
      if (!cam.isReady && !cam.permissionDenied) {
        cam.initialize();
      }
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _volumeSub?.cancel();
    _toastTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cam = context.watch<CameraProvider>();

    if (cam.permissionDenied) return _PermissionDeniedScreen();
    if (cam.status == CameraStatus.error) return _ErrorScreen(message: cam.errorMessage);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          _CameraPreviewArea(onShoot: _shoot),

          if (_showFlash) const ColoredBox(color: Colors.white70),

          Positioned(
            top: 0, left: 0, right: 0,
            child: _TopBar(onShoot: _shoot),
          ),

          Positioned(
            bottom: 0, left: 0, right: 0,
            child: _BottomBar(onShoot: _shoot),
          ),

          if (_toastMessage != null)
            Positioned(
              bottom: 160, left: 0, right: 0,
              child: Center(child: _Toast(message: _toastMessage!)),
            ),
        ],
      ),
    );
  }
}

// ─── Permission denied ────────────────────────────────────────────────────────

class _PermissionDeniedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.camera_alt_outlined, color: Colors.white38, size: 64),
              const SizedBox(height: 24),
              Text(
                l10n.err_permission_denied,
                style: const TextStyle(color: Colors.white70, fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: openAppSettings,
                child: const Text('Open Settings'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Error ────────────────────────────────────────────────────────────────────

class _ErrorScreen extends StatelessWidget {
  const _ErrorScreen({this.message});
  final String? message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 64),
              const SizedBox(height: 16),
              Text(
                message ?? 'Camera error',
                style: const TextStyle(color: Colors.white70),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: () => context.read<CameraProvider>().initialize(),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Camera preview ───────────────────────────────────────────────────────────

class _CameraPreviewArea extends StatelessWidget {
  const _CameraPreviewArea({required this.onShoot});
  final VoidCallback onShoot;

  @override
  Widget build(BuildContext context) {
    final cam = context.watch<CameraProvider>();
    final ctrl = cam.controller;

    if (ctrl == null || !ctrl.value.isInitialized) {
      return const Center(
        child: CircularProgressIndicator(color: Colors.white54),
      );
    }

    return GestureDetector(
      onTap: onShoot,
      child: SizedBox.expand(child: CameraPreview(ctrl)),
    );
  }
}

// ─── Top bar ─────────────────────────────────────────────────────────────────

class _TopBar extends StatelessWidget {
  const _TopBar({required this.onShoot});
  final VoidCallback onShoot;

  @override
  Widget build(BuildContext context) {
    final cam = context.watch<CameraProvider>();
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _CircleButton(
              icon: cam.flashOn ? Icons.flash_on : Icons.flash_off,
              color: cam.flashOn ? Colors.yellow : Colors.white,
              onTap: () => context.read<CameraProvider>().toggleFlash(),
            ),
            const Text(
              'AirSnap',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
              ),
            ),
            _CircleButton(
              icon: Icons.settings_outlined,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SettingsScreen()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Bottom bar ───────────────────────────────────────────────────────────────

class _BottomBar extends StatelessWidget {
  const _BottomBar({required this.onShoot});
  final VoidCallback onShoot;

  @override
  Widget build(BuildContext context) {
    final cam = context.watch<CameraProvider>();
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 24, left: 40, right: 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _LastPhotoThumb(path: cam.lastPhotoPath),
            GestureDetector(
              onTap: onShoot,
              child: _ShutterButton(isCapturing: cam.isCapturing),
            ),
            _CircleButton(
              icon: Icons.cameraswitch_outlined,
              onTap: cam.hasMultipleCameras
                  ? () => context.read<CameraProvider>().switchCamera()
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Shutter button ───────────────────────────────────────────────────────────

class _ShutterButton extends StatelessWidget {
  const _ShutterButton({required this.isCapturing});
  final bool isCapturing;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      width: isCapturing ? 72 : 80,
      height: isCapturing ? 72 : 80,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 4),
        color: isCapturing ? Colors.white54 : Colors.white24,
      ),
      child: Center(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          width: isCapturing ? 52 : 60,
          height: isCapturing ? 52 : 60,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

// ─── Last photo thumb ─────────────────────────────────────────────────────────

class _LastPhotoThumb extends StatelessWidget {
  const _LastPhotoThumb({this.path});
  final String? path;

  @override
  Widget build(BuildContext context) {
    if (path == null) {
      return Container(
        width: 52, height: 52,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white30, width: 1.5),
          color: Colors.white10,
        ),
        child: const Icon(Icons.photo, color: Colors.white30, size: 24),
      );
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.file(File(path!), width: 52, height: 52, fit: BoxFit.cover),
    );
  }
}

// ─── Circle button ────────────────────────────────────────────────────────────

class _CircleButton extends StatelessWidget {
  const _CircleButton({required this.icon, this.color = Colors.white, this.onTap});
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44, height: 44,
        decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.black45),
        child: Icon(icon, color: onTap == null ? Colors.white24 : color, size: 22),
      ),
    );
  }
}

// ─── Toast ────────────────────────────────────────────────────────────────────

class _Toast extends StatelessWidget {
  const _Toast({required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Text(message, style: const TextStyle(color: Colors.white, fontSize: 14)),
    );
  }
}
