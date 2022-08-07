import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/sprite.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/material.dart';
import 'package:george_builder/character/friend_component.dart';
import 'package:george_builder/character/george_component.dart';
import 'package:tiled/tiled.dart';
import 'package:george_builder/button_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.fullScreen();
  runApp(MaterialApp(
      home: Scaffold(
    body: GameWidget(
      game: MyGeorgeGame(),
      overlayBuilderMap: {
        'ButtonController': (context, MyGeorgeGame game) =>
            ButtonController(game),
      },
    ),
  )));
}

class MyGeorgeGame extends FlameGame with HasTappables, HasCollisionDetection {
  late SpriteAnimation downAnimation;
  late SpriteAnimation upAnimation;
  late SpriteAnimation idelAnimation;
  late SpriteAnimation leftAnimation;
  late SpriteAnimation rightAnimation;

  late GeorgeComponent george;
  double animationSpeed = 0.1;
  double characterSize = 100;
  double characterSpeed = 80;
  late String soundTrackName = "music.mp3";
  late double mapHeight, mapWidth;
  ValueNotifier<int> friendNumber = ValueNotifier<int>(0);

  int direction = 0;

  @override
  Future<void>? onLoad() async {
    await Flame.images.loadAll(['george2.png', 'background.png']);
    final homeMap = await TiledComponent.load('map.tmx', Vector2.all(32));
    add(homeMap);

    mapHeight = (homeMap.tileMap.map.height * homeMap.tileMap.map.tileHeight)
        .toDouble();
    mapWidth =
        (homeMap.tileMap.map.width * homeMap.tileMap.map.tileWidth).toDouble();

    final friendGroup = homeMap.tileMap.getLayer<ObjectGroup>('Friends');
    for (TiledObject friendBox in friendGroup?.objects ?? []) {
      final friend = FriendComponent()
        ..position = Vector2(friendBox.x, friendBox.y)
        ..width = friendBox.width
        ..height = friendBox.height
        ..debugMode = true;
      add(friend);
    }

    FlameAudio.bgm.initialize();
    FlameAudio.audioCache.load('music.mp3');
    overlays.add('ButtonController');
    final spriteSheet = SpriteSheet(
        image: images.fromCache('george2.png'), srcSize: Vector2.all(48));
    downAnimation = spriteSheet.createAnimation(
        row: 0, stepTime: animationSpeed, to: 4, loop: true);
    leftAnimation = spriteSheet.createAnimation(
        row: 1, stepTime: animationSpeed, to: 4, loop: true);
    upAnimation = spriteSheet.createAnimation(
        row: 2, stepTime: animationSpeed, to: 4, loop: true);
    rightAnimation = spriteSheet.createAnimation(
        row: 3, stepTime: animationSpeed, to: 4, loop: true);
    idelAnimation = spriteSheet.createAnimation(
        row: 0, stepTime: animationSpeed, to: 1, loop: true);

    george = GeorgeComponent()
      ..animation = idelAnimation
      ..position = Vector2(50, 200)
      ..debugMode = true
      ..size = Vector2.all(characterSize);
    add(george);
    camera.followComponent(george,
        worldBounds: Rect.fromLTRB(0, 0, mapWidth, mapHeight));
    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    // TODO: implement render
    super.render(canvas);
  }

  @override
  void update(double dt) {
    switch (direction) {
      case 0:
        george.animation = idelAnimation;
        break;
      case 1:
        george.animation = downAnimation;
        if (george.y < mapHeight - george.height) {
          george.y += dt * characterSpeed;
        }
        break;
      case 2:
        george.animation = leftAnimation;
        if (george.x > 0) {
          george.x -= dt * characterSpeed;
        }
        break;
      case 3:
        george.animation = upAnimation;
        if (george.y > 0) {
          george.y -= dt * characterSpeed;
        }
        break;
      case 4:
        george.animation = rightAnimation;
        if (george.x < mapWidth - george.width) {
          george.x += dt * characterSpeed;
        }
        break;
    }
    super.update(dt);
  }

  @override
  void onTapUp(int pointerId, TapUpInfo info) {
    direction++;
    if (direction > 4) {
      direction = 0;
    }
    super.onTapUp(pointerId, info);
  }
}




