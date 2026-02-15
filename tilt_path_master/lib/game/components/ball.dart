import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

/// Ball component with physics-based movement
class Ball extends PositionComponent {
  static const double radius = 15.0;
  static const double friction = 0.95;
  static const double maxSpeed = 200.0;

  Vector2 velocity = Vector2.zero();
  final Paint _paint = Paint()..color = Colors.blue.shade700;
  final Paint _highlightPaint = Paint()..color = Colors.white.withOpacity(0.3);

  Ball({Vector2? position}) {
    this.position = position ?? Vector2.zero();
    size = Vector2.all(radius * 2);
    anchor = Anchor.center;
  }

  /// Apply tilt force to the ball
  void applyTilt(double tiltX, double tiltY) {
    // Convert tilt to acceleration
    const acceleration = 5.0;
    velocity.x += tiltX * acceleration;
    velocity.y += tiltY * acceleration;

    // Limit speed
    final speed = velocity.length;
    if (speed > maxSpeed) {
      velocity = velocity.normalized() * maxSpeed;
    }
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Apply velocity
    position += velocity * dt;

    // Apply friction
    velocity *= friction;

    // Stop if very slow
    if (velocity.length < 0.5) {
      velocity = Vector2.zero();
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    // Draw shadow
    final shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.3)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);
    canvas.drawCircle(
      const Offset(radius + 2, radius + 2),
      radius,
      shadowPaint,
    );

    // Draw ball
    canvas.drawCircle(
      const Offset(radius, radius),
      radius,
      _paint,
    );

    // Draw highlight for 3D effect
    canvas.drawCircle(
      const Offset(radius - 5, radius - 5),
      radius * 0.3,
      _highlightPaint,
    );
  }

  /// Check if ball center overlaps with a circular area (for pit detection)
  bool overlapsWithCircle(Vector2 circleCenter, double circleRadius) {
    final distance = position.distanceTo(circleCenter);
    return distance < circleRadius * 0.5; // 50% overlap triggers
  }

  /// Check if ball is within a rectangular area
  bool isWithinRect(Rect rect) {
    return rect.contains(position.toOffset());
  }
}
