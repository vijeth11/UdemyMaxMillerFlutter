import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class GeorgeComponent extends SpriteAnimationComponent with CollisionCallbacks {
  GeorgeComponent() {
    var hitBox = RectangleHitbox();
    add(hitBox);
  }
}