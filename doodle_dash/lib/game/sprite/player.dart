import 'package:doodle_dash/game/doodle_dash.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Player extends SpriteComponent
    with HasGameRef<DoodleDash>, CollisionCallbacks {
  Player({super.position})
      : super(size: Vector2.all(100), anchor: Anchor.center, priority: 1);
  final Vector2 _velocity = Vector2.zero();
  
}
