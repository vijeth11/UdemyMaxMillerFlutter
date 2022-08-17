import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:leena/main.dart';
import 'package:leena/world/ground.dart';

class Leena extends SpriteAnimationComponent
    with CollisionCallbacks, HasGameRef<LeenaGame> {
  bool onGround = false;
  bool facingRight = true;
  final Vector2 sizeOfImage = Vector2(170, 222);
  final double animationSpeed = 0.1;
  late SpriteAnimation moving;
  late SpriteAnimation onePush;
  late SpriteAnimation jump;
  late SpriteAnimation ideal;
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

    var movingSheet = SpriteSheet(
        image: Flame.images.fromCache('moving.png'), srcSize: sizeOfImage);
    moving = movingSheet.createAnimation(
        row: 0, stepTime: animationSpeed, to: 19, loop: true);
    var onePushSheet = SpriteSheet(
        image: Flame.images.fromCache('onePush.png'), srcSize: sizeOfImage);
    onePush = onePushSheet.createAnimation(
        row: 0, stepTime: 0.1, to: 19, loop: false)
      ..onComplete = () => animation = moving;
    var jumpSheet = SpriteSheet(
        image: Flame.images.fromCache('jump.png'), srcSize: sizeOfImage);
    jump = jumpSheet.createAnimation(row: 0, stepTime: 0.1, to: 12, loop: true);
    var idealSheet = SpriteSheet(
        image: Flame.images.fromCache('girl.png'), srcSize: sizeOfImage);
    ideal =
        idealSheet.createAnimation(row: 0, stepTime: 0.1, to: 1, loop: true);
    animation = ideal;
    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (!onGround) {
      gameRef.velocity.y += gameRef.gravity;
    }
    // check if leena is inside boundry before adding velocity
    if (x > 0 && x - width < gameRef.mapWidth) {
      if (onGround) {
        // going right
        if (facingRight) {
          if (gameRef.velocity.x < 0) {
            gameRef.velocity.x += gameRef.groundFriction;
          } else if (gameRef.velocity.x > 0) {
            gameRef.velocity.x -= gameRef.groundFriction;
            // stop leena once velocity is reached 0 by friction
            if (gameRef.velocity.x < 0) {
              gameRef.velocity.x = 0;
            }
          }
        }
        // going left
        else {
          if (gameRef.velocity.x > 0) {
            gameRef.velocity.x -= gameRef.groundFriction;
          } else if (gameRef.velocity.x < 0) {
            gameRef.velocity.x += gameRef.groundFriction;
            // stop leena once velocity is reached 0 by friction
            if (gameRef.velocity.x > 0) {
              gameRef.velocity.x = 0;
              animation = ideal;
            }
          }
        }
      }
    } else {
      gameRef.velocity.x = 0;
      // bounce back so leena can move again
      x += x <= 0 ? width : -1.5*width;
    }
    if (gameRef.velocity.x == 0) {
      animation = ideal;
    }
    position += gameRef.velocity * dt;
    super.update(dt);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Ground) {
      gameRef.velocity.y = 0;
      // Bounce back a bit and not go into the ground. Check if the ground is not too high it can be side wall
      if (!onGround && y - intersectionPoints.last[1] > 3 && y - intersectionPoints.last[1] < 20) {
        y -= y - intersectionPoints.last[1] - 3;
        animation = gameRef.velocity.x == 0 ? ideal : moving;
        onGround = true;
      }
      if (gameRef.velocity.x != 0) {
        for (var point in intersectionPoints) {
          if (y - 20 >= point[1]) {
            print("Hit the wall");
            gameRef.velocity.x = facingRight ? -10 : 10;
            animation = ideal;
          }
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
