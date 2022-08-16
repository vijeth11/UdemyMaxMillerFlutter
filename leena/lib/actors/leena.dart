import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:leena/main.dart';
import 'package:leena/world/ground.dart';

class Leena extends SpriteComponent
    with CollisionCallbacks, HasGameRef<LeenaGame> {
  bool onGround = false;
  Leena() : super() {
    debugMode = true;
  }

  @override
  Future<void>? onLoad() {
    // TODO: implement onLoad
    var hitbox = PolygonHitbox([
      Vector2(40, 0),
      Vector2(size.x - 20, 0),
      Vector2(size.x - 20, size.y),
      Vector2(40, size.y),
    ]);
    add(hitbox
      ..renderShape = false
      ..paint = (Paint()..color = Colors.red));
    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (!onGround) {
      gameRef.velocity.y += gameRef.gravity;
      position.y += gameRef.velocity.y * dt;
    }
    super.update(dt);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Ground) {
      gameRef.velocity.y = 0;
      onGround = true;
    }
    super.onCollision(intersectionPoints, other);
  }
}
