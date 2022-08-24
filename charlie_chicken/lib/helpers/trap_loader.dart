import 'package:charlie_chicken/actors/trap.dart';
import 'package:charlie_chicken/game.dart';
import 'package:flame/components.dart';
import 'package:tiled/tiled.dart';

void TrapLoader(CharliChickenGame game, ObjectGroup trapObjs){
  for (TiledObject trapObj in trapObjs.objects) {
      if (trapObj.class_.isNotEmpty) {
        game.add(TrapComponent(
            srcSize: Vector2(double.parse(trapObj.properties[1].value),
                double.parse(trapObj.properties[0].value)),
            imageName: 'world/${trapObj.class_}.png',
            objPosition: Vector2(trapObj.x, trapObj.y),
            objSize: Vector2(trapObj.width, trapObj.height)));
      }
    }
}
