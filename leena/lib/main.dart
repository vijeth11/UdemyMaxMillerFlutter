import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/material.dart';
import 'package:leena/actors/leena.dart';
import 'package:leena/world/ground.dart';
import 'package:tiled/tiled.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();
  await Flame.device.setLandscape();
  runApp(GameWidget(game: LeenaGame()));
}

class LeenaGame extends FlameGame with HasCollisionDetection, TapDetector {
  Leena leena = Leena();
  double gravity = 1.8;
  Vector2 velocity = Vector2(0, 0);
  late TiledComponent homeMap;

  @override
  Future<void>? onLoad() async {
    await Flame.images.load('girl.png');
    homeMap = await TiledComponent.load('map.tmx', Vector2.all(32));
    double mapWidth = homeMap.tileMap.map.width.toDouble() * 32;
    double mapHeight = homeMap.tileMap.map.height.toDouble() * 32;
    double viewportWidth = mapWidth;
    double viewportHeight = mapWidth * (size.y / size.x);
    // to get the below screen resolution match it with ratio of the screen
    // for ex: current screen size is 801 / 392 which is almost 2:1
    camera.viewport = FixedResolutionViewport(Vector2(mapWidth, mapHeight));
    add(homeMap);
    final ObstacleGroup = homeMap.tileMap.getLayer<ObjectGroup>('ground');

    for (var obj in ObstacleGroup!.objects) {
      add(Ground(
          size: Vector2(obj.width, obj.width),
          position: Vector2(obj.x, obj.y)));
    }

    leena
      ..sprite = Sprite(Flame.images.fromCache('girl.png'))
      ..size = Vector2(170, 220)
      ..position = Vector2(200, 30);
    add(leena);
    return super.onLoad();
  }

  @override
  void onTapDown(TapDownInfo info) {
    if (info.eventPosition.game.x < 100) {
      print('left tap down');
    } else if (info.eventPosition.game.x > size.x - 100) {
      print('right tap down');
    }
    super.onTapDown(info);
  }
}
