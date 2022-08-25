import 'package:charlie_chicken/game.dart';
import 'package:flame/components.dart';

class LivesRemaining extends TextComponent with HasGameRef<CharliChickenGame> {
  late String lives;

  @override
  Future<void>? onLoad() {
    // TODO: implement onLoad
    lives = gameRef.lifeLeft.toString();
    // this defines what should be refered to place the component
    // and it will remain in the same position
    positionType = PositionType.viewport;
    text = 'X$lives';
    position = Vector2(gameRef.size.x - 200, 20);
    scale = Vector2(2.5, 2.5);
    return super.onLoad();
  }

  @override
  void update(double dt) {
    // TODO: implement update
    super.update(dt);
    lives = gameRef.lifeLeft.toString();
    text = 'X$lives';
  }
}
