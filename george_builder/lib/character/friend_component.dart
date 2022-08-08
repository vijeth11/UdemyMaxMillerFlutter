import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:george_builder/main.dart';

class FriendComponent extends PositionComponent
    with CollisionCallbacks, HasGameRef<MyGeorgeGame> {
  FriendComponent() {
    var hitbox = RectangleHitbox();
    add(hitbox);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    print("made a friend");
    gameRef.friendNumber.value++;
    gameRef.remove(this);
    super.onCollision(intersectionPoints, other);
  }
}
