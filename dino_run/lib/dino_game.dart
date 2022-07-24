import 'package:dino_run/widgets/background.dart';
import 'package:dino_run/widgets/player.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';

const double groundHeight = 32;
const double playerSize = 50;

class DinoGame extends FlameGame {
  late Player dino;
  Background background = Background();

  @override
  Future<void>? onLoad() async {
    await Flame.images.loadAll([
      'DinoSprites_tard.gif',
      'DinoSprites - tard.png',
      'plx-1.png',
      'plx-2.png',
      'plx-3.png',
      'plx-4.png',
      'plx-5.png',
      'plx-6.png'
    ]);

    add(background);

    dino = Player(
        Vector2.all(playerSize),
        Vector2(size.toOffset().dx / 10,
            size.toOffset().dy - groundHeight - playerSize + 15));
    add(dino);

    return super.onLoad();
  }
}
