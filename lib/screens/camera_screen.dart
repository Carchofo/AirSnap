import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../providers/camera_provider.dart';
import '../providers/locale_provider.dart';
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
  bool _showFlash = false;       // overlay blanco al disparar
  String? _toastMessage;
  Timer? _toastTimer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _requestPermissionsAndInit();
    _listenVolumeKeys();
  }

  Future<void> _requestPermissionsAndInit() async {
    final camera = await Permission.camera.request();
    final storage = await Permission.storage.request();
    if (camera.isGranted) {
      if (mounted) {
        await context.read<CameraProvider>().initialize();
      }
    }
  }

  void _listenVolumeKeys() {
    _volumeSub = _kVolumeChannel.receiveBroadcastStream().listen((keyCode) {
      _showToast('KEY: $keyCode');  // diagnóstico — muestra el keycode en pantalla
      _shoot();
    });
  }

  Future<void> _shoot() async {
    final cam = context.read<CameraProvider>();
    if (!cam.isReady) return;

    // Flash visual de disparo
    setState(() => _showFlash = true);
    Future.delayed(const Duration(milliseconds: 120), () {
      if (mounted) setState(() => _showFlash = false);
    });

    await cam.takePhoto();

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
    if (state == AppLifecycleState.inactive) {
      cam.controller?.dispose();
    } else if (state == AppLifecycleState.resumed) {
      cam.initialize();
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
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // ── Visor de cámara ────────────────────────────────────────
          _CameraPreviewArea(onShoot: _shoot),

          // ── Flash de disparo ───────────────────────────────────────
          if (_showFlash)
            const ColoredBox(color: Colors.white70),

          // ── HUD superior ───────────────────────────────────────────
          Positioned(
            top: 0, left: 0, right: 0,
            child: _TopBar(onShoot: _shoot),
          ),

          // ── Botón de disparo inferior ──────────────────────────────
          Positioned(
            bottom: 0, left: 0, right: 0,
            child: _BottomBar(onShoot: _shoot),
          ),

          // ── Toast ──────────────────────────────────────────────────
          if (_toastMessage != null)
            Positioned(
              bottom: 160,
              left: 0, right: 0,
              child: Center(
                child: _Toast(message: _toastMessage!),
              ),
            ),
        ],
      ),
    );
  }
}

// ─── Vista previa de cámara ──────────────────────────────────────────────────

class _CameraPreviewArea extends StatelessWidget {
  const _CameraPreviewArea({required this.onShoot});
  final VoidCallback onShoot;

  @override
  Widget build(BuildContext context) {
    final cam = context.watch<CameraProvider>();

    if (cam.status == CameraStatus.initializing) {
      return const Center(
        child: CircularProgressIndicator(color: Colors.white),
      );
    }

    if (cam.status == CameraStatus.error) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Text(
            cam.errorMessage ?? 'Camera error',
            style: const TextStyle(color: Colors.white70),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: onShoot,
      child: SizedBox.expand(
        child: CameraPreview(cam.controller!),
      ),
    );
  }
}

// ─── Barra superior ──────────────────────────────────────────────────────────

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
            // Flash
            _CircleButton(
              icon: cam.flashOn ? Icons.flash_on : Icons.flash_off,
              color: cam.flashOn ? Colors.yellow : Colors.white,
              onTap: () => context.read<CameraProvider>().toggleFlash(),
            ),

            // Logo / título
            const Text(
              'AirSnap',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
              ),
            ),

            // Settings
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

// ─── Barra inferior ──────────────────────────────────────────────────────────

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
            // Última foto (miniatura)
            _LastPhotoThumb(path: cam.lastPhotoPath),

            // Botón de disparo principal
            GestureDetector(
              onTap: onShoot,
              child: _ShutterButton(isCapturing: cam.isCapturing),
            ),

            // Cambiar cámara
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

// ─── Botón de disparo ────────────────────────────────────────────────────────

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

// ─── Miniatura última foto ────────────────────────────────────────────────────

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
      child: Image.file(
        File(path!),
        width: 52, height: 52,
        fit: BoxFit.cover,
      ),
    );
  }
}

// ─── Botón circular auxiliar ─────────────────────────────────────────────────

class _CircleButton extends StatelessWidget {
  const _CircleButton({
    required this.icon,
    this.color = Colors.white,
    this.onTap,
  });
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44, height: 44,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black45,
        ),
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
      child: Text(
        message,
        style: const TextStyle(color: Colors.white, fontSize: 14),
      ),
    );
  }
}
