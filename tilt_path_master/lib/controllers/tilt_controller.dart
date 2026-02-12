import 'dart:async';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:flutter/material.dart';

/// Controller for handling device tilt input
class TiltController {
  final StreamController<Offset> _tiltStreamController = StreamController<Offset>.broadcast();
  StreamSubscription<AccelerometerEvent>? _accelerometerSubscription;
  
  double sensitivity = 1.0;
  bool _isActive = false;

  /// Stream of tilt values as Offset (x, y)
  Stream<Offset> get tiltStream => _tiltStreamController.stream;

  /// Start listening to accelerometer
  void start() {
    if (_isActive) return;
    _isActive = true;

    _accelerometerSubscription = accelerometerEvents.listen((AccelerometerEvent event) {
      if (!_isActive) return;

      // Convert accelerometer values to tilt
      // Note: Accelerometer gives gravity direction, so we negate for intuitive control
      // In landscape mode, x is horizontal tilt, y is forward/backward tilt
      double tiltX = -event.y * sensitivity; // Left/right tilt
      double tiltY = event.x * sensitivity;  // Forward/backward tilt

      // Clamp values to reasonable range
      tiltX = tiltX.clamp(-10.0, 10.0);
      tiltY = tiltY.clamp(-10.0, 10.0);

      _tiltStreamController.add(Offset(tiltX, tiltY));
    });
  }

  /// Stop listening to accelerometer
  void stop() {
    _isActive = false;
    _accelerometerSubscription?.cancel();
    _accelerometerSubscription = null;
  }

  /// Pause tilt input
  void pause() {
    _isActive = false;
  }

  /// Resume tilt input
  void resume() {
    _isActive = true;
  }

  /// Update sensitivity (0.5 to 2.0)
  void setSensitivity(double value) {
    sensitivity = value.clamp(0.5, 2.0);
  }

  /// Dispose resources
  void dispose() {
    stop();
    _tiltStreamController.close();
  }
}
