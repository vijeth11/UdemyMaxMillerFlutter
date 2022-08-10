import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:george_builder/character/obstacle_component.dart';
import 'package:tiled/tiled.dart';
import 'package:george_builder/my_george_game.dart';

loadObstacles(TiledComponent homeMap, MyGeorgeGame game) {
  var obstacles = homeMap.tileMap.getLayer<ObjectGroup>('Obstacles');
  for (TiledObject obstacle in obstacles?.objects ?? []) {
    final obstacleComponent = ObstacleComponent(
        position: Vector2(obstacle.x, obstacle.y),
        size: Vector2(obstacle.width, obstacle.height))
      ..debugMode = true;
    game.add(obstacleComponent);
  }
}
