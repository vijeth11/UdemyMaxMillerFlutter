import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import './consts.dart';

class Pad extends SpriteComponent {
  final Vector2 location;
  Pad(this.location)
      : super(
            sprite: Sprite(Flame.images.fromCache('pad.png'),
                srcSize: Vector2(padWidth, padheight))) {}

  @override
  void onGameResize(Vector2 size) {
    x = location.x;
    y = location.y;
    super.onGameResize(size);
  }
}
