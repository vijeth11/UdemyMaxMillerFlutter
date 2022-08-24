import 'package:charlie_chicken/game.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';

enum PlayerAnimation { Running, Hit, Idel }

class Player extends SpriteAnimationComponent
    with HasGameRef<CharliChickenGame> {
  late SpriteAnimation runAnimation;
  late SpriteAnimation idelAnimation;
  late SpriteAnimation hitAnimation;
  final Vector2 characterImageSize = Vector2(32, 34);
  final double animationFrameTime = 0.1;
  @override
  Future<void>? onLoad() {
    runAnimation = SpriteAnimation.fromFrameData(
        Flame.images.fromCache('ChickenRun.png'),
        SpriteAnimationData.sequenced(
            amount: 14,
            stepTime: animationFrameTime,
            textureSize: characterImageSize));
    idelAnimation = SpriteAnimation.fromFrameData(
        Flame.images.fromCache('ChickenIdel.png'),
        SpriteAnimationData.sequenced(
            amount: 13,
            stepTime: animationFrameTime,
            textureSize: characterImageSize));
    hitAnimation = SpriteAnimation.fromFrameData(
        Flame.images.fromCache('ChickenHit.png'),
        SpriteAnimationData.sequenced(
            loop: false,
            amount: 5,
            stepTime: animationFrameTime,
            textureSize: characterImageSize));
    animation = idelAnimation;
    size = Vector2.all(80);
    add(RectangleHitbox());
    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (position.x + (size.x / 2) >= gameRef.size.x) {
      position.x = gameRef.size.x - (size.x / 2);
    } else if (position.x <= 0) {
      position.x = 0;
    }
    super.update(dt);
  }

  void setAnimation(PlayerAnimation currentAnimation) {
    switch (currentAnimation) {
      case PlayerAnimation.Idel:
        animation = idelAnimation;
        break;
      case PlayerAnimation.Hit:
        animation = hitAnimation
          ..onComplete = () => print("remove the player and reposition");
        break;
      case PlayerAnimation.Running:
        animation = runAnimation;
        break;
      default:
        animation = idelAnimation;
        break;
    }
  }
}
