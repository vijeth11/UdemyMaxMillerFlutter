import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:simple_platform/game/actor/player.dart';
import 'package:simple_platform/game/game.dart';
import 'package:simple_platform/game/overlays/game_over.dart';
import 'package:simple_platform/game/utils/audio_manager.dart';

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
      // calculate the direction by subtracting player center from enemy center
      // change the direction vector to unit vector by normalizing to get thedirection
      // dot product it with (0,-1) for up if value is less than 0 then it is from up
      final positionOfEnemyfromPlayer =
          (absoluteCenter - other.absoluteCenter).normalized();
      var product = Vector2(0, -1).dot(positionOfEnemyfromPlayer);
      if (product < 0) {
        add(OpacityEffect.fadeOut(LinearEffectController(0.2),
            onComplete: () => removeFromParent()));
        other.jump();
        print("collided from top");
      } else {
        AudioManager.playSfx('Hit_2.wav');
        other.Hit();
        if (gameRef.playerData.health.value > 1) {
          gameRef.playerData.health.value -= 1;
        } else {
          gameRef.playerData.health.value -= 1;
          gameRef.pauseEngine();
          gameRef.overlays.add(GameOver.id);
          AudioManager.stopBgm();
        }
      }
    }
    super.onCollisionStart(intersectionPoints, other);
  }
}
