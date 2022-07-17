import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:galaxygame/main.dart';

const double SPEED = 120.0;
const double ComponentSize = 50.0;

class VillanComponent extends SpriteComponent
    with HasGameRef<MyGame>, CollisionCallbacks {
  late double maxY;
  late ShapeHitbox hitbox;
  final double xAxisPosition;
  VillanComponent(this.xAxisPosition)
      : super(
            sprite: Sprite(
              Flame.images.fromCache('dragon.png'),
            ),
            size: Vector2.all(ComponentSize));

  @override
  Future<void>? onLoad() {
    // TODO: implement onLoad
    final defaultPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke;
    hitbox = RectangleHitbox()
      ..paint = defaultPaint
      ..renderShape = true;
    add(hitbox);
  }

  @override
  void update(double dt) {
    y += dt * SPEED;
    if (y > gameRef.canvasSize.toRect().height) {
      removeFromParent();
    }
  }

  @override
  void onGameResize(Vector2 size) {
    // TODO: implement onGameResize
    x = xAxisPosition;
    y = 0;
    maxY = gameRef.size.toRect().height;
  }

  @override
  void onRemove() {
    // TODO: implement onRemove
    print("removed villan");
    super.onRemove();
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    // TODO: implement onCollision
    super.onCollision(intersectionPoints, other);
    if (other is ScreenHitbox) {
      if (intersectionPoints.first[0] == -0.0) {
        removeFromParent();
        return;
      }
      if (intersectionPoints.first[1] == intersectionPoints.last[1]) {
        gameRef.displayGameOver();
      }
    }
  }
}
