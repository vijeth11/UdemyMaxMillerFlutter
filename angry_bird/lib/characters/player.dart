import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame_forge2d/body_component.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:forge2d/src/dynamics/body.dart';

class Player extends BodyComponent with Tappable {
  @override
  Body createBody() {
    // TODO: implement createBody
    Shape shape = CircleShape()..radius = 2;
    var angryBird = SpriteComponent(
        sprite: Sprite(Flame.images.fromCache('red.webp')),
        size: Vector2.all(4),
        anchor: Anchor.center);
    add(angryBird);
    BodyDef bodyDef = BodyDef(position: Vector2(10, 5), type: BodyType.dynamic);
    FixtureDef fixtureDef = FixtureDef(shape, friction: 0.3, density: 1);
    renderBody = false;
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

  @override
  bool onTapUp(TapUpInfo data) {
    body.applyLinearImpulse(Vector2(20, -18) * 10);
    return super.onTapUp(data);
  }
}
