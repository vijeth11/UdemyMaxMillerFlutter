import 'package:charlie_chicken/actors/platform.dart';
import 'package:charlie_chicken/actors/player.dart';
import 'package:charlie_chicken/game.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';

class TrapComponent extends SpriteAnimationComponent
    with CollisionCallbacks, HasGameRef<CharliChickenGame> {
  final Vector2 srcSize;
  final String imageName;
  final Vector2 objPosition;
  final Vector2 objSize;

  late SpriteAnimation flying;
  late SpriteAnimation flyingOff;

  bool isFallingDown = false;
  double velocity = 0;

  TrapComponent(
      {required this.srcSize,
      required this.imageName,
      required this.objPosition,
      required this.objSize});

  @override
  Future<void>? onLoad() {
    flyingOff = SpriteAnimation.fromFrameData(
        Flame.images.fromCache(imageName),
        SpriteAnimationData.sequenced(
            amount: 1, stepTime: 0.1, textureSize: srcSize));
    flying = SpriteAnimation.fromFrameData(
        Flame.images.fromCache('world/FallingPlatform.png'),
        SpriteAnimationData.sequenced(
            amount: 4, stepTime: 0.1, textureSize: srcSize));
    size = objSize;
    animation = flying;
    add(RectangleHitbox()..collisionType = CollisionType.passive);
    return super.onLoad();
  }

  @override
  void onGameResize(Vector2 size) {
    position = objPosition;
    super.onGameResize(size);
  }

  @override
  void update(double dt) {
    // TODO: implement update
    if (isFallingDown) {
      velocity += gameRef.gravity;
      position.y += velocity * dt;
    }
    super.update(dt);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    // TODO: implement onCollision
    super.onCollision(intersectionPoints, other);
    if (other is Player) {
      animation = flyingOff;
      isFallingDown = true;
    }
    if (other is Platform) {
      gameRef.remove(this);
    }
  }
}
