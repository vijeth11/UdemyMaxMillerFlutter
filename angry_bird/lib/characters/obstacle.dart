import 'package:flame/components.dart';
import 'package:flame_forge2d/body_component.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:forge2d/src/dynamics/body.dart';

class Obstacle extends BodyComponent {
  final Vector2 position;
  final Sprite sprite;

  Obstacle(this.position, this.sprite);
  @override
  Body createBody() {
    // TODO: implement createBody
    PolygonShape square = PolygonShape();
    var vertices = [
      Vector2(-2, 2),
      Vector2(2, -2),
      Vector2(2, 2),
      Vector2(-2, -2)
    ];
    square.set(vertices);
    FixtureDef fixtureDef = FixtureDef(square, friction: 0.3);
    var obstacle = SpriteComponent(
        sprite: sprite, anchor: Anchor.center, size: Vector2.all(4));
    add(obstacle);
    BodyDef bodyDef =
        BodyDef(userData: this, position: position, type: BodyType.dynamic);
    renderBody = false;
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}
