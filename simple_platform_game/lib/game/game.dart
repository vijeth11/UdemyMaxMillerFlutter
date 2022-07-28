import 'dart:math';

import 'package:flame/game.dart';

import 'level/level.dart';

class SimplePlatformer extends FlameGame with HasCollisionDetection{
  Level? _currentLevel;

  @override
  Future<void>? onLoad() async {
    await images.load('Spritesheet.png');
    camera.viewport = FixedResolutionViewport(Vector2(960, 340), clip: false);
    loadLevel('level2.tmx');

    return super.onLoad();
  }

  void loadLevel(String levelName) {
    _currentLevel?.removeFromParent();
    _currentLevel = Level(levelName);
    add(_currentLevel!);
  }
}
