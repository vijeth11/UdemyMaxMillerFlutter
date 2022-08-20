import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyHome());
}

class MyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        body: GameWidget(game: CharliChickenGame()),
      ),
    );
  }
}

class CharliChickenGame extends FlameGame with HasDraggables {
  late SpriteAnimationComponent chicken;
  late final JoystickComponent joystick;
  bool chickenFacingLeft = true;

  @override
  Future<void>? onLoad() async {
    await Flame.images.load('ChickenRun.png');
    var runAnimation = SpriteAnimation.fromFrameData(
        Flame.images.fromCache('ChickenRun.png'),
        SpriteAnimationData.sequenced(
            amount: 14, stepTime: 0.1, textureSize: Vector2(32, 34)));
    chicken = SpriteAnimationComponent(animation: runAnimation)
      ..size = Vector2.all(100)
      ..position = Vector2(100, 200);
    add(chicken);

    final knobPaint = BasicPalette.blue.withAlpha(200).paint();
    final backgroundPaint = BasicPalette.blue.withAlpha(100).paint();
    joystick = JoystickComponent(
        knob: CircleComponent(radius: 30, paint: knobPaint),
        background: CircleComponent(radius: 60, paint: backgroundPaint),
        margin: const EdgeInsets.only(left: 40, bottom: 40));
    add(joystick);
    return super.onLoad();
  }

  @override
  void update(double dt) {
    // TODO: implement update
    chicken.position += joystick.delta * 2 * dt;
    if (!chickenFacingLeft &&
        (joystick.direction == JoystickDirection.left ||
            joystick.direction == JoystickDirection.upLeft ||
            joystick.direction == JoystickDirection.downLeft)) {
      chicken.flipHorizontallyAroundCenter();
      chickenFacingLeft = true;
    } else if (chickenFacingLeft &&
        (joystick.direction == JoystickDirection.right ||
            joystick.direction == JoystickDirection.downRight ||
            joystick.direction == JoystickDirection.upRight)) {
      chicken.flipHorizontallyAroundCenter();
      chickenFacingLeft = false;
    }
    print(joystick.direction);
    super.update(dt);
  }
}
