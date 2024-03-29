import 'package:charlie_chicken/actors/player.dart';
import 'package:charlie_chicken/game.dart';
import 'package:charlie_chicken/helpers/platform_loader.dart';
import 'package:charlie_chicken/helpers/reward_loader.dart';
import 'package:charlie_chicken/helpers/trap_loader.dart';
import 'package:charlie_chicken/overlays/game_over.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/audio_pool.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/cupertino.dart';
import 'package:tiled/tiled.dart';

class Level extends Component with HasGameRef<CharliChickenGame> {
  final Vector2 playerInitialPosition = Vector2(100, 300);
  final Player chicken = Player();
  late TiledComponent homeMap;
  late double mapViewHeight, mapViewWidth;
  late AudioPool jumpGame;
  late AudioPool gameLoose;

  bool displaFlagOver = false;
  ValueNotifier<bool> gameOverFlag = ValueNotifier(false);
  @override
  Future<void>? onLoad() async {
    jumpGame =
        await AudioPool.create('audio/sfx/chickenjump.wav', maxPlayers: 1);
    gameLoose = await AudioPool.create('audio/sfx/gamelost.mp3', maxPlayers: 1);
    homeMap = await TiledComponent.load('level1.tmx', Vector2(16, 16));
    add(homeMap);
    // these calculations are based on ratio (refer leena project)
    mapViewHeight = homeMap.tileMap.map.height.toDouble() * 16;
    mapViewWidth = mapViewHeight * (gameRef.size.x / gameRef.size.y);
    gameRef.camera.viewport =
        FixedResolutionViewport(Vector2(mapViewWidth, mapViewHeight));
    var trapObjs = homeMap.tileMap.getLayer<ObjectGroup>('Traps');
    TrapLoader(this, trapObjs!);

    var rewardObjs = homeMap.tileMap.getLayer<ObjectGroup>('Rewards');
    RewardLoader(this, rewardObjs!);

    var platformObjs = homeMap.tileMap.getLayer<ObjectGroup>('Platform');
    PlatformLoader(this, platformObjs!);

    add(chicken..position = playerInitialPosition);
    chicken.flipHorizontally();

    gameRef.addControlls();
    return super.onLoad();
  }

  @override
  void update(double dt) {
    // TODO: implement update
    if (gameRef.joystick?.direction == JoystickDirection.idle) {
      chicken.setAnimation(PlayerAnimation.Idel);
    } else {
      chicken.setAnimation(PlayerAnimation.Running);
      if (gameRef.joystick?.direction == JoystickDirection.left ||
          gameRef.joystick?.direction == JoystickDirection.upLeft ||
          gameRef.joystick?.direction == JoystickDirection.downLeft) {
        if (!gameRef.chickenFacingLeft) {
          chicken.flipHorizontallyAroundCenter();
          gameRef.chickenFacingLeft = true;
        }
        chicken.position +=
            Vector2((gameRef.joystick?.delta.x ?? 0.0) * 2 * dt, 0);
      } else if (gameRef.joystick?.direction == JoystickDirection.right ||
          gameRef.joystick?.direction == JoystickDirection.downRight ||
          gameRef.joystick?.direction == JoystickDirection.upRight) {
        if (gameRef.chickenFacingLeft) {
          chicken.flipHorizontallyAroundCenter();
          gameRef.chickenFacingLeft = false;
        }
        chicken.position +=
            Vector2((gameRef.joystick?.delta.x ?? 0.0) * 2 * dt, 0);
      }
    }
    super.update(dt);
  }

  void playerJump() {
    if (chicken.isOnGround) {
      jumpGame.start(volume: 0.8);
      chicken.position += Vector2(0, -5);
      chicken.velocity = -gameRef.jumpSpeed;
      chicken.isOnGround = false;
    }
  }

  void resetPlayerPosition() {
    print("player restart");
    chicken.position = playerInitialPosition;
    chicken.isOnGround = false;
    chicken.velocity = 1;
    chicken.isPlayerHit = false;
    gameRef.lifeLeft -= 1;
    if (gameRef.lifeLeft == 0) {
      gameOver();
    }
  }

  void gameOver() {
    gameRef.gameOver = true;
    if (gameRef.lifeLeft <= 0 || displaFlagOver) {
      if (!displaFlagOver) {
        FlameAudio.bgm.stop();
        gameLoose.start(volume: 0.8);
      }
      gameRef.pauseEngine();
      gameRef.overlays.add(GameOver.name);
    } else {
      gameOverFlag.value = true;
    }
  }
}
