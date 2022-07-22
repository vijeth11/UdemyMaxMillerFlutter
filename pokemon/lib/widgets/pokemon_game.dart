import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:pokemon/components/player.dart';
import 'package:pokemon/components/world.dart';
import 'package:pokemon/components/world_collidable.dart';
import 'package:pokemon/helper/direction.dart';
import 'package:pokemon/helper/map_load.dart';

class PokemonGame extends FlameGame with HasCollisionDetection, KeyboardEvents {
  late Player _player;
  late World _world;
  @override
  Future<void>? onLoad() async {
    await Flame.images.loadAll(
        ['player.png', 'player_spritesheet.png', 'rayworld_background.png']);
    _player = Player();
    _world = World();
    add(_world);
    add(_player);
    camera.followComponent(_player,
        worldBounds: Rect.fromLTRB(0, 0, _world.size.x, _world.size.y));
    _player.setMaxHeightAndWidth();
    await addWorldCollidable();
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
  }

  @override
  void update(double dt) {
    super.update(dt);
  }

 // This works correctly for chrome for app use joystick
  @override
  KeyEventResult onKeyEvent(
    RawKeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    bool isKeyDown = false;
    if (event is RawKeyDownEvent && !isKeyDown) {
      isKeyDown = true;
    }
    if (isKeyDown) {
      if (event.logicalKey == LogicalKeyboardKey.keyS) {
        _player.direction = Direction.down;
      } else if (event.logicalKey == LogicalKeyboardKey.keyW) {
        _player.direction = Direction.up;
      } else if (event.logicalKey == LogicalKeyboardKey.keyA) {
        _player.direction = Direction.left;
      } else if (event.logicalKey == LogicalKeyboardKey.keyD) {
        _player.direction = Direction.right;
      }
    } else if (event is RawKeyUpEvent) {
      _player.direction = Direction.none;
    }
    return super.onKeyEvent(event, keysPressed);
  }

  void onJoyPadDirectionChange(Direction current) {
    _player.direction = current;
  }

  Future<void> addWorldCollidable() async {
    (await MapLoader.readWorldCollisionMap()).forEach((element) {
      final worldComponent = WorldCollidable()
        ..height = element.height
        ..width = element.width
        ..x = element.left
        ..y = element.top;
      add(worldComponent);
    });
  }
}
