import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/cupertino.dart';
import 'package:ping_pong/ball.dart';
import 'package:ping_pong/consts.dart';
import 'package:ping_pong/pad.dart';
import 'package:sensors/sensors.dart';

class PingPong extends FlameGame {
  late final Ball ball;
  late final Pad pad1, pad2;
  double xSpeed = ballSpeed, ySpeed = ballSpeed;

  @override
  // TODO: implement debugMode
  bool get debugMode => true;
  @override
  Future<void>? onLoad() async {
    await images.loadAll(['ball.png', 'pad.png']);
    Paint bgPaint = Paint();
    bgPaint.color = bgColor;
    var background = RectangleComponent.fromRect(
        Rect.fromLTRB(0, 0, size.x, size.y),
        paint: bgPaint);
    add(background);
    ball = Ball();
    add(ball);
    pad1 = Pad(Vector2((size.x - padWidth) / 2, size.y - padBottomdDist));
    add(pad1);
    pad2 = Pad(Vector2((size.x - padWidth) / 2, padTopDist));
    add(pad2);
    _init();
    return super.onLoad();
  }

  void _init() {
    double x;
    accelerometerEvents.listen((event) {
      x = event.y + acceleroMax / 2;
      if (x < 0) x = 0;
      if (x > acceleroMax) x = acceleroMax;
      pad1.x = x * (size.toRect().width - padWidth) / acceleroMax;
    });
  }

  @override
  void update(double dt) {
    _bounce();
    super.update(dt);
  }

  void _bounce() {
    ball.x += xSpeed;
    ball.y += ySpeed;
    if (ball.x <= 0) {
      xSpeed = ballSpeed;
    } else if (ball.x >= size.x - ballSize) {
      xSpeed = -ballSpeed;
    } else if (ball.y < 0) {
      ySpeed = ballSpeed;
    } else if (ball.y + ballSize <= 0) {
      ySpeed = size.y;
    } else if (ball.x + ballSize >= pad1.x &&
        ball.x + ballSize <= pad1.x + padWidth &&
        ball.y >= size.y - padBottomdDist - ballSize &&
        ball.y <= size.y - padBottomdDist - ballSize + padheight &&
        ySpeed > 0) {
      ySpeed = -ballSpeed;
    } else if (ball.y >= size.y) {
      ball.y = -ballSpeed;
    }
  }
}
