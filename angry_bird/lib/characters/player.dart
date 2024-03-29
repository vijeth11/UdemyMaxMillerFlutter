import 'package:angry_bird/main.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame_audio/audio_pool.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame_forge2d/body_component.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:forge2d/src/dynamics/body.dart';

class Player extends BodyComponent with Tappable {
  late AudioPool launchSfx;
  late AudioPool flyingSfx;

  @override
  Future<void> onLoad() async {
    launchSfx = await AudioPool.create('audio/sfx/launch.mp3', maxPlayers: 1);
    flyingSfx = await AudioPool.create('audio/sfx/flying.mp3', maxPlayers: 1);

    return super.onLoad();
  }

  @override
  Body createBody() {
    // TODO: implement createBody
    Shape shape = CircleShape()..radius = 3;
    var angryBird = SpriteComponent(
        sprite: Sprite(Flame.images.fromCache('red.webp')),
        size: Vector2.all(6),
        anchor: Anchor.center);
    add(angryBird);
    BodyDef bodyDef = BodyDef(userData:this, position: Vector2(14, 5), type: BodyType.dynamic);
    FixtureDef fixtureDef = FixtureDef(shape, friction: 0.3, density: 1);
    renderBody = false;
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

  @override
  bool onTapDown(TapDownInfo data) {
    (gameRef as AngryBird).stopBgm();
    launchSfx.start(volume: 0.8);
    Future.delayed(Duration(milliseconds: 500), () {
      flyingSfx.start(volume: 0.8);
    });
    body.applyLinearImpulse(Vector2(30, -22) * 30);
    return super.onTapDown(data);
  }
}
