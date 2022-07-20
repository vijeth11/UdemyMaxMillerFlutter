import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/cupertino.dart';
import 'package:pokemon/components/player.dart';
import 'package:pokemon/helper/direction.dart';

class PokemonGame extends FlameGame {
  late Player _player;
  @override
  Future<void>? onLoad() async {
    await Flame.images.loadAll(['player.png']);
    _player = Player();
    add(_player);
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
