import 'dart:ffi';

import 'package:charlie_chicken/reward.dart';
import 'package:charlie_chicken/trap.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/material.dart';
import 'package:tiled/tiled.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();
  await Flame.device.setLandscape();
  runApp(MyHome());
}

class MyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        body: GameWidget(game: CharliChickenGame()),
      ),
    );
  }
}

class CharliChickenGame extends FlameGame with HasDraggables {
  late SpriteAnimationComponent chicken;
  late final JoystickComponent joystick;
  late TiledComponent homeMap;
  late double mapViewHeight, mapViewWidth;
  bool chickenFacingLeft = true;

  @override
  Future<void>? onLoad() async {
    homeMap = await TiledComponent.load('map.tmx', Vector2(16, 16));
    add(homeMap);
    mapViewHeight = homeMap.tileMap.map.height.toDouble() * 16;
    mapViewWidth = mapViewHeight * (size.x / size.y);
    camera.viewport =
        FixedResolutionViewport(Vector2(mapViewWidth, mapViewHeight));
    await Flame.images.loadAll(
        ['ChickenRun.png', 'world/FallingPlatformOff.png', 'world/Apple.png']);
    var runAnimation = SpriteAnimation.fromFrameData(
        Flame.images.fromCache('ChickenRun.png'),
        SpriteAnimationData.sequenced(
            amount: 14, stepTime: 0.1, textureSize: Vector2(32, 34)));
    chicken = SpriteAnimationComponent(animation: runAnimation)
      ..size = Vector2.all(80)
      ..position = Vector2(100, 200);
    add(chicken);
    var trapObjs = homeMap.tileMap.getLayer<ObjectGroup>('Traps');
    for (TiledObject trapObj in trapObjs!.objects) {
      if (trapObj.class_.isNotEmpty) {
        add(TrapComponent(
            srcSize: Vector2(double.parse(trapObj.properties[1].value),
                double.parse(trapObj.properties[0].value)),
            imageName: 'world/${trapObj.class_}.png',
            objPosition: Vector2(trapObj.x, trapObj.y),
            objSize: Vector2(trapObj.width, trapObj.height)));
      }
    }
    var rewardObjs = homeMap.tileMap.getLayer<ObjectGroup>('Rewards');
    for (TiledObject rewardObj in rewardObjs!.objects) {
      if (rewardObj.class_.isNotEmpty) {
        add(RewardComponent(
            srcSize: Vector2(double.parse(rewardObj.properties[1].value),
                double.parse(rewardObj.properties[0].value)),
            imageName: 'world/${rewardObj.class_}.png',
            objPosition: Vector2(rewardObj.x, rewardObj.y),
            objSize: Vector2(rewardObj.width, rewardObj.height)));
      }
    }
    final knobPaint = BasicPalette.blue.withAlpha(200).paint();
    final backgroundPaint = BasicPalette.blue.withAlpha(100).paint();
    joystick = JoystickComponent(
        knob: CircleComponent(radius: 30, paint: knobPaint),
        background: CircleComponent(radius: 60, paint: backgroundPaint),
        margin: const EdgeInsets.only(left: 40, bottom: 40));
    add(joystick);
    return super.onLoad();
  }

  @override
  void update(double dt) {
    // TODO: implement update
    chicken.position += joystick.delta * 2 * dt;
    if (!chickenFacingLeft &&
        (joystick.direction == JoystickDirection.left ||
            joystick.direction == JoystickDirection.upLeft ||
            joystick.direction == JoystickDirection.downLeft)) {
      chicken.flipHorizontallyAroundCenter();
      chickenFacingLeft = true;
    } else if (chickenFacingLeft &&
        (joystick.direction == JoystickDirection.right ||
            joystick.direction == JoystickDirection.downRight ||
            joystick.direction == JoystickDirection.upRight)) {
      chicken.flipHorizontallyAroundCenter();
      chickenFacingLeft = false;
    }
    print(joystick.direction);
    super.update(dt);
  }
}
