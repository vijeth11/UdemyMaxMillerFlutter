import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:george_builder/character/obstacle_component.dart';
import 'package:george_builder/my_george_game.dart';

class GeorgeComponent extends SpriteAnimationComponent
    with CollisionCallbacks, HasGameRef<MyGeorgeGame> {
  late SpriteAnimation downAnimation;
  late SpriteAnimation upAnimation;
  late SpriteAnimation idelAnimation;
  late SpriteAnimation leftAnimation;
  late SpriteAnimation rightAnimation;

  double animationSpeed = 0.1;
  int direction = 0;
  int collisionDirection = -1;
  bool hasCollided = false;

  GeorgeComponent() {}

  @override
  Future<void>? onLoad() {
    final spriteSheet = SpriteSheet(
        image: Flame.images.fromCache('george2.png'), srcSize: Vector2.all(48));
    downAnimation = spriteSheet.createAnimation(
        row: 0, stepTime: animationSpeed, to: 4, loop: true);
    leftAnimation = spriteSheet.createAnimation(
        row: 1, stepTime: animationSpeed, to: 4, loop: true);
    upAnimation = spriteSheet.createAnimation(
        row: 2, stepTime: animationSpeed, to: 4, loop: true);
    rightAnimation = spriteSheet.createAnimation(
        row: 3, stepTime: animationSpeed, to: 4, loop: true);
    idelAnimation = spriteSheet.createAnimation(
        row: 0, stepTime: animationSpeed, to: 1, loop: true);

    animation = idelAnimation;
    var paint = Paint()..color = Color.fromARGB(255, 195, 67, 235);
    var hitBox = RectangleHitbox.relative(Vector2.all(0.75), parentSize: size)
      ..renderShape = false
      ..paint = paint;
    add(hitBox);
    return super.onLoad();
  }

  @override
  void update(double dt) {
    // move george after the user read dialog
    if (gameRef.displayMessage.value.isEmpty) {
      switch (direction) {
        case 0:
          animation = idelAnimation;
          break;
        case 1:
          animation = downAnimation;
          if (y < gameRef.mapHeight - height) {
            if (collisionDirection != 1) {
              y += dt * gameRef.characterSpeed;
            }
          }
          break;
        case 2:
          animation = leftAnimation;
          if (x > 0) {
            if (collisionDirection != 2) {
              x -= dt * gameRef.characterSpeed;
            }
          }
          break;
        case 3:
          animation = upAnimation;
          if (y > 0) {
            if (collisionDirection != 3) {
              y -= dt * gameRef.characterSpeed;
            }
          }
          break;
        case 4:
          animation = rightAnimation;
          if (x < gameRef.mapWidth - width) {
            if (collisionDirection != 4) {
              x += dt * gameRef.characterSpeed;
            }
          }
          break;
      }
    }
    super.update(dt);
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is ObstacleComponent && !hasCollided) {
      collisionDirection = direction;
      hasCollided = true;
    }
    super.onCollisionStart(intersectionPoints, other);
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    if (other is ObstacleComponent) {
      collisionDirection = -1;
      hasCollided = false;
    }
    super.onCollisionEnd(other);
  }
}
