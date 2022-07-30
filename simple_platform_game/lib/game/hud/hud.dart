import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:simple_platform/game/game.dart';
import 'package:simple_platform/game/overlays/pause_menu.dart';

class HUD extends Component with HasGameRef<SimplePlatformer> {
  late final TextComponent scoreTextComponent, healthTextComponent;

  HUD({super.children, super.priority}) {
    positionType = PositionType.viewport;
  }

  @override
  Future<void>? onLoad() {
    scoreTextComponent = TextComponent<TextPaint>(
        text: 'Score :0',
        position: Vector2.all(10),
        textRenderer:
            TextPaint(style: TextStyle(color: Colors.white, fontSize: 25)));
    add(scoreTextComponent);

    healthTextComponent = TextComponent<TextPaint>(
        text: 'X5',
        anchor: Anchor.topRight,
        position: Vector2(gameRef.size.x - 10, 0),
        textRenderer:
            TextPaint(style: TextStyle(color: Colors.white, fontSize: 30)));
    add(healthTextComponent);

    final playerSprite = SpriteComponent(
      sprite: Sprite(
        Flame.images.fromCache('Spritesheet.png'),
        srcPosition: Vector2.zero(),
        srcSize: Vector2.all(32),
      ),
      anchor: Anchor.topRight,
      position: Vector2(gameRef.size.x - 15 - 32, 0),
    );
    add(playerSprite);

    gameRef.playerData.score.addListener(onScoreChange);
    gameRef.playerData.health.addListener(onhealthChange);

    final pauseButton = SpriteButtonComponent(
        onPressed: () {
          gameRef.pauseEngine();
          gameRef.overlays.add(PauseMenu.id);
        },
        button: Sprite(Flame.images.fromCache('Spritesheet.png'),
            srcPosition: Vector2(4 * 32, 0), srcSize: Vector2.all(32)),
        size: Vector2.all(32),
        anchor: Anchor.topCenter,
        position: Vector2(gameRef.size.x / 2, 0));
    add(pauseButton);
    return super.onLoad();
  }

  void onScoreChange() {
    scoreTextComponent.text = "Score: ${gameRef.playerData.score.value}";
  }

  void onhealthChange() {
    healthTextComponent.text = "X${gameRef.playerData.health.value}";
  }

  @override
  void onRemove() {
    gameRef.playerData.score.removeListener(onScoreChange);
    gameRef.playerData.health.removeListener(onhealthChange);
    super.onRemove();
  }
}
