import 'package:charlie_chicken/actors/platform.dart';
import 'package:charlie_chicken/game.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';

enum PlayerAnimation { Running, Hit, Idel }

class Player extends SpriteAnimationComponent
    with HasGameRef<CharliChickenGame>, CollisionCallbacks {
  late SpriteAnimation runAnimation;
  late SpriteAnimation idelAnimation;
  late SpriteAnimation hitAnimation;
  final Vector2 characterImageSize = Vector2(32, 34);
  final double animationFrameTime = 0.1;
  final double maxPlayerVelocity = 170;

  List<PositionComponent> itemsCollidedwith = [];

  double velocity = 1;
  bool isOnGround = false;
  bool isPlayerHit = false;

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
    //debugMode = true;
    add(RectangleHitbox.relative(Vector2(0.6, 1), parentSize: size));
    anchor = Anchor.bottomCenter;
    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (position.x + (size.x / 2) >= gameRef.size.x) {
      position.x = gameRef.size.x - (size.x / 2);
    } else if (position.x <= 0) {
      position.x = 0;
    }

    if (!isOnGround) {
      velocity += gameRef.gravity;
      velocity = velocity.clamp(-500, maxPlayerVelocity);
      position.y += velocity * dt;
    }
    super.update(dt);
  }

  void setAnimation(PlayerAnimation currentAnimation) {
    if (!isPlayerHit) {
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

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    // TODO: implement onCollision
    if (other is Platform) {
      if (!itemsCollidedwith.any((element) => element == other)) {
        itemsCollidedwith.add(other);
      }
      print("velocity $velocity");
      if (!isOnGround &&
          other.isBottomGround &&
          velocity == maxPlayerVelocity) {
        velocity = 0;
        isPlayerHit = true;
        y = other.y;
        hitAnimation.reset();
        animation = hitAnimation..onComplete = gameRef.playerRestart;
      } else {
        velocity = 0;
        if (!isOnGround &&
            y - intersectionPoints.last.y >= 0 &&
            y - intersectionPoints.last.y < 15) {
          print("difference  ${y - intersectionPoints.last.y}");
          isOnGround = true;
          //y = y - (y - intersectionPoints.last.y) - 3;
          y = other.y;
        }
        for (var point in intersectionPoints) {
          if (y - 15 >= point[1]) {
            position.x += gameRef.chickenFacingLeft ? 30 : -30;
          }
        }
      }
    }
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    // TODO: implement onCollisionEnd
    super.onCollisionEnd(other);
    if (other is Platform) {
      itemsCollidedwith.remove(other);
      print(itemsCollidedwith);
      if (!itemsCollidedwith.any((element) => element is Platform)) {
        isOnGround = false;
        //velocity = 1;
      }
    }
  }
}
