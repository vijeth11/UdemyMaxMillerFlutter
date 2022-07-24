import 'package:flame/components.dart';
import 'package:flame/flame.dart';

class World extends SpriteComponent with HasGameRef {
  @override
  Future<void>? onLoad() {
    sprite = Sprite(Flame.images.fromCache('rayworld_background.png'));
    size = sprite!.originalSize;
    return super.onLoad();
  }
}
