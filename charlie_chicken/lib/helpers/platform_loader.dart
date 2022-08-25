import 'package:charlie_chicken/actors/checkpoint.dart';
import 'package:charlie_chicken/actors/level.dart';
import 'package:charlie_chicken/actors/platform.dart';
import 'package:flame/components.dart';
import 'package:tiled/tiled.dart';

void PlatformLoader(Level game, ObjectGroup platFormObj) {
  for (TiledObject platObj in platFormObj.objects) {
    if (platObj.class_.isNotEmpty && platObj.class_ == "CheckPoint") {
      print("added check point");
      game.add(CheckPoint(        
        size: Vector2(80, 120),
        position: Vector2(platObj.x, platObj.y),
      )
      .. anchor= Anchor.bottomCenter
        ..flipHorizontallyAroundCenter());
    } else {
      game.add(Platform(
          size: Vector2(platObj.width, platObj.height),
          position: Vector2(platObj.x, platObj.y),
          isEndBox: platObj.class_.isNotEmpty && platObj.class_ == "EndPoint",
          isBottomGround:
              platObj.class_.isNotEmpty && platObj.class_ == "BottomGround"));
    }
  }
}
