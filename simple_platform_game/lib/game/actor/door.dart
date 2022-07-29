import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:simple_platform/game/actor/player.dart';

class Door extends SpriteComponent with CollisionCallbacks {
  Function? onPlayerEnter;
  Door(
    Image image, {
    this.onPlayerEnter,
    Paint? paint,
    Vector2? position,
    Vector2? size,
    Vector2? scale,
    double? angle,
    Anchor? anchor,
    int? priority,
  }) : super.fromImage(image,
            srcPosition: Vector2(2 * 32, 0),
            srcSize: Vector2.all(32),
            position: position,
            paint: paint,
            size: size,
            scale: scale,
            angle: angle,
            anchor: anchor,
            priority: priority);

  @override
  Future<void>? onLoad() {
    add(RectangleHitbox()..collisionType = CollisionType.passive);
    return super.onLoad();
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Player) {
      onPlayerEnter?.call();
    }
    super.onCollisionStart(intersectionPoints, other);
  }
}
