import 'package:flame_forge2d/body_component.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:forge2d/src/dynamics/body.dart';

class Ground extends BodyComponent {
  final Vector2 gameSize;

  Ground(this.gameSize) : super();

  @override
  Body createBody() {
    // TODO: implement createBody
    print(gameSize);
    Shape ground = EdgeShape()
      ..set(Vector2(0, gameSize.y * 0.86),
          Vector2(gameSize.x, gameSize.y * 0.86));
    FixtureDef fixtureDef = FixtureDef(ground, friction: 0.3);
    BodyDef body = BodyDef(userData: this, position: Vector2.zero());
    renderBody =
        false; // this is to remove the shape outline and fill but other properties remains
    return world.createBody(body)..createFixture(fixtureDef);
  }
}
