import 'package:doodle_dash/game/platform_manager.dart';
import 'package:doodle_dash/game/world.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';

class DoodleDash extends FlameGame
    with HasKeyboardHandlerComponents, HasCollisionDetection {
  final World _world = World();
  final PlatformManager platfrormManager = PlatformManager(
    maxVerticalDistanceToNextPlatform: 350
  );

  @override
  Future<void> onLoad() async {
    await add(_world);
  }
}
