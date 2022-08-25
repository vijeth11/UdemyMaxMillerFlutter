import 'package:charlie_chicken/actors/platform.dart';
import 'package:charlie_chicken/game.dart';
import 'package:flame/components.dart';
import 'package:tiled/tiled.dart';

void PlatformLoader(CharliChickenGame game, ObjectGroup platFormObj) {
  for (TiledObject platObj in platFormObj.objects) {
    game.add(Platform(
        size: Vector2(platObj.width, platObj.height),
        position: Vector2(platObj.x, platObj.y),
        isEndBox: platObj.class_.isNotEmpty && platObj.class_ == "EndPoint",
        isBottomGround:
            platObj.class_.isNotEmpty && platObj.class_ == "BottomGround"));
  }
}
