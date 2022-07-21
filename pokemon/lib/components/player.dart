import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:pokemon/helper/direction.dart';

const double SPEED = 300;
const double COMPONENT_SIZE = 50;

class Player extends SpriteAnimationComponent with HasGameRef {
  final double _animationSpeed = 0.15;
  late final SpriteAnimation _runDownAnimation;
  late final SpriteAnimation _runLeftAnimation;
  late final SpriteAnimation _runUpAnimation;
  late final SpriteAnimation _runRightAnimation;
  late final SpriteAnimation _standingAnimation;
  Direction direction = Direction.none;
  late double maxY, minY;
  late double maxX, minX;
  Player() : super(size: Vector2.all(COMPONENT_SIZE));
  @override
  Future<void>? onLoad() {
    // TODO: implement onLoad
    //sprite = Sprite(Flame.images.fromCache('player.png'));
    _loadAnimation();
    animation = _standingAnimation;
    position = gameRef.size / 2;
  }

  void setMaxHeightAndWidth() {
    maxY = gameRef.camera.worldBounds!.height - COMPONENT_SIZE;
    maxX = gameRef.camera.worldBounds!.width - COMPONENT_SIZE;
    minX = 0.0;
    minY = 0.0;
  }

  void _loadAnimation() {
    final spriteSheet = SpriteSheet(
        image: Flame.images.fromCache('player_spritesheet.png'),
        srcSize: Vector2(29.0, 32.0));

    _runDownAnimation =
        spriteSheet.createAnimation(row: 0, stepTime: _animationSpeed, to: 4);
    _runLeftAnimation =
        spriteSheet.createAnimation(row: 1, stepTime: _animationSpeed, to: 4);
    _runUpAnimation =
        spriteSheet.createAnimation(row: 2, stepTime: _animationSpeed, to: 4);
    _runRightAnimation =
        spriteSheet.createAnimation(row: 3, stepTime: _animationSpeed, to: 4);
    _standingAnimation =
        spriteSheet.createAnimation(row: 0, stepTime: _animationSpeed, to: 1);
  }

  @override
  void update(double dt) {
    movePlayer(dt);
    super.update(dt);
  }

  void movePlayer(double dt) {
    if (direction == Direction.up) {
      animation = _runUpAnimation;
      y = max(minY, y - dt * SPEED);
    } else if (direction == Direction.right) {
      animation = _runRightAnimation;
      x = min(maxX, x + dt * SPEED);
    } else if (direction == Direction.down) {
      animation = _runDownAnimation;
      y = min(maxY, y + dt * SPEED);
    } else if (direction == Direction.left) {
      animation = _runLeftAnimation;
      x = max(minX, x - dt * SPEED);
    } else {
      animation = _standingAnimation;
    }
  }

  @override
  void onGameResize(Vector2 size) {
    // TODO: implement onGameResize
    super.onGameResize(size);
  }
}
