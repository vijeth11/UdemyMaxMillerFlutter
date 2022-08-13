import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame_forge2d/body_component.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:forge2d/src/dynamics/body.dart';

class Enemy extends BodyComponent {
  final Vector2 position;

  Enemy(this.position);
  @override
  Body createBody() {
    // TODO: implement createBody
    Shape circle = CircleShape()..radius = 2;
    var sprite = SpriteComponent(
        sprite: Sprite(Flame.images.fromCache('pig.webp')),
        size: Vector2.all(4),
        anchor: Anchor.center);
    add(sprite);
    FixtureDef fixtureDef = FixtureDef(circle, friction: 0.3);
    BodyDef enemy =
        BodyDef(userData: this, type: BodyType.dynamic, position: position);
    renderBody = false;
    return world.createBody(enemy)..createFixture(fixtureDef);
  }
}
