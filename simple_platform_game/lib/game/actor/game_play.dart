import 'package:flame/components.dart';
import 'package:simple_platform/game/game.dart';
import 'package:simple_platform/game/hud/hud.dart';
import 'package:simple_platform/game/level/level.dart';
import 'package:simple_platform/game/utils/audio_manager.dart';

class GamePlay extends Component with HasGameRef<SimplePlatformer> {
  Level? _currentLevel;

  Level get currentLevel => _currentLevel!;
  @override
  Future<void>? onLoad() {
    loadLevel('level2.tmx');
    // this is to solve the fading of HUD on load of another level
    // lower the priority earlier it will be rendered by default all component has priority as 0
    // ref https://www.youtube.com/watch?v=WjzvWa6b5SI&list=PLiZZKL9HLmWPyd808sda2ydG-dhexNONV&index=11
    add(HUD(priority: 1));
    gameRef.playerData.score.value = 0;
    gameRef.playerData.health.value = 5;
    AudioManager.playBgm();
    return super.onLoad();
  }

  void loadLevel(String levelName) {
    _currentLevel?.removeFromParent();
    _currentLevel = Level(levelName);
    add(_currentLevel!);
  }
}
