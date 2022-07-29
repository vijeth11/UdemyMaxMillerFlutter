import 'dart:math';

import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:simple_platform/game/hud/hud.dart';
import 'package:simple_platform/model/player_data.dart';

import 'level/level.dart';

class SimplePlatformer extends FlameGame
    with HasCollisionDetection, HasKeyboardHandlerComponents {
  final playerData = PlayerData();
  Level? _currentLevel;

  @override
  Future<void>? onLoad() async {
    await images.load('Spritesheet.png');
    camera.viewport = FixedResolutionViewport(Vector2(960, 340), clip: false);
    loadLevel('level2.tmx');
    // this is to solve the fading of HUD on load of another level
    // lower the priority earlier it will be rendered by default all component has priority as 0
    // ref https://www.youtube.com/watch?v=WjzvWa6b5SI&list=PLiZZKL9HLmWPyd808sda2ydG-dhexNONV&index=11
    add(HUD(priority: 1));
    return super.onLoad();
  }

  void loadLevel(String levelName) {
    _currentLevel?.removeFromParent();
    _currentLevel = Level(levelName);
    add(_currentLevel!);
  }
}
