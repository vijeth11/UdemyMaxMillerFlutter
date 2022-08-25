import 'package:charlie_chicken/game.dart';
import 'package:flame/components.dart';

class Score extends TextComponent with HasGameRef<CharliChickenGame> {
  late String score;

  @override
  Future<void>? onLoad() {
    // TODO: implement onLoad
    score = gameRef.score.toString();
    // this defines what should be refered to place the component
    // and it will remain in the same position
    positionType = PositionType.viewport;
    text = 'SCORE: $score';
    position = Vector2(200, 20);
    scale = Vector2(2.5, 2.5);
    return super.onLoad();
  }

  @override
  void update(double dt) {
    // TODO: implement update
    super.update(dt);
    score = gameRef.score.toString();
    text = 'SCORE: $score';
  }
}
