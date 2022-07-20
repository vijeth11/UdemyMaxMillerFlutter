import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:pokemon/helper/direction.dart';

const double SPEED = 120;
const double COMPONENT_SIZE = 50;

class Player extends SpriteComponent with HasGameRef {
  Direction direction = Direction.none;
  late double maxY, minY;
  late double maxX, minX;
  Player() : super(size: Vector2.all(COMPONENT_SIZE));
  @override
  Future<void>? onLoad() {
    // TODO: implement onLoad
    sprite = Sprite(Flame.images.fromCache('player.png'));
    position = gameRef.size / 2;
    maxY = gameRef.canvasSize.toRect().height - COMPONENT_SIZE;
    maxX = gameRef.canvasSize.toRect().width - COMPONENT_SIZE;
    minX = 0.0;
    minY = 0.0;
  }

  @override
  void update(double dt) {
    movePlayer(dt);
    super.update(dt);
  }

  void movePlayer(double dt) {
    if (direction == Direction.up) {
      y = max(minY, y - dt * SPEED);
    } else if (direction == Direction.right) {
      x = min(maxX, x + dt * SPEED);
    } else if (direction == Direction.down) {
      y = min(maxY, y + dt * SPEED);
    } else if (direction == Direction.left) {
      x = max(minX, x - dt * SPEED);
    }
  }

  @override
  void onGameResize(Vector2 size) {
    // TODO: implement onGameResize
    super.onGameResize(size);
  }
}
