import 'package:doodle_dash/game/doodle_dash.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Platform extends SpriteComponent
    with CollisionCallbacks, HasGameRef<DoodleDash> {
  final hitbox = RectangleHitbox();

  Platform({super.position}) : super(size: Vector2.all(50), priority: 2);

  @override
  Future<void>? onLoad() async {
    // TODO: implement onLoad
    await super.onLoad();
    sprite = await gameRef.loadSprite('game/yellow_platform.png');

    // add collision detection logic
    await add(hitbox);
  }
}
