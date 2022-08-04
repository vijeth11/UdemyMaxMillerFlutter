import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/material.dart';
import 'package:simple_platform/game/actor/coin.dart';
import 'package:simple_platform/game/actor/door.dart';
import 'package:simple_platform/game/actor/enemy.dart';
import 'package:simple_platform/game/actor/game_play.dart';
import 'package:simple_platform/game/actor/platform.dart';
import 'package:simple_platform/game/actor/player.dart';
import 'package:simple_platform/game/game.dart';
import 'package:tiled/tiled.dart';

class Level extends Component
    with HasGameRef<SimplePlatformer>, ParentIsA<GamePlay> {
  final String levelName;
  late TiledComponent level;
  late Player player;
  late Rect levelBounds;

  Level(this.levelName);

  @override
  Future<void>? onLoad() async {
    level = await TiledComponent.load(levelName, Vector2.all(32));
    add(level);
    // map width =  number of tiles in width * each tile width
    // map height = number of tiles in height * each tile height
    levelBounds = Rect.fromLTWH(
        0,
        0,
        (level.tileMap.map.width * level.tileMap.map.tileWidth).toDouble(),
        (level.tileMap.map.height * level.tileMap.map.tileHeight).toDouble());
    _spawnActors();
    _setupCamera();
    return super.onLoad();
  }

  _setupCamera() {
    gameRef.camera.followComponent(player);
    gameRef.camera.worldBounds = levelBounds;
  }

  _spawnActors() {
    // read data from level tile file
    final ObjectGroup? platformLayers =
        level.tileMap.getLayer<ObjectGroup>('Platforms');
    platformLayers?.objects.forEach((element) {
      final platform = Platform(
          position: Vector2(element.x, element.y),
          size: Vector2(element.width, element.height));
      add(platform);
    });
    final ObjectGroup? spawnPointsLayer =
        level.tileMap.getLayer<ObjectGroup>('SpawnPoints');
    spawnPointsLayer?.objects.forEach((element) {
      switch (element.class_) {
        case 'Player':
          player = Player(Flame.images.fromCache('Spritesheet.png'),
              levelBounds: levelBounds,
              anchor: Anchor.center,
              position: Vector2(element.x, element.y),
              size: Vector2(element.width, element.height));
          add(player);
          break;
        case 'Coin':
          final coin = Coin(Flame.images.fromCache('Spritesheet.png'),
              position: Vector2(element.x, element.y),
              size: Vector2(element.width, element.height));
          add(coin);
          break;
        case 'Enemy':
          // destination position for enemy to move in tiles
          // data is stored in level tmx under object with name target
          // whose id is stored as a property value for in enemy tag
          final targetId = int.parse(element.properties.first.value);
          final target = spawnPointsLayer.objects
              .firstWhere((element) => element.id == targetId);
          final enemy = Enemy(Flame.images.fromCache('Spritesheet.png'),
              targetPosition: Vector2(target.x, target.y),
              position: Vector2(element.x, element.y),
              size: Vector2(element.width, element.height));
          add(enemy);
          break;
        case 'Door':
          final door = Door(Flame.images.fromCache('Spritesheet.png'),
              position: Vector2(element.x, element.y),
              size: Vector2(element.width, element.height), onPlayerEnter: () {
            parent.loadLevel(element.properties.first.value);
          });
          add(door);
          break;
      }
    });
  }
}
