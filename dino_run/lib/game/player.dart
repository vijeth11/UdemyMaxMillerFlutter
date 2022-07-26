import '../screens/dino_game.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';

class Player extends SpriteAnimationComponent
    with HasGameRef<DinoGame>, CollisionCallbacks {
  late SpriteAnimation idelAnimation;
  late SpriteAnimation runAnimation;
  late SpriteAnimation kickAnimation;
  late SpriteAnimation hitAnimation;
  late SpriteAnimation sprintAnimation;
  final Vector2 playerSize;
  final Vector2 playerPosition;
  double speedY = 0.0;
  double maxY = 0.0;
  double gravity = 1000;

  Player(this.playerSize, this.playerPosition) {
    size = playerSize;
    position = playerPosition;
    maxY = playerPosition.y;
    anchor = Anchor.center;
  }

  @override
  Future<void>? onLoad() {
    var dinoSpriteSheet = SpriteSheet(
        image: Flame.images.fromCache('DinoSprites - tard.png'),
        srcSize: Vector2.all(24));

    idelAnimation = dinoSpriteSheet.createAnimation(
        row: 0, stepTime: 0.1, from: 0, to: 4, loop: true);

    runAnimation = dinoSpriteSheet.createAnimation(
        row: 0, stepTime: 0.1, from: 4, to: 10, loop: true);

    kickAnimation = dinoSpriteSheet.createAnimation(
        row: 0, stepTime: 0.1, from: 11, to: 13);

    hitAnimation = dinoSpriteSheet.createAnimation(
        row: 0, stepTime: 0.1, from: 14, to: 16);

    sprintAnimation = dinoSpriteSheet.createAnimation(
        row: 0, stepTime: 0.1, from: 17, to: 23);

    animation = runAnimation;
    var paint = Paint()..color = Color.fromARGB(255, 195, 67, 235);
    var hitBox = PolygonHitbox.relative(
        [Vector2(0.3, -1), Vector2(-1, -1), Vector2(-1, 1), Vector2(0.3, 1)],
        parentSize: size)
      ..renderShape = false
      ..paint = paint;
    add(hitBox);
    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);
    // final velocity
    // v = u + at
    this.speedY += gravity * dt;

    // distance formula
    // d = s0 + vt
    this.y += this.speedY * dt;
    if (isOnGround()) {
      y = maxY;
      speedY = 0;
    }
  }

  bool isOnGround() {
    return y >= maxY;
  }

  jump() {
    if (isOnGround()) {
      speedY = -600;
    }
  }

  void hit() {
    animation = hitAnimation;
    gameRef.life.value -= 1;
  }

  void run() {
    animation = runAnimation;
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    hit();
    super.onCollisionStart(intersectionPoints, other);
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    run();
    super.onCollisionEnd(other);
  }
}
