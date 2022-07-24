import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';

class DinoGame extends FlameGame {
  @override
  Future<void>? onLoad() async {
    await Flame.images
        .loadAll(['DinoSprites_tard.gif', 'DinoSprites - tard.png']);
    var dinoSprite = SpriteComponent(
        sprite: Sprite(Flame.images.fromCache('DinoSprites_tard.gif'),
            srcSize: Vector2.all(64)),
        size: Vector2.all(150),
        position: Vector2(size.toOffset().dx / 2, size.toOffset().dy / 2));
    add(dinoSprite);
    return super.onLoad();
  }
}
