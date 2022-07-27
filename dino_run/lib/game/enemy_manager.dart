import 'dart:math';

import '../screens/dino_game.dart';
import './enemy.dart';
import 'package:flame/components.dart';

class EnemyManager extends Component with HasGameRef<DinoGame> {
  late Random _random;
  late Timer _timer;
  late int spawnLevel;
  EnemyManager() {
    _random = Random();
    spawnLevel = 0;
    _timer = Timer(4, repeat: true, autoStart: false, onTick: () {
      spawnRandomEnemy();
    });
  }

  void spawnRandomEnemy() {
    final randomNumber = _random.nextInt(EnemyType.values.length);
    final randomEnemyType = EnemyType.values[randomNumber];
    final newEnemy = Enemy(randomEnemyType);
    gameRef.add(newEnemy);
  }

  @override
  void onMount() {
    _timer.start();
    super.onMount();
  }

  @override
  void update(double dt) {
    _timer.update(dt);
    int newSpawnLevel = (gameRef.score.value ~/ 500);
    if (spawnLevel < newSpawnLevel) {
      spawnLevel = newSpawnLevel;
      _timer.stop();
      var newWaitTime = (4 / (1 + (0.1 * spawnLevel)));
      _timer = Timer(newWaitTime, repeat: true, autoStart: false, onTick: () {
        spawnRandomEnemy();
      });
      _timer.start();
    }
    super.update(dt);
  }

  void reset() {
    _timer.stop();
    spawnLevel = 0;
    gameRef.removeAll(gameRef.children.where((element) => element is Enemy));
    _timer = Timer(4, repeat: true, autoStart: false, onTick: () {
      spawnRandomEnemy();
    });
    _timer.start();
  }
}
