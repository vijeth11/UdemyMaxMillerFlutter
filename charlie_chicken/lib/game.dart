import 'package:charlie_chicken/actors/player.dart';
import 'package:charlie_chicken/controlls/button.dart';
import 'package:charlie_chicken/helpers/platform_loader.dart';
import 'package:charlie_chicken/helpers/reward_loader.dart';
import 'package:charlie_chicken/helpers/trap_loader.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/material.dart';
import 'package:tiled/tiled.dart';

class CharliChickenGame extends FlameGame
    with HasDraggables, HasCollisionDetection, HasTappables {
  final Player chicken = Player(Vector2(100, 300));
  late final JoystickComponent joystick;
  late ButtonComponent jumpButton;
  late TiledComponent homeMap;
  late double mapViewHeight, mapViewWidth;

  bool chickenFacingLeft = false;
  final double gravity = 8.0;
  final double jumpSpeed = 120;

  @override
  Future<void>? onLoad() async {
    homeMap = await TiledComponent.load('map.tmx', Vector2(16, 16));
    add(homeMap);
    // these calculations are based on ratio (refer leena project)
    mapViewHeight = homeMap.tileMap.map.height.toDouble() * 16;
    mapViewWidth = mapViewHeight * (size.x / size.y);
    camera.viewport =
        FixedResolutionViewport(Vector2(mapViewWidth, mapViewHeight));
    await Flame.images.loadAll([
      'ChickenRun.png',
      'world/FallingPlatformOff.png',
      'world/Apple.png',
      'world/AppleSheet.png',
      'world/Collected.png',
      'world/FallingPlatform.png',
      'ChickenIdel.png',
      'ChickenHit.png',
      'jump.png'
    ]);

    var trapObjs = homeMap.tileMap.getLayer<ObjectGroup>('Traps');
    TrapLoader(this, trapObjs!);

    var rewardObjs = homeMap.tileMap.getLayer<ObjectGroup>('Rewards');
    RewardLoader(this, rewardObjs!);

    var platformObjs = homeMap.tileMap.getLayer<ObjectGroup>('Platform');
    PlatformLoader(this, platformObjs!);

    add(chicken);
    chicken.flipHorizontally();

    final knobPaint = BasicPalette.blue.withAlpha(200).paint();
    final backgroundPaint = BasicPalette.blue.withAlpha(100).paint();
    joystick = JoystickComponent(
        knob: CircleComponent(radius: 30, paint: knobPaint),
        background: CircleComponent(radius: 60, paint: backgroundPaint),
        margin: const EdgeInsets.only(left: 40, bottom: 40));
    add(joystick);

    jumpButton = ButtonComponent(
        color: knobPaint,
        position: Vector2(size.x - 150, size.y - 80),
        onButtonTap: onJumpButtonClick);
    add(jumpButton);

    return super.onLoad();
  }

  @override
  void update(double dt) {
    // TODO: implement update
    if (joystick.direction == JoystickDirection.idle) {
      chicken.setAnimation(PlayerAnimation.Idel);
    } else {
      chicken.setAnimation(PlayerAnimation.Running);
      if (joystick.direction == JoystickDirection.left ||
          joystick.direction == JoystickDirection.upLeft ||
          joystick.direction == JoystickDirection.downLeft) {
        if (!chickenFacingLeft) {
          chicken.flipHorizontallyAroundCenter();
          chickenFacingLeft = true;
        }
        chicken.position += Vector2(joystick.delta.x * 2 * dt, 0);
      } else if (joystick.direction == JoystickDirection.right ||
          joystick.direction == JoystickDirection.downRight ||
          joystick.direction == JoystickDirection.upRight) {
        if (chickenFacingLeft) {
          chicken.flipHorizontallyAroundCenter();
          chickenFacingLeft = false;
        }
        chicken.position += Vector2(joystick.delta.x * 2 * dt, 0);
      }
    }
    super.update(dt);
  }

  void onJumpButtonClick() {
    chicken.position += Vector2(0, -5);
    chicken.velocity = -jumpSpeed;
    chicken.isOnGround = false;
  }
}
