import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/audio_pool.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/material.dart';
import 'package:george_builder/character/george_component.dart';
import 'package:george_builder/dialog/dialog_box.dart';
import 'package:george_builder/loaders/add_baked_goods.dart';
import 'package:george_builder/loaders/load_friends.dart';
import 'package:george_builder/loaders/load_obstacles.dart';

class MyGeorgeGame extends FlameGame with HasTappables, HasCollisionDetection {
  late GeorgeComponent george;
  double characterSize = 67;
  double characterSpeed = 80;
  late String soundTrackName = "music.mp3";
  late double mapHeight, mapWidth;
  ValueNotifier<int> friendNumber = ValueNotifier<int>(0);
  ValueNotifier<int> bakedGroupInventory = ValueNotifier<int>(0);

  late AudioPool yummy;
  late AudioPool applause;
  late DialogBox dialogBox;

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

    loadFriends(homeMap, this);
    addBakedGoods(homeMap, this);
    loadObstacles(homeMap, this);
    yummy = await AudioPool.create('audio/sfx/yummy.mp3', maxPlayers: 3);
    applause = await AudioPool.create('audio/sfx/applause.mp3', maxPlayers: 3);

    FlameAudio.bgm.initialize();
    FlameAudio.audioCache.load('music.mp3');
    FlameAudio.bgm.play('music.mp3');
    overlays.add('ButtonController');

    george = GeorgeComponent()
      ..position = Vector2(529, 128)
      ..debugMode = true
      ..size = Vector2.all(characterSize);
    add(george);
    camera.followComponent(george,
        worldBounds: Rect.fromLTRB(0, 0, mapWidth, mapHeight));

    dialogBox = DialogBox(
        text: 'Hi.  I am George. I have just'
            'moved to Happy Bay Village'
            'I want to make friends.',
        game: this);
    add(dialogBox);
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

  void addDialog(String text) {
    dialogBox = DialogBox(text: text, game: this);
    add(dialogBox);
  }
}
