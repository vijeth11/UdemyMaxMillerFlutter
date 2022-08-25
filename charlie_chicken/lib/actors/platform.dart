import 'package:charlie_chicken/actors/level.dart';
import 'package:charlie_chicken/actors/player.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Platform extends PositionComponent
    with CollisionCallbacks, ParentIsA<Level> {
  final bool isEndBox;
  final bool isBottomGround;
  Platform(
      {required size,
      required position,
      required this.isEndBox,
      required this.isBottomGround})
      : super(position: position, size: size);

  @override
  Future<void>? onLoad() {
    // TODO: implement onLoad
    add(RectangleHitbox());
    //debugMode = true;
    return super.onLoad();
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    // TODO: implement onCollision
    super.onCollision(intersectionPoints, other);
    if (isEndBox && other is Player) {
      parent.gameOver();
    }
  }
}
