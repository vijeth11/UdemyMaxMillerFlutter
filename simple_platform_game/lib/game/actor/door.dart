import 'dart:ui';

import 'package:flame/components.dart';

class Door extends SpriteComponent{
   Door(
    Image image, {
    Paint? paint,
    Vector2? position,
    Vector2? size,
    Vector2? scale,
    double? angle,
    Anchor? anchor,
    int? priority,
  }) : super.fromImage(image,
            srcPosition: Vector2(2*32,0),
            srcSize: Vector2.all(32),
            position: position,
            paint: paint,
            size: size,
            scale: scale,
            angle: angle,
            anchor: anchor,
            priority: priority);
}