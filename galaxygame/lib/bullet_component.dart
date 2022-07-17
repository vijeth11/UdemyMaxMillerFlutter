import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:galaxygame/main.dart';
import 'package:galaxygame/villan_component.dart';

const double ComponentSize = 40.0;
const double SPEED = 120;

class BulletComponent extends SpriteComponent
    with HasGameRef<MyGame>, CollisionCallbacks {
  final Vector2 Position;
  late ShapeHitbox hitbox;
  BulletComponent(this.Position)
      : super(
            sprite: Sprite(Flame.images.fromCache('bullet.png')),
            position: Position,
            size: Vector2.all(ComponentSize),
            anchor: Anchor.center);

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
    y -= dt * SPEED;
    if (y == 0) {
      removeFromParent();
    }
    super.update(dt);
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    // TODO: implement onCollision
    super.onCollisionStart(intersectionPoints, other);
    if (other is VillanComponent) {
      gameRef.score += 1;
      other.removeFromParent();
      removeFromParent();
      print("Collided bullet");
    }
  }
}
