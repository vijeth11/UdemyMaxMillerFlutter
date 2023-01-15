import 'dart:math';

import 'package:doodle_dash/game/doodle_dash.dart';
import 'package:doodle_dash/game/sprite/platform.dart';
import 'package:flame/components.dart';

class PlatformManager extends Component with HasGameRef<DoodleDash> {
  final Random random = Random();
  final List<Platform> platforms = [];
}
