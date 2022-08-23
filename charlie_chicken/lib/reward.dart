import 'package:flame/components.dart';
import 'package:flame/flame.dart';

class RewardComponent extends SpriteComponent {
  final Vector2 srcSize;
  final String imageName;
  final Vector2 objPosition;
  final Vector2 objSize;

  RewardComponent(
      {required this.srcSize,
      required this.imageName,
      required this.objPosition,
      required this.objSize});

  @override
  Future<void>? onLoad() {
    sprite = Sprite(Flame.images.fromCache(imageName), srcSize: srcSize);
    size = objSize;
    //debugMode = true;
    return super.onLoad();
  }

  @override
  void onGameResize(Vector2 size) {
    position = objPosition;
    anchor = Anchor.bottomLeft;
    print(anchor);
    super.onGameResize(size);
  }
}
