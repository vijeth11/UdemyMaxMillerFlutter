import 'package:charlie_chicken/actors/player.dart';
import 'package:charlie_chicken/game.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';

class RewardComponent extends SpriteAnimationComponent
    with CollisionCallbacks, HasGameRef<CharliChickenGame> {
  final Vector2 srcSize;
  final String imageName;
  final Vector2 objPosition;
  final Vector2 objSize;
  late SpriteSheet appleSheet;
  late SpriteAnimation collected;

  RewardComponent(
      {required this.srcSize,
      required this.imageName,
      required this.objPosition,
      required this.objSize});

  @override
  Future<void>? onLoad() {
    appleSheet = SpriteSheet(
        image: Flame.images.fromCache('world/AppleSheet.png'),
        srcSize: srcSize);
    collected = SpriteSheet(
            image: Flame.images.fromCache('world/Collected.png'),
            srcSize: Vector2(32, 32))
        .createAnimation(row: 0, stepTime: 0.1, from: 0, to: 6, loop: false)
      ..completed.then((value) => removeFromParent());
    animation =
        appleSheet.createAnimation(row: 0, stepTime: 0.1, from: 0, to: 17);
    size = Vector2(64, 64);
    // this is added so collition does not stay active and stop animation changing
    // on collision but allow animation to change and complete and end collision
    var hitbox = RectangleHitbox.relative(Vector2(0.6, 0.6), parentSize: size);
    add(hitbox..collisionType = CollisionType.passive);
    //debugMode = true;
    return super.onLoad();
  }

  @override
  void onGameResize(Vector2 size) {
    position = objPosition;
    anchor = Anchor.bottomLeft;
    print(anchor);
    super.onGameResize(size);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    // TODO: implement onCollision
    super.onCollision(intersectionPoints, other);
    if (other is Player) {
      animation = collected;
    }
  }
}
