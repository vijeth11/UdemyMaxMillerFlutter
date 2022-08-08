import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/material.dart';
import 'package:george_builder/character/friend_component.dart';
import 'package:george_builder/character/george_component.dart';
import 'package:george_builder/loaders/add_baked_goods.dart';
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
  late GeorgeComponent george;
  double characterSize = 100;
  double characterSpeed = 80;
  late String soundTrackName = "music.mp3";
  late double mapHeight, mapWidth;
  ValueNotifier<int> friendNumber = ValueNotifier<int>(0);
  int bakedGroupInventory = 0;

  @override
  Future<void>? onLoad() async {
    await Flame.images.loadAll([
      'george2.png',
      'background.png',
      'ChocoCake.png',
      'Cookie.png',
      'CheeseCake.png',
      'ApplePie.png'
    ]);
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

    addBakedGoods(homeMap, this);
    FlameAudio.bgm.initialize();
    FlameAudio.audioCache.load('music.mp3');
    FlameAudio.bgm.play('music.mp3');
    overlays.add('ButtonController');

    george = GeorgeComponent()
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
  void onTapUp(int pointerId, TapUpInfo info) {
    george.direction++;
    if (george.direction > 4) {
      george.direction = 0;
    }
    super.onTapUp(pointerId, info);
  }
}
