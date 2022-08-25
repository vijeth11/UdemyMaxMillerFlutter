import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/cupertino.dart';
import 'package:simple_platform/game/utils/audio_manager.dart';
import 'package:simple_platform/model/player_data.dart';

class SimplePlatformer extends FlameGame
    with HasCollisionDetection, HasKeyboardHandlerComponents, HasTappables {
  final playerData = PlayerData();
  final isOverlayActive = ValueNotifier(true);

  @override
  Future<void>? onLoad() async {
    await images.load(
      'Spritesheet.png',
    );
    await AudioManager.init();
    camera.viewport = FixedResolutionViewport(Vector2(960, 340), clip: false);
    //game play is added in main_menu
    //add(GamePlay());
    return super.onLoad();
  }
}
