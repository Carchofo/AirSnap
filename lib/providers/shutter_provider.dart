import 'package:flutter/material.dart';

enum ShutterStatus { waiting, detected }

/// Holds the Bluetooth shutter detection state.
/// The volume-key listener in [HomeScreen] calls [triggerDetected].
class ShutterProvider extends ChangeNotifier {
  ShutterStatus _status = ShutterStatus.waiting;

  ShutterStatus get status => _status;

  bool get isDetected => _status == ShutterStatus.detected;

  void triggerDetected() {
    _status = ShutterStatus.detected;
    notifyListeners();
  }

  void reset() {
    _status = ShutterStatus.waiting;
    notifyListeners();
  }
}
