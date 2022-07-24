import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';

class Background extends ParallaxComponent {
  @override
  Future<void>? onLoad() {
    // To display multiple layers of background and move them at different speeds
    // you can use paralax and provide velocity
    parallax = Parallax([
      ParallaxLayer(
          ParallaxImage(Flame.images.fromCache('plx-1.png'),
              repeat: ImageRepeat.repeatX),
          velocityMultiplier: Vector2(1, 0)),
      ParallaxLayer(
          ParallaxImage(Flame.images.fromCache('plx-2.png'),
              repeat: ImageRepeat.repeatX),
          velocityMultiplier: Vector2(2, 0)),
      ParallaxLayer(
          ParallaxImage(Flame.images.fromCache('plx-3.png'),
              repeat: ImageRepeat.repeatX),
          velocityMultiplier: Vector2(3, 0)),
      ParallaxLayer(
          ParallaxImage(Flame.images.fromCache('plx-4.png'),
              repeat: ImageRepeat.repeatX),
          velocityMultiplier: Vector2(4, 0)),
      ParallaxLayer(
          ParallaxImage(Flame.images.fromCache('plx-5.png'),
              repeat: ImageRepeat.repeatX),
          velocityMultiplier: Vector2(5, 0)),
      ParallaxLayer(
          ParallaxImage(Flame.images.fromCache('plx-6.png'),
              repeat: ImageRepeat.repeatX, fill: LayerFill.none),
          velocityMultiplier: Vector2(5, 0))
    ], baseVelocity: Vector2(50, 0));
    return super.onLoad();
  }
}
