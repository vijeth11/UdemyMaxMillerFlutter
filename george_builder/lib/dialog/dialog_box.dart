import 'package:flame/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:george_builder/main.dart';

class DialogBox extends TextBoxComponent {
  final String text;
  final MyGeorgeGame game;
  DialogBox({required this.text, required this.game})
      : super(
            text: text,
            position: game.size,
            boxConfig: TextBoxConfig(
              dismissDelay: 5.0,
              maxWidth: game.size.x * .5,
              timePerChar: 0.1,
            ),
            anchor: Anchor.bottomRight);

  @override
  void drawBackground(Canvas c) {
    Rect rect = Rect.fromLTWH(0, 0, width, height);
    c.drawRect(rect, Paint()..color = const Color(0x8f37474f));
  }

  @override
  void update(double dt) {
    if (finished) {
      game.remove(this);
    }
    super.update(dt);
  }
}
