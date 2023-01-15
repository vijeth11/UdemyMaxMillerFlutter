import 'package:doodle_dash/game/doodle_dash.dart';
import 'package:flame/components.dart';
import 'package:flame/parallax.dart';

class World extends ParallaxComponent<DoodleDash> {
  @override
  Future<void> onLoad() async {
    parallax =
        await gameRef.loadParallax([ParallaxImageData('game/graph_paper.png')]);
  }
}
