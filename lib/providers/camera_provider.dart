import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:gal/gal.dart';

enum CameraStatus { initializing, ready, capturing, error, permissionDenied }

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
  bool get permissionDenied => _status == CameraStatus.permissionDenied;

  Future<void> initialize() async {
    _status = CameraStatus.initializing;
    notifyListeners();
    try {
      _cameras = await availableCameras();
      if (_cameras.isEmpty) {
        _setError('No cameras found');
        return;
      }
      await _initController(_cameraIndex);
    } catch (e) {
      _setError(e.toString());
    }
  }

  Future<void> _initController(int index) async {
    final old = _controller;
    _controller = null;
    notifyListeners(); // signal widget to stop using old controller

    try {
      await old?.dispose();
    } catch (_) {}

    final ctrl = CameraController(
      _cameras[index],
      ResolutionPreset.high,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    try {
      await ctrl.initialize();
      await ctrl.setFlashMode(_flashOn ? FlashMode.torch : FlashMode.off);
      _controller = ctrl;
      _status = CameraStatus.ready;
    } catch (e) {
      await ctrl.dispose();
      if (e is CameraException && e.code == 'CameraAccessDenied') {
        _status = CameraStatus.permissionDenied;
      } else {
        _setError(e.toString());
      }
    }
    notifyListeners();
  }

  Future<void> takePhoto() async {
    final ctrl = _controller;
    if (ctrl == null || !ctrl.value.isInitialized || _status != CameraStatus.ready) return;

    _status = CameraStatus.capturing;
    notifyListeners();

    try {
      final XFile file = await ctrl.takePicture();
      _lastPhotoPath = file.path;
      await Gal.putImage(file.path);
    } catch (e) {
      _setError(e.toString());
      return;
    }

    _status = CameraStatus.ready;
    notifyListeners();
  }

  Future<void> switchCamera() async {
    if (_cameras.length < 2) return;
    _cameraIndex = (_cameraIndex + 1) % _cameras.length;
    await _initController(_cameraIndex);
  }

  Future<void> toggleFlash() async {
    _flashOn = !_flashOn;
    try {
      await _controller?.setFlashMode(_flashOn ? FlashMode.torch : FlashMode.off);
    } catch (_) {}
    notifyListeners();
  }

  void notifyPermissionDenied() {
    _status = CameraStatus.permissionDenied;
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
