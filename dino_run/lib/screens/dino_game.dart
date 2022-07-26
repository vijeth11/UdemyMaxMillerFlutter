import 'package:dino_run/helper/background.dart';
import 'package:dino_run/game/enemy_manager.dart';
import 'package:dino_run/game/player.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';

import '../helper/constants.dart';
import '../widgets/game_hud.dart';
import '../widgets/game_over.dart';
import '../widgets/pause_menu.dart';

class DinoGame extends FlameGame
    with MultiTouchTapDetector, HasCollisionDetection {
  @override
  // TODO: implement debugMode
  //bool get debugMode => true;
  late Player dino;
  late TextComponent _scoreText;
  int score = 0;
  double elapsedTime = 0;
  Background background = Background();
  double countter = 0;
  late EnemyManager _enemyManager;
  ValueNotifier<int> life = ValueNotifier(5);

  DinoGame() {
    var style = TextStyle(fontFamily: 'Audiowide', fontSize: 20);
    var render = TextPaint(style: style);
    _scoreText = TextComponent(text: score.toString(), textRenderer: render);
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
    overlays.add('pauseIcon');
    return super.onLoad();
  }

  @override
  void update(double dt) {
    elapsedTime += dt;
    if (elapsedTime > (1 / 60)) {
      elapsedTime = 0;
      score += 1;
      _scoreText.text = score.toString();
    }
    if (life.value <= 0) {
      displayGameOver();
    }
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

  @override
  void lifecycleStateChange(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.inactive:
        displayPauseMenu();
        break;
      case AppLifecycleState.detached:
        displayPauseMenu();
        break;
      case AppLifecycleState.paused:
        displayPauseMenu();
        break;
      case AppLifecycleState.resumed:
        break;
    }
  }

  displayPauseMenu() {
    if (overlays.isActive('pauseMenu')) {
      overlays.remove('pauseMenu');
    }
    overlays.add('pauseMenu');
    pauseEngine();
  }

  resumeGame() {
    if (overlays.isActive('pauseMenu')) {
      overlays.remove('pauseMenu');
    }
    resumeEngine();
  }

  restartGame() {
    if (overlays.isActive('gameOver')) {
      overlays.remove('gameOver');
    }
    score = 0;
    life.value = 5;
    _enemyManager.reset();
    dino.run();
    resumeEngine();
  }

  displayGameOver() {
    if (overlays.isActive('gameOver')) {
      overlays.remove('gameOver');
    }
    overlays.add('gameOver');
    pauseEngine();
  }
}

class GameAppScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var game = DinoGame();
    return Scaffold(
      body: Stack(
        children: [
          GameWidget(
            game: game,
            overlayBuilderMap: {
              'pauseMenu': (ctx, DinoGame gameInstance) =>
                  PauseMenu(gameInstance.resumeGame),
              'pauseIcon': (ctx, DinoGame gameInstance) =>
                  GameHud(gameInstance),
              'gameOver': (ctx, DinoGame gameInstance) => GameOver(gameInstance)
            },
          ),
        ],
      ),
    );
  }
}
