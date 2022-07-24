import 'package:dino_run/widgets/background.dart';
import 'package:dino_run/widgets/enemy.dart';
import 'package:dino_run/widgets/player.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';

const double groundHeight = 32;
const double playerSize = 50;

class DinoGame extends FlameGame with MultiTouchTapDetector {
  late Player dino;
  Background background = Background();
  double countter = 0;

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
      'plx-6.png',
      'Angry Pig Run (36x30).png',
      'Bunny (34x44).png',
      'Chicken (32x34).png',
      'Flying Bat (46x30).png',
      'Rino Run (52x34).png'
    ]);

    add(background);

    dino = Player(
        Vector2.all(playerSize),
        Vector2(size.toOffset().dx / 10,
            size.toOffset().dy - groundHeight - playerSize + 15));
    add(dino);

    return super.onLoad();
  }

  @override
  void update(double dt) {
    countter += dt;
    if (countter > 2) {
      var enemy = Enemy(
          Vector2.all(playerSize),
          Vector2(size.toOffset().dx / 10,
              size.toOffset().dy - groundHeight - playerSize));
      add(enemy);
      countter = 0;
    }
    super.update(dt);
  }

  @override
  void onTapDown(int pointerId, TapDownInfo info) {
    dino.jump();
    super.onTapDown(pointerId, info);
  }
}
