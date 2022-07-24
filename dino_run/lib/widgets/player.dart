import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';

class Player extends SpriteAnimationComponent {
  late SpriteAnimation idelAnimation;
  late SpriteAnimation runAnimation;
  late SpriteAnimation kickAnimation;
  late SpriteAnimation hitAnimation;
  late SpriteAnimation sprintAnimation;
  final Vector2 playerSize;
  final Vector2 playerPosition;

  Player(this.playerSize, this.playerPosition) {
    size = playerSize;
    position = playerPosition;
  }

  @override
  Future<void>? onLoad() {
    var dinoSpriteSheet = SpriteSheet(
        image: Flame.images.fromCache('DinoSprites - tard.png'),
        srcSize: Vector2.all(24));

    idelAnimation = dinoSpriteSheet.createAnimation(
        row: 0, stepTime: 0.1, from: 0, to: 4, loop: true);

    runAnimation = dinoSpriteSheet.createAnimation(
        row: 0, stepTime: 0.1, from: 4, to: 10, loop: true);

    kickAnimation = dinoSpriteSheet.createAnimation(
        row: 0, stepTime: 0.1, from: 11, to: 13);

    hitAnimation = dinoSpriteSheet.createAnimation(
        row: 0, stepTime: 0.1, from: 14, to: 16);

    sprintAnimation = dinoSpriteSheet.createAnimation(
        row: 0, stepTime: 0.1, from: 17, to: 23);

    animation = runAnimation;
    return super.onLoad();
  }
}
