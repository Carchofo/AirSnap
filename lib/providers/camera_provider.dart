import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:gal/gal.dart';

enum CameraStatus { initializing, ready, capturing, error }

class CameraProvider extends ChangeNotifier {
  CameraController? _controller;
  List<CameraDescription> _cameras = [];
  CameraStatus _status = CameraStatus.initializing;
  String? _errorMessage;
  int _cameraIndex = 0;
  bool _flashOn = false;
  String? _lastPhotoPath;

  CameraController? get controller => _controller;
  CameraStatus get status => _status;
  String? get errorMessage => _errorMessage;
  bool get isReady => _status == CameraStatus.ready;
  bool get isCapturing => _status == CameraStatus.capturing;
  bool get flashOn => _flashOn;
  String? get lastPhotoPath => _lastPhotoPath;
  bool get hasMultipleCameras => _cameras.length > 1;

  Future<void> initialize() async {
    try {
      _cameras = await availableCameras();
      if (_cameras.isEmpty) {
        _setError('No cameras available');
        return;
      }
      await _initController(_cameraIndex);
    } catch (e) {
      _setError(e.toString());
    }
  }

  Future<void> _initController(int index) async {
    _status = CameraStatus.initializing;
    notifyListeners();

    await _controller?.dispose();
    _controller = CameraController(
      _cameras[index],
      ResolutionPreset.high,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    try {
      await _controller!.initialize();
      await _controller!.setFlashMode(
        _flashOn ? FlashMode.torch : FlashMode.off,
      );
      _status = CameraStatus.ready;
    } catch (e) {
      _setError(e.toString());
    }
    notifyListeners();
  }

  Future<void> takePhoto() async {
    if (_controller == null || !isReady) return;
    _status = CameraStatus.capturing;
    notifyListeners();

    try {
      final XFile file = await _controller!.takePicture();
      _lastPhotoPath = file.path;
      // Guarda en la galería del dispositivo
      await Gal.putImage(file.path);
      _status = CameraStatus.ready;
    } catch (e) {
      _setError(e.toString());
    }
    notifyListeners();
  }

  Future<void> switchCamera() async {
    if (_cameras.length < 2) return;
    _cameraIndex = (_cameraIndex + 1) % _cameras.length;
    await _initController(_cameraIndex);
  }

  Future<void> toggleFlash() async {
    _flashOn = !_flashOn;
    await _controller?.setFlashMode(
      _flashOn ? FlashMode.torch : FlashMode.off,
    );
    notifyListeners();
  }

  void _setError(String msg) {
    _status = CameraStatus.error;
    _errorMessage = msg;
    notifyListeners();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
