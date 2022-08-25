import 'package:charlie_chicken/actors/level.dart';
import 'package:charlie_chicken/game.dart';
import 'package:flame/components.dart';
import 'package:tiled/tiled.dart';

import '../actors/reward.dart';

void RewardLoader(Level game, ObjectGroup rewardObjs){
  for (TiledObject rewardObj in rewardObjs.objects) {
      if (rewardObj.class_.isNotEmpty) {
        game.add(RewardComponent(
            srcSize: Vector2(double.parse(rewardObj.properties[1].value),
                double.parse(rewardObj.properties[0].value)),
            imageName: 'world/${rewardObj.class_}.png',
            objPosition: Vector2(rewardObj.x, rewardObj.y),
            objSize: Vector2(rewardObj.width, rewardObj.height)));
      }
    }
}