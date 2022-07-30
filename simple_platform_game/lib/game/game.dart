import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:simple_platform/game/actor/game_play.dart';
import 'package:simple_platform/model/player_data.dart';

class SimplePlatformer extends FlameGame
    with HasCollisionDetection, HasKeyboardHandlerComponents, HasTappables {
  final playerData = PlayerData();

  @override
  Future<void>? onLoad() async {
    await images.load('Spritesheet.png');
    camera.viewport = FixedResolutionViewport(Vector2(960, 340), clip: false);
    //add(GamePlay());
    return super.onLoad();
  }
}
