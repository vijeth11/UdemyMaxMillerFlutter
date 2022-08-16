import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:leena/main.dart';
import 'package:leena/world/ground.dart';

class Leena extends SpriteComponent
    with CollisionCallbacks, HasGameRef<LeenaGame> {
  bool onGround = false;
  bool facingRight = true;
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
    anchor = Anchor.bottomCenter;
    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (!onGround) {
      gameRef.velocity.y += gameRef.gravity;
    }
    position += gameRef.velocity * dt;
    super.update(dt);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Ground) {
      gameRef.velocity.y = 0;
      // Bounce back a bit and not go into the ground
      if (!onGround && y - intersectionPoints.last[1] > 3) {
        y -= y - intersectionPoints.last[1] - 3;
        onGround = true;
      }
      if (gameRef.velocity.x != 0) {
        for (var point in intersectionPoints) {
          if (y - 20 >= point[1]) {
            print("Hit the wall");
            gameRef.velocity.x = facingRight ? -5 : 5;
          }
          print(point);
        }
      }
    }
    super.onCollision(intersectionPoints, other);
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    onGround = false;
    super.onCollisionEnd(other);
  }
}
