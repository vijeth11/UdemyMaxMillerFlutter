import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:simple_platform/game/actor/player.dart';
import 'package:simple_platform/game/game.dart';

class Enemy extends SpriteComponent
    with CollisionCallbacks, HasGameRef<SimplePlatformer> {
  Enemy(
    Image image, {
    Paint? paint,
    Vector2? targetPosition,
    Vector2? position,
    Vector2? size,
    Vector2? scale,
    double? angle,
    Anchor? anchor,
    int? priority,
  }) : super.fromImage(image,
            srcPosition: Vector2(1 * 32, 0),
            srcSize: Vector2.all(32),
            position: position,
            paint: paint,
            size: size,
            scale: scale,
            angle: angle,
            anchor: anchor,
            priority: priority) {
    final effect = SequenceEffect([
      MoveToEffect(targetPosition!, EffectController(speed: 100))
        ..onComplete = () {
          flipHorizontallyAroundCenter();
        },
      MoveToEffect(position! + Vector2(32, 0), EffectController(speed: 100))
        ..onComplete = () {
          flipHorizontallyAroundCenter();
        }
    ], infinite: true);
    add(effect);
  }

  @override
  Future<void>? onLoad() {
    add(CircleHitbox()..collisionType = CollisionType.passive);
    return super.onLoad();
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Player) {
      other.Hit();
      if (gameRef.playerData.health.value > 0)
        gameRef.playerData.health.value -= 1;
    }
    super.onCollisionStart(intersectionPoints, other);
  }
}
