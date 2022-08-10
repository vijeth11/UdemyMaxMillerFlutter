import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:george_builder/my_george_game.dart';

class ObstacleComponent extends PositionComponent
    with CollisionCallbacks, HasGameRef<MyGeorgeGame> {
  ObstacleComponent({required Vector2 position, required Vector2 size})
      : super(position: position, size: size);

  @override
  Future<void>? onLoad() {
    var hitBox = RectangleHitbox();
    add(hitBox);
    return super.onLoad();
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    // TODO: implement onCollision
    super.onCollision(intersectionPoints, other);
  }
}
