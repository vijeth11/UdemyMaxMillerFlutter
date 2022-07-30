import 'dart:math';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/services.dart';
import 'package:simple_platform/game/actor/platform.dart';
import 'package:simple_platform/game/game.dart';
import 'package:simple_platform/game/utils/audio_manager.dart';

class Player extends SpriteComponent
    with CollisionCallbacks, KeyboardHandler, HasGameRef<SimplePlatformer> {
  final Vector2 _velocity = Vector2.all(0);
  int _haxisInput = 0;
  final double speed = 200;
  final double gravity = 10;
  final double jumpspeed = 400;
  bool jumpHit = false;
  bool onGround = false;
  late Vector2 minClamp;
  late Vector2 maxClamp;

  Player(
    Image image, {
    required Rect levelBounds,
    Paint? paint,
    Vector2? position,
    Vector2? size,
    Vector2? scale,
    double? angle,
    Anchor? anchor,
    int? priority,
  }) : super.fromImage(image,
            srcPosition: Vector2.zero(),
            srcSize: Vector2.all(32),
            position: position,
            paint: paint,
            size: size,
            scale: scale,
            angle: angle,
            anchor: anchor,
            priority: priority) {
    // half size because now detection point is at the center of the sprite
    // ref https://www.youtube.com/watch?v=GATCZj4tELA
    minClamp =
        Vector2(levelBounds.topLeft.dx, levelBounds.topLeft.dy) + size! / 2;
    maxClamp = Vector2(levelBounds.bottomRight.dx, levelBounds.bottomRight.dy) -
        size / 2;
  }
  @override
  Future<void>? onLoad() {
    add(RectangleHitbox());
    return super.onLoad();
  }

  @override
  void update(double dt) {
    _velocity.x = _haxisInput * speed;
    _velocity.y += gravity;
    if (jumpHit == true) {
      _velocity.y = -jumpspeed;
      jumpHit = false;
      onGround = false;
      AudioManager.playSfx('Jump_15.wav');
    }
    _velocity.y = _velocity.y.clamp(-jumpspeed, 150);
    position += _velocity * dt;
    position.clamp(minClamp, maxClamp);
    if (_haxisInput < 0 && scale.x > 0) {
      flipHorizontallyAroundCenter();
    } else if (_haxisInput > 0 && scale.x < 0) {
      flipHorizontallyAroundCenter();
    }
    super.update(dt);
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    //_haxisInput = 0;
    // Needs to be changed later to joystick as system keyboard will not work properly
    //_haxisInput += keysPressed.contains(LogicalKeyboardKey.arrowUp) ? -1 : 0;
    //_haxisInput += keysPressed.contains(LogicalKeyboardKey.arrowDown) ? 1 : 0;
    //jumpHit = keysPressed.contains(LogicalKeyboardKey.arrowRight) && onGround;
    return true;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Platform) {
      //Calculation for staying on ground and not going through wall
      // ref https://www.youtube.com/watch?v=mSPalRqZQS8&list=PLiZZKL9HLmWPyd808sda2ydG-dhexNONV&index=5
      final mid = (intersectionPoints.first + intersectionPoints.last) / 2;
      //print("mid $mid");
      //print("absolute $absoluteCenter");
      final collisionPoint = absoluteCenter - mid;
      //print("collision $collisionPoint");
      final seperationDistance = (size.x / 2) - collisionPoint.length;
      //print(seperationDistance);
      collisionPoint.normalize();
      if (Vector2(0, -1).dot(collisionPoint) > 0.9) {
        onGround = true;
      }
      position += collisionPoint.scaled(seperationDistance);
      // if (intersectionPoints.first.y == intersectionPoints.last.y) {
      //   position.y = intersectionPoints.last.y - size.y / 2;
      //   onGround = true;
      // }

      // if (intersectionPoints.first.x == other.position.x) {
      //   position.x = intersectionPoints.first.x - size.x / 2;
      // }

      // if (intersectionPoints.last.x == (other.position.x + other.size.x)) {
      //   if (_haxisInput == 1 || (_haxisInput == 0 && scale.x > 0)) {
      //     position.x = intersectionPoints.first.x;
      //   } else {
      //     position.x = intersectionPoints.last.x + size.x / 2;
      //   }
      // }
    }
    super.onCollision(intersectionPoints, other);
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    if (other is Platform) {
      onGround = false;
    }
    super.onCollisionEnd(other);
  }

  void Hit() {
    add(OpacityEffect.fadeOut(
        EffectController(alternate: true, duration: 0.1, repeatCount: 5)));
  }

  void jump() {
    jumpHit = true;
    onGround = true;
  }

  void jumpButtonhit() {
    jumpHit = onGround;
  }

  void horizontalMovement(int value) {
    _haxisInput = value;
    print("direction set");
  }
}
