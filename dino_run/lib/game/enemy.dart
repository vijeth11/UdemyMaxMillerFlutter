import 'dart:math';

import 'package:dino_run/screens/dino_game.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';

import '../helper/constants.dart';

enum EnemyType { AngryPig, Bunny, Chicken, Bat, Rino }

class EnemyData {
  final String imageName;
  final double textureWidth;
  final double textureHeight;
  final double extraHeight;

  const EnemyData(this.imageName, this.textureWidth, this.textureHeight,
      {this.extraHeight = 0});
}

class Enemy extends SpriteAnimationComponent
    with HasGameRef<DinoGame>, CollisionCallbacks {
  final double speed = 150;
  static const Map<EnemyType, EnemyData> _enemyDetails = {
    EnemyType.AngryPig:
        EnemyData('Angry Pig Run (36x30).png', 36, 30, extraHeight: 5),
    EnemyType.Bat: EnemyData('Flying Bat (46x30).png', 46, 30, extraHeight: 30),
    EnemyType.Rino: EnemyData('Rino Run (52x34).png', 52, 34, extraHeight: 5),
    EnemyType.Chicken: EnemyData('Chicken (32x34).png', 32, 34, extraHeight: 5),
    EnemyType.Bunny: EnemyData('Bunny (34x44).png', 34, 44, extraHeight: 10)
  };
  late SpriteSheet _enemy;
  final EnemyType selectedType;
  bool isBat = false;
  Enemy(this.selectedType) {
    _enemy = SpriteSheet(
        image: Flame.images.fromCache(_enemyDetails[selectedType]!.imageName),
        srcSize: Vector2(_enemyDetails[selectedType]!.textureWidth,
            _enemyDetails[selectedType]!.textureHeight));
    anchor = Anchor.center;
    isBat = selectedType == EnemyType.Bat;
  }

  @override
  Future<void>? onLoad() {
    animation = _enemy.createAnimation(row: 0, stepTime: 0.1);
    y = gameRef.size.toOffset().dy -
        groundHeight -
        _enemyDetails[selectedType]!.textureHeight / 2 -
        (isBat && Random().nextBool()
            ? 0
            : _enemyDetails[selectedType]!.extraHeight);
    add(RectangleHitbox());
    return super.onLoad();
  }

  @override
  void update(double dt) {
    x -= speed * dt;
    if (x <= -width) {
      gameRef.remove(this);
      if (!gameRef.isHit) {
        gameRef.score.value += 1;
      }
      gameRef.isHit = false;
    }
    super.update(dt);
  }

  @override
  void onGameResize(Vector2 size) {
    double scaleFactor = (size.x / numberOfTiles) / playerSize;
    width = _enemyDetails[selectedType]!.textureWidth * scaleFactor;
    height = _enemyDetails[selectedType]!.textureHeight * scaleFactor;
    x = gameRef.size.x - _enemyDetails[selectedType]!.textureWidth;
    super.onGameResize(size);
  }
}
