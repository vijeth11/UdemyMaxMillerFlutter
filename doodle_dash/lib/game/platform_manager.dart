import 'dart:math';

import 'package:doodle_dash/game/doodle_dash.dart';
import 'package:doodle_dash/game/sprite/platform.dart';
import 'package:flame/components.dart';

class PlatformManager extends Component with HasGameRef<DoodleDash> {
  final Random random = Random();
  final List<Platform> platforms = [];
  // This will depend on the player jump speed and screen width
  final double maxVerticalDistanceToNextPlatform;

  // Adjust this value change game difficulty
  final double minVerticalDistanceToNextPlatform = 200;

  PlatformManager({required this.maxVerticalDistanceToNextPlatform}) : super();

  @override
  void onMount() {
    // the first platform will always be in the bottom third of the initial screen
    var currentY =
        gameRef.size.y - (random.nextInt(gameRef.size.y.floor()) / 3);

    // Generate 10 platforms at random x, y positions and add to list of platforms
    for (int i = 0; i < 9; i++) {
      if (i != 0) {
        currentY = _generateNextY();
      }
      platforms.add(Platform(
          position: Vector2(
              random.nextInt(gameRef.size.x.floor()).toDouble(), currentY)));
    }
    super.onMount();
  }

  // This method determines where the next platform should be placed
  // It calculates a random distance between the minVerticalDistanceToNextPlatform
  // and the maxVerticalDistanceToNextPlatform, and returns a Y coordinate that is
  // that distance above the current highest platform

  double _generateNextY() {
    final currentHighestPlatform = platforms.last.center.y;
    final distanceToNextY = minVerticalDistanceToNextPlatform.toInt() +
        random
            .nextInt((maxVerticalDistanceToNextPlatform -
                    minVerticalDistanceToNextPlatform)
                .toInt())
            .toDouble();
    return currentHighestPlatform - distanceToNextY;
  }

  @override
  void update(double dt) {
    final topOfLowestPlatform = platforms.first.position.y;

    super.update(dt);
  }
}
