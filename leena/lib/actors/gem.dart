import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame_audio/audio_pool.dart';
import 'package:leena/actors/leena.dart';
import 'package:leena/main.dart';
import 'package:tiled/tiled.dart';

class Gem extends SpriteComponent
    with CollisionCallbacks, HasGameRef<LeenaGame> {
  final TiledObject gem;
  final AudioPool music;

  Gem(this.gem, this.music);
  @override
  Future<void>? onLoad() async {
    sprite = Sprite(await Flame.images.load('gems/${gem.class_}.png'),
        srcSize: Vector2.all(32));
    position = Vector2(gem.x, gem.y);
    size = Vector2.all(32);
    anchor = Anchor.bottomRight;
    debugMode = true;
    add(RectangleHitbox());
    return super.onLoad();
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Leena) {
      music.start(volume: 0.8);
      gameRef.magicLevel.value++;
      removeFromParent();
    }
    super.onCollision(intersectionPoints, other);
  }
}
