import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/cupertino.dart';
import 'package:pokemon/components/player.dart';
import 'package:pokemon/components/world.dart';
import 'package:pokemon/helper/direction.dart';

class PokemonGame extends FlameGame {
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
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
  }

  @override
  void update(double dt) {
    super.update(dt);
  }

  void onJoyPadDirectionChange(Direction current) {
    _player.direction = current;
  }
}
