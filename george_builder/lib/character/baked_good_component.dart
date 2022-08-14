import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:george_builder/my_george_game.dart';

class BakedComponent extends SpriteComponent
    with CollisionCallbacks, HasGameRef<MyGeorgeGame> {
  BakedComponent() {
    debugMode = false;
  }

  @override
  Future<void>? onLoad() {
    var hitBox = RectangleHitbox.relative(Vector2.all(0.5), parentSize: size);
    add(hitBox);
    return super.onLoad();
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    gameRef.bakedGroupInventory.value++;
    print("backed goods inventory ${gameRef.bakedGroupInventory}");
    gameRef.yummy.start();
    gameRef.remove(this);
    super.onCollision(intersectionPoints, other);
  }
}
