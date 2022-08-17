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
  final double gravity = 3.0;
  final double pushSpeed = 80;
  final double jumpForce = 80;
  final double groundFriction = 1.0;
  Vector2 velocity = Vector2(0, 0);
  late TiledComponent homeMap;
  late double mapWidth;
  late double mapHeight;

  @override
  Future<void>? onLoad() async {
    await Flame.images
        .loadAll(['girl.png', 'moving.png', 'onePush.png', 'jump.png']);
    homeMap = await TiledComponent.load('map.tmx', Vector2.all(32));
    mapWidth = homeMap.tileMap.map.width.toDouble() * 32;
    mapHeight = homeMap.tileMap.map.height.toDouble() * 32;
    double viewportWidth = (mapHeight * (size.x / size.y)).ceil().toDouble();
    double viewportHeight = mapHeight;
    print("$viewportWidth width $viewportHeight height ");
    // to get the below screen resolution match it with ratio of the screen
    // for ex: current screen size is 801 / 392 which is almost 2:1
    //camera.viewport = FixedResolutionViewport(Vector2(mapWidth, mapHeight));
    camera.viewport =
        FixedResolutionViewport(Vector2(viewportWidth, viewportHeight));
    add(homeMap);
    final ObstacleGroup = homeMap.tileMap.getLayer<ObjectGroup>('ground');

    for (var obj in ObstacleGroup!.objects) {
      add(Ground(
          size: Vector2(obj.width, obj.height),
          position: Vector2(obj.x, obj.y)));
    }

    leena
      ..size = Vector2(100, 129)
      ..position = Vector2(230, 30);
    add(leena);
    camera.followComponent(leena,
        worldBounds: Rect.fromLTRB(0, 0, mapWidth, mapHeight));
    return super.onLoad();
  }

  @override
  void onTapDown(TapDownInfo info) {
    if (leena.onGround) {
      if (info.eventPosition.viewport.x < 100) {
        print('left tap down');
        if (leena.facingRight) {
          leena.flipHorizontallyAroundCenter();
          leena.facingRight = false;
        }
        velocity.x =0;
        velocity.x -= pushSpeed;
        leena.onePush.reset();
        leena.animation = leena.onePush;
      } else if (info.eventPosition.viewport.x > size.x - 100) {
        print('right tap down');
        if (!leena.facingRight) {
          leena.flipHorizontallyAroundCenter();
          leena.facingRight = true;
        }
        velocity.x =0;
        velocity.x += pushSpeed;
        leena.onePush.reset();
        leena.animation = leena.onePush;
      }
      if (info.eventPosition.game.y < 100) {
        print('jump');
        leena.y -= 10;
        velocity.y = -jumpForce;
        leena.jump.reset();
        leena.animation = leena.jump;
      }
    }
    super.onTapDown(info);
  }
}
