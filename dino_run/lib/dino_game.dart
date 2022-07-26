import 'package:dino_run/widgets/background.dart';
import 'package:dino_run/widgets/enemy_manager.dart';
import 'package:dino_run/widgets/player.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';

import 'helper/constants.dart';

class DinoGame extends FlameGame with MultiTouchTapDetector, HasCollisionDetection {
  late Player dino;
  late TextComponent _scoreText;
  int score = 0;
  Background background = Background();
  double countter = 0;
  late EnemyManager _enemyManager;
  DinoGame() {
    _scoreText = TextComponent(text: score.toString());
  }

  @override
  Future<void>? onLoad() async {
    await Flame.images.loadAll([
      'DinoSprites_tard.gif',
      'DinoSprites - tard.png',
      'plx-1.png',
      'plx-2.png',
      'plx-3.png',
      'plx-4.png',
      'plx-5.png',
      'plx-6.png',
      'Angry Pig Run (36x30).png',
      'Bunny (34x44).png',
      'Chicken (32x34).png',
      'Flying Bat (46x30).png',
      'Rino Run (52x34).png'
    ]);

    add(background);

    dino = Player(
        Vector2.all(playerSize),
        Vector2(size.toOffset().dx / numberOfTiles,
            size.toOffset().dy - groundHeight - playerSize / 2 + 10));
    add(dino);
    add(_scoreText);
    _enemyManager = EnemyManager();
    add(_enemyManager);
    return super.onLoad();
  }

  @override
  void update(double dt) {
    score += (60 * dt).toInt();
    _scoreText.text = score.toString();
    super.update(dt);
  }

  @override
  void onGameResize(Vector2 canvasSize) {
    _scoreText.position = Vector2(canvasSize.toOffset().dx / 2, 0);
    super.onGameResize(canvasSize);
  }

  @override
  void onTapDown(int pointerId, TapDownInfo info) {
    dino.jump();
    super.onTapDown(pointerId, info);
  }
}
