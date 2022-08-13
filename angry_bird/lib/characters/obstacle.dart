import 'package:angry_bird/characters/enemy.dart';
import 'package:angry_bird/characters/player.dart';
import 'package:angry_bird/components/ground.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/audio_pool.dart';
import 'package:flame_forge2d/body_component.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:forge2d/src/dynamics/body.dart';

class Obstacle extends BodyComponent with ContactCallbacks {
  final Vector2 position;
  final Sprite sprite;
  late AudioPool woodCollision;

  Obstacle(this.position, this.sprite);
  @override
  Future<void> onLoad() async {
    woodCollision =
        await AudioPool.create('audio/sfx/wood_collision.mp3', maxPlayers: 4);
    return super.onLoad();
  }

  @override
  Body createBody() {
    // TODO: implement createBody
    PolygonShape square = PolygonShape();
    var vertices = [
      Vector2(-3, 3),
      Vector2(3, -3),
      Vector2(3, 3),
      Vector2(-3, -3)
    ];
    square.set(vertices);
    FixtureDef fixtureDef = FixtureDef(square, friction: 0.3);
    var obstacle = SpriteComponent(
        sprite: sprite, anchor: Anchor.center, size: Vector2.all(6));
    add(obstacle);
    BodyDef bodyDef =
        BodyDef(userData: this, position: position, type: BodyType.dynamic);
    renderBody = false;
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

  @override
  void beginContact(Object other, Contact contact) {
    // TODO: implement beginContact

    if (other is Ground || other is Player || other is Enemy) {
      woodCollision.start(volume: 0.8);
    }
    super.beginContact(other, contact);
  }
}
