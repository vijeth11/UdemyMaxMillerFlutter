import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:simple_platform/game/game.dart';

class HUD extends Component with HasGameRef<SimplePlatformer> {
  HUD({super.children, super.priority}) {
    positionType = PositionType.viewport;
  }

  @override
  Future<void>? onLoad() {
    final scoreTextComponent = TextComponent<TextPaint>(
        text: 'Score :0',
        position: Vector2.all(10),
        textRenderer:
            TextPaint(style: TextStyle(color: Colors.white, fontSize: 25)));
    add(scoreTextComponent);

    final healthTextComponent = TextComponent<TextPaint>(
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

    gameRef.playerData.score.addListener(() {
      scoreTextComponent.text = "Score: ${gameRef.playerData.score.value}";
    });
    gameRef.playerData.health.addListener(() {
      healthTextComponent.text = "X${gameRef.playerData.health.value}";
    });
    return super.onLoad();
  }
}
