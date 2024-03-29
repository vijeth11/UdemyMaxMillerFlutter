import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/audio_pool.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/material.dart';
import 'package:george_builder/character/george_component.dart';
import 'package:george_builder/dialog/dialog_box.dart';
import 'package:george_builder/helper/direction.dart';
import 'package:george_builder/loaders/add_baked_goods.dart';
import 'package:george_builder/loaders/load_friends.dart';
import 'package:george_builder/loaders/load_obstacles.dart';

class MyGeorgeGame extends FlameGame with HasCollisionDetection {
  late GeorgeComponent george;
  late String soundTrackName = "music.mp3";
  late double mapHeight, mapWidth;
  late TiledComponent homeMap;
  final List<String> maps = ['map.tmx', 'happy_map.tmx'];
  double characterSize = 67;
  double characterSpeed = 80;
  int maxFriends = 0;
  int sceneNumber = 1;

  ValueNotifier<int> friendNumber = ValueNotifier<int>(0);
  ValueNotifier<int> bakedGroupInventory = ValueNotifier<int>(0);
  ValueNotifier<String> displayMessage = ValueNotifier("");

  late AudioPool yummy;
  late AudioPool applause;
  //late DialogBox dialogBox;

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

    yummy = await AudioPool.create('audio/sfx/yummy.mp3', maxPlayers: 3);
    applause = await AudioPool.create('audio/sfx/applause.mp3', maxPlayers: 3);

    FlameAudio.bgm.initialize();
    FlameAudio.audioCache.load('music.mp3');
    FlameAudio.bgm.play('music.mp3');
    overlays.add('ButtonController');

    loadMap(maps[sceneNumber - 1]);

    // dialogBox = DialogBox(
    //     text: 'Hi.  I am George. I have just'
    //         'moved to Happy Bay Village'
    //         'I want to make friends.',
    //     game: this);
    // add(dialogBox);
    addDialog('Hi.  I am George. I have just'
        'moved to Happy Bay Village'
        'I want to make friends.');
    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    // TODO: implement render
    super.render(canvas);
  }

  // add HasTapables to the class eztending flamegame
  // @override
  // void onTapUp(int pointerId, TapUpInfo info) {
  //   george.direction++;
  //   if (george.direction > 4) {
  //     george.direction = 0;
  //   }
  //   super.onTapUp(pointerId, info);
  // }

  void changeGeorgeDirection(Direction direction) {
    switch (direction) {
      case Direction.none:
        george.direction = 0;
        break;
      case Direction.down:
        george.direction = 1;
        break;
      case Direction.left:
        george.direction = 2;
        break;
      case Direction.up:
        george.direction = 3;
        break;
      case Direction.right:
        george.direction = 4;
        break;
      default:
        george.direction = 0;
        break;
    }
  }

  void loadMap(String map) async {
    homeMap = await TiledComponent.load(map, Vector2.all(32));
    add(homeMap);

    mapHeight = (homeMap.tileMap.map.height * homeMap.tileMap.map.tileHeight)
        .toDouble();
    mapWidth =
        (homeMap.tileMap.map.width * homeMap.tileMap.map.tileWidth).toDouble();

    maxFriends = loadFriends(homeMap, this);
    addBakedGoods(homeMap, this);
    loadObstacles(homeMap, this);

    george = GeorgeComponent()
      ..position = Vector2(529, 128)
      ..debugMode = false
      ..size = Vector2.all(characterSize);
    add(george);
    camera.followComponent(george,
        worldBounds: Rect.fromLTRB(0, 0, mapWidth, mapHeight));
  }

  void addDialog(String text) {
    //dialogBox = DialogBox(text: text, game: this);
    //add(dialogBox);
    displayMessage.value = text;
  }

  void clearMessage() {
    displayMessage.value = "";
  }

  void newScene() async {
    print(" change the scene");
    removeAll(children);
    print(children);
    bakedGroupInventory.value = 0;
    friendNumber.value = 0;
    maxFriends = 0;
    // //FlameAudio.bgm.stop();
    // mapHeight = canvasSize.toRect().height;
    // mapWidth = canvasSize.toRect().width;
    // camera.worldBounds = Rect.fromLTWH(0, 0, mapHeight, mapWidth);
    if (sceneNumber > maps.length) sceneNumber = 1;
    loadMap(maps[sceneNumber - 1]);
  }
}
