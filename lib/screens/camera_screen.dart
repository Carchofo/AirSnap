import 'dart:async';

import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../l10n/app_localizations.dart';
import 'settings_screen.dart';

const _kVolumeChannel = EventChannel('com.airsnap.airsnap/volume');

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  StreamSubscription? _volumeSub;
  bool _showFlash = false;
  String? _toastMessage;
  Timer? _toastTimer;
  bool _shooting = false;
  CameraState? _cameraState;

  @override
  void initState() {
    super.initState();
    _listenVolumeKeys();
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
    if (_shooting || _cameraState == null) return;
    _shooting = true;

    setState(() => _showFlash = true);
    Future.delayed(const Duration(milliseconds: 120), () {
      if (mounted) setState(() => _showFlash = false);
    });

    await _cameraState!.when(
      onPhotoMode: (state) => state.takePhoto(),
    );

    _shooting = false;
    if (mounted) _showToast(AppLocalizations.of(context).status_detected);
  }

  void _showToast(String msg) {
    setState(() => _toastMessage = msg);
    _toastTimer?.cancel();
    _toastTimer = Timer(const Duration(seconds: 2), () {
      if (mounted) setState(() => _toastMessage = null);
    });
  }

  @override
  void dispose() {
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
          CameraAwesomeBuilder.awesome(
            // Guarda en directorio temporal; camerawesome mueve a galería internamente
            saveConfig: SaveConfig.photo(),
            availableFilters: awesomePresetFiltersList,

            topActionsBuilder: (state) {
              _cameraState = state;
              return AwesomeTopActions(
                state: state,
                children: [
                  AwesomeFlashButton(state: state),
                  const Spacer(),
                  const Text(
                    'AirSnap',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const Spacer(),
                  _CircleButton(
                    icon: Icons.settings_outlined,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const SettingsScreen()),
                    ),
                  ),
                ],
              );
            },

            bottomActionsBuilder: (state) {
              _cameraState = state;
              return AwesomeBottomActions(
                state: state,
                captureButton: GestureDetector(
                  onTap: _shoot,
                  child: _ShutterButton(shooting: _shooting),
                ),
              );
            },

            // Filtros deslizables encima del botón de disparo
            middleContentBuilder: (state) => Column(
              children: [
                const Spacer(),
                AwesomeFilterWidget(
                  state: state,
                  filterListPosition: FilterListPosition.aboveButton,
                ),
              ],
            ),
          ),

          if (_showFlash) const ColoredBox(color: Colors.white60),

          if (_toastMessage != null)
            Positioned(
              bottom: 180, left: 0, right: 0,
              child: Center(child: _Toast(message: _toastMessage!)),
            ),
        ],
      ),
    );
  }
}

class _ShutterButton extends StatelessWidget {
  const _ShutterButton({required this.shooting});
  final bool shooting;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      width: shooting ? 72 : 80,
      height: shooting ? 72 : 80,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 4),
        color: shooting ? Colors.white54 : Colors.white24,
      ),
      child: Center(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          width: shooting ? 52 : 60,
          height: shooting ? 52 : 60,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class _CircleButton extends StatelessWidget {
  const _CircleButton({required this.icon, this.onTap});
  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44, height: 44,
        decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.black45),
        child: Icon(icon, color: onTap == null ? Colors.white24 : Colors.white, size: 22),
      ),
    );
  }
}

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
