import 'package:angry_bird/characters/player.dart';
import 'package:angry_bird/components/ground.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame_audio/audio_pool.dart';
import 'package:flame_forge2d/body_component.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:forge2d/src/dynamics/body.dart';

class Enemy extends BodyComponent with ContactCallbacks {
  final Vector2 position;
  late AudioPool destroyedSfx;
  Sprite enemySprite = Sprite(Flame.images.fromCache('pig.webp'));
  Sprite cloudSprite = Sprite(Flame.images.fromCache('cloud.webp'));
  Enemy(this.position);

  @override
  Future<void> onLoad() async {
    // TODO: implement onLoad
    destroyedSfx =
        await AudioPool.create('audio/sfx/destroyed.mp3', maxPlayers: 1);
    return super.onLoad();
  }

  @override
  Body createBody() {
    // TODO: implement createBody
    Shape circle = CircleShape()..radius = 3;
    var sprite = SpriteComponent(
        sprite: enemySprite, size: Vector2.all(6), anchor: Anchor.center);
    add(sprite);
    FixtureDef fixtureDef = FixtureDef(circle, friction: 0.3);
    BodyDef enemy = BodyDef(
      userData: this,
      type: BodyType.dynamic,
      position: position,
    );
    renderBody = false;
    return world.createBody(enemy)..createFixture(fixtureDef);
  }

  @override
  void beginContact(Object other, Contact contact) {
    // TODO: implement beginContact
    super.beginContact(other, contact);
    if (other is Player || other is Ground) {
      destroyedSfx.start(volume: 2);
      var sprite = SpriteComponent(
          sprite: cloudSprite, size: Vector2.all(6), anchor: Anchor.center);
      add(sprite);
      Future.delayed(Duration(milliseconds: 1100), () {
        removeFromParent();
      });
    }
  }
}
