import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:leena/main.dart';

class Intro extends PositionComponent with HasGameRef<LeenaGame> {
  Intro({required size}) : super(size: size);

  late SpriteComponent dad;
  String introString =
      'Leena. this is your Father. my ship has crashed and the crystals that power my'
      'engines are gone. i will be trapped here unless '
      'you can gather 4 magic crystals and them to me.'
      ' The only vehicle that can move quickly in the gravity of'
      ' this planet is the hoverboard I made for you. Good luck.';

  @override
  void render(Canvas canvas) {
    canvas.drawColor(Colors.blueGrey, BlendMode.src);
  }

  @override
  Future<void>? onLoad() async {
    add(IntroBox(introString, size.x / 2)..position = Vector2(100, 90));
    dad = SpriteComponent(
        sprite: Sprite(Flame.images.fromCache('dad.png'),
            srcSize: Vector2.all(300)),
        size: Vector2(size.y, size.y),
        position: Vector2(size.x / 2, 50));
    add(dad);
    return super.onLoad();
  }
}

class IntroBox extends TextBoxComponent {
  IntroBox(String text, double width)
      : super(
            text: text,
            textRenderer: TextPaint(
                style: TextStyle(fontSize: 32, color: Colors.black87)),
            boxConfig: TextBoxConfig(timePerChar: 0.05, maxWidth: width));

  @override
  void drawBackground(Canvas c) {
    Rect rect = Rect.fromLTWH(0, 0, width, height);
    c.drawRect(rect, Paint()..color = Colors.white24);
    super.drawBackground(c);
  }
}
