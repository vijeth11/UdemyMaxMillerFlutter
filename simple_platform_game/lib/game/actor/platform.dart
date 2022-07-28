import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/cupertino.dart';

class Platform extends PositionComponent with CollisionCallbacks {
  Platform(
      {@required Vector2? position,
      @required Vector2? size,
      Vector2? scale,
      double? angle,
      Anchor? anchor})
      : super(
            position: position,
            size: size,
            scale: scale,
            anchor: anchor,
            angle: angle);

  @override
  // TODO: implement debugMode
  bool get debugMode => true;
  @override
  Future<void>? onLoad() {
    add(RectangleHitbox()..collisionType = CollisionType.passive);
    return super.onLoad();
  }
}
