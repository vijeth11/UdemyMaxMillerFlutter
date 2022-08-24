import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame/flame.dart';
import 'package:flame/palette.dart';
import 'package:flutter/cupertino.dart';

class ButtonComponent extends Component with TapCallbacks {
  Paint color;
  Vector2 position;
  late Sprite buttonImage;

  ButtonComponent({required this.color, required this.position}) : super();

  @override
  Future<void>? onLoad() {
    // TODO: implement onLoad
    buttonImage = Sprite(Flame.images.fromCache('jump.png'))
      ..paint = BasicPalette.black.paint();
    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    // TODO: implement render
    super.render(canvas);
    canvas.drawCircle(position.toOffset(), 50, color);
    buttonImage.render(canvas,
        position: position, size: Vector2(54, 31), anchor: Anchor.center);
    //var shape = Circle(position, 40);
    //canvas.drawCircle(position.toOffset(), size.x/2, color);
    // canvas.drawImage(
    //     Flame.images.fromCache('world/Apple.png'), position.toOffset(), color);
    // canvas.clipRRect(RRect.fromLTRBR(pos, top, right, bottom, radius));
  }

  @override
  void onTapDown(TapDownEvent event) {
    // TODO: implement onTapDown
    super.onTapDown(event);
  }
}
