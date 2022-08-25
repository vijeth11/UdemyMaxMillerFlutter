import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/input.dart';
import 'package:flame/palette.dart';
import 'package:flutter/cupertino.dart';

class ButtonComponent extends Component with Tappable {
  Paint color;
  VoidCallback onButtonTap;
  Vector2 position;
  late Sprite buttonImage;

  ButtonComponent(
      {required this.color, required this.position, required this.onButtonTap});

  @override
  Future<void> onLoad() async {
    // TODO: implement onLoad
    buttonImage =
        Sprite(Flame.images.fromCache('jump.png'), srcSize: Vector2(108, 63));
    add(ClickComponent(
        position: position, size: Vector2.all(90), onButtonTap: onButtonTap)
      ..anchor = Anchor.center);
    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    // TODO: implement render
    super.render(canvas);
    canvas.drawCircle(
        position.toOffset(), 50, BasicPalette.blue.withAlpha(100).paint());
    buttonImage.render(
      canvas,
      position: position,
      size: Vector2(54, 31),
      anchor: Anchor.center,
    );
  }
}

class ClickComponent extends PositionComponent with Tappable {
  VoidCallback onButtonTap;
  ClickComponent({required position, required size, required this.onButtonTap})
      : super(position: position, size: size);
  @override
  bool onTapDown(TapDownInfo info) {
    print("jump button clicked");
    onButtonTap();
    return super.onTapDown(info);
  }
}
