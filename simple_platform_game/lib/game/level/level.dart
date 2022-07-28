import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:simple_platform/game/actor/coin.dart';
import 'package:simple_platform/game/actor/door.dart';
import 'package:simple_platform/game/actor/enemy.dart';
import 'package:simple_platform/game/actor/platform.dart';
import 'package:simple_platform/game/actor/player.dart';
import 'package:simple_platform/game/game.dart';
import 'package:tiled/tiled.dart';

class Level extends Component with HasGameRef<SimplePlatformer> {
  final String levelName;
  late TiledComponent level;
  Level(this.levelName);

  @override
  Future<void>? onLoad() async {
    level = await TiledComponent.load(levelName, Vector2.all(32));
    add(level);
    _spawnActors();

    return super.onLoad();
  }

  _spawnActors() {
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
          final player = Player(Flame.images.fromCache('Spritesheet.png'),
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
          final enemy = Enemy(Flame.images.fromCache('Spritesheet.png'),
              position: Vector2(element.x, element.y),
              size: Vector2(element.width, element.height));
          add(enemy);
          break;
        case 'Door':
          final door = Door(Flame.images.fromCache('Spritesheet.png'),
              position: Vector2(element.x, element.y),
              size: Vector2(element.width, element.height));
          add(door);
          break;
      }
    });
  }
}
