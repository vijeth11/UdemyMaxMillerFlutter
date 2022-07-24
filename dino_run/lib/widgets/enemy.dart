import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';

class Enemy extends SpriteAnimationComponent with HasGameRef {
  final double speed = 200;
  SpriteSheet angryPig = SpriteSheet(
      image: Flame.images.fromCache('Angry Pig Run (36x30).png'),
      srcSize: Vector2(36, 30));

  final Vector2 enemySize;
  final Vector2 enemyPosition;

  Enemy(this.enemySize, this.enemyPosition) {
    size = enemySize;
    position = enemyPosition;
  }

  @override
  Future<void>? onLoad() {
    animation = angryPig.createAnimation(row: 0, stepTime: 0.1);
    return super.onLoad();
  }

  @override
  void update(double dt) {
    x -= speed * dt;
    if (x <= 0) {
      gameRef.remove(this);
    }
    super.update(dt);
  }

  @override
  void onGameResize(Vector2 size) {
    x = size.x - enemySize.x;
    super.onGameResize(size);
  }
}
