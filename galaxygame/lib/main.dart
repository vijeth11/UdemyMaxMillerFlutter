import 'dart:math' as Math;

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/sprite.dart';
import 'package:galaxygame/bullet_component.dart';
import 'package:galaxygame/villan_component.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
          body: GameWidget(
        game: MyGame(),
        overlayBuilderMap: {
          'PauseMessage': (ctx, MyGame game) => Container(
              width: double.infinity,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Game Over',
                      style: TextStyle(fontSize: 48, color: Colors.white),
                    ),
                    TextButton(
                      child: const Text("Restart"),
                      onPressed: () => game.resetGame(),
                    )
                  ],
                ),
              ))
        },
      )),
    ),
  );
}

class MyGame extends FlameGame
    with MultiTouchTapDetector, HasCollisionDetection {
  @override
  // TODO: implement debugMode
  bool get debugMode => false;
  bool gamePaused = false;
  double creationTimer = 0.0;
  VillanComponent? component = null;
  BulletComponent? component1 = null;
  int score = 0;

  var dimentions;
  @override
  Future<void> onLoad() async {
    await Flame.images.loadAll([
      'fire.png',
      'dragon.png',
      'gun.png',
      'bullet.png',
      'background.jpg',
      'explosionSpriteSheet.png'
    ]);
    FlameAudio.bgm.initialize();
    FlameAudio.bgm.load('music.ogg');
    FlameAudio.bgm.play('music.ogg');
    var background =
        SpriteComponent(sprite: Sprite(images.fromCache('background.jpg')));
    add(background);
    add(ScreenHitbox());
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    String text = "Score: $score";
    TextPainter textPainter = TextPainter(
        text: TextSpan(
            text: text, style: TextStyle(color: Colors.white, fontSize: 48.0)),
        textDirection: TextDirection.ltr);
    textPainter.layout();
    textPainter.paint(
        canvas, Offset(size.toRect().width / 4.0, size.toRect().height - 50));
  }

  @override
  void update(double dt) {
    creationTimer += dt;
    if (creationTimer >= 1.5 && !gamePaused) {
      int characterCount = Math.Random().nextInt(4) + 1;
      creationTimer = 0.0;
      List<double> previousPosition = [];
      for (int i = 0; i < characterCount; i++) {
        var position = (Math.Random().nextDouble() * size.toRect().width) - 40;
        bool isOverlapping = previousPosition.any((element) =>
            element + 20 >= position - 20 && element - 20 <= position + 20);
        if (isOverlapping) {
          i--;
          continue;
        }
        previousPosition.add(position);
        component = new VillanComponent(position);
        add(component!);
      }
    } else if (gamePaused) {
      if (children.query().length == 2) {
        pauseEngine();
      }
    }
    super.update(dt);
  }

  @override
  void onTapDown(int pointerId, TapDownInfo info) {
    // TODO: implement onTapDown
    component1 = BulletComponent(info.eventPosition.game);
    add(component1!);
  }

  displayGameOver() {
    gamePaused = true;
    if (!overlays.isActive('PauseMessage')) {
      overlays.add('PauseMessage');
      children.query().forEach((element) {
        if (element is VillanComponent || element is BulletComponent) {
          remove(element);
        }
      });
    }
  }

  resetGame() {
    gamePaused = false;
    score = 0;
    if (overlays.isActive('PauseMessage')) {
      overlays.remove('PauseMessage');
      resumeEngine();
    }
  }

  addExplosionSprite(Vector2 position) {
    final spriteSize = Vector2.all(40);
    SpriteAnimationData spriteData = SpriteAnimationData.sequenced(
        amount: 7, stepTime: 0.3, textureSize: Vector2(33, 33), loop: false);
    var explosionAnimation = SpriteAnimationComponent.fromFrameData(
        images.fromCache('explosionSpriteSheet.png'), spriteData)
      ..x = position.toPoint().x.toDouble()
      ..y = position.toPoint().y.toDouble()
      ..size = spriteSize
      ..removeOnFinish = true;
    add(explosionAnimation);
  }
}
