import 'package:doodle_dash/game/world.dart';
import 'package:flame/game.dart';

class DoodleDash extends FlameGame {
  final World _world = World();

  @override
  Future<void> onLoad() async {
    await add(_world);
  }
}
