import 'package:charlie_chicken/actors/level.dart';
import 'package:charlie_chicken/controlls/button.dart';
import 'package:charlie_chicken/overlays/game_over.dart';
import 'package:charlie_chicken/overlays/lives.dart';
import 'package:charlie_chicken/overlays/score.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart' hide ButtonComponent;
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

class CharliChickenGame extends FlameGame
    with HasDraggables, HasCollisionDetection, HasTappables {
  late JoystickComponent? joystick;
  late ButtonComponent? jumpButton;
  late SpriteButtonComponent? restartButton;
  late Score? scoreText;
  late LivesRemaining? livesText;
  late SpriteComponent? characterImage;
  late Level? gameLevel;

  bool chickenFacingLeft = false;
  final double gravity = 8.0;
  final double jumpSpeed = 320;

  int score = 0;
  int lifeLeft = 5;
  bool gameOver = false;

  @override
  Future<void>? onLoad() async {
    await Flame.images.loadAll([
      'ChickenRun.png',
      'world/FallingPlatformOff.png',
      'world/Apple.png',
      'world/AppleSheet.png',
      'world/Collected.png',
      'world/FallingPlatform.png',
      'world/Checkpoint.png',
      'world/CheckpointFlagOut.png',
      'ChickenIdel.png',
      'ChickenHit.png',
      'Chicken.png',
      'jump.png',
      'restart.png',
    ]);

    gameLevel = Level();
    add(gameLevel!);

    return super.onLoad();
  }

  void addControlls() {
    // called by level once view port is set
    final knobPaint = BasicPalette.blue.withAlpha(200).paint();
    final backgroundPaint = BasicPalette.blue.withAlpha(100).paint();
    joystick = JoystickComponent(
        knob: CircleComponent(radius: 30, paint: knobPaint),
        background: CircleComponent(radius: 60, paint: backgroundPaint),
        margin: const EdgeInsets.only(left: 40, bottom: 40));
    add(joystick!);

    jumpButton = ButtonComponent(
        color: knobPaint,
        position: Vector2(size.x - 150, size.y - 80),
        onButtonTap: onJumpButtonClick);
    add(jumpButton!);

    restartButton = SpriteButtonComponent(
        onPressed: restartGame,
        size: Vector2.all(50),
        position: Vector2(100, 30),
        button: Sprite(Flame.images.fromCache('restart.png')));

    add(restartButton!);

    scoreText = Score();

    add(scoreText!);

    characterImage = SpriteComponent(
        sprite: Sprite(Flame.images.fromCache('Chicken.png'),
            srcSize: Vector2(67, 65)),
        position: Vector2(size.x - 250, 30),
        size: Vector2.all(50));

    add(characterImage!);

    livesText = LivesRemaining();
    add(livesText!);
  }

  void onJumpButtonClick() {
    gameLevel?.playerJump();
  }

  void playerRestart() {
    gameLevel?.resetPlayerPosition();
  }

  void restartGame() {
    if (overlays.isActive(GameOver.name)) {
      overlays.remove(GameOver.name);
    }
    score = 0;
    lifeLeft = 5;
    gameOver = false;
    if (livesText != null) {
      remove(livesText!);
      livesText = null;
    }
    if (characterImage != null) {
      remove(characterImage!);
      characterImage = null;
    }

    if (scoreText != null) {
      remove(scoreText!);
      scoreText = null;
    }
    if (restartButton != null) {
      remove(restartButton!);
      restartButton = null;
    }
    if (joystick != null) {
      remove(joystick!);
      joystick = null;
    }
    if (jumpButton != null) {
      remove(jumpButton!);
      jumpButton = null;
    }
    if (gameLevel != null) {
      remove(gameLevel!);
      gameLevel = null;
    }

    Future.delayed(Duration(seconds: 1)).then((value) {
      gameLevel = Level();
      add(gameLevel!);
    });
  }
}
