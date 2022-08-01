import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import './consts.dart';

class Ball extends SpriteComponent {
  Ball()
      : super(
            sprite: Sprite(Flame.images.fromCache('ball.png'),
                srcSize: Vector2.all(ballDiameter),
                srcPosition: Vector2.zero()),
            size: Vector2.all(ballSize)) {}

  @override
  void onGameResize(Vector2 size) {
    x = 0;
    y = 0;
    super.onGameResize(size);
  }
}
