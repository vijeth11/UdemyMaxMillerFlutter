import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_texturepacker/flame_texturepacker.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GameWidget(game: MyGame()),
    );
  }
}

class MyGame extends FlameGame {
  late SpriteAnimationComponent girl;
  @override
  Future<void>? onLoad() async {
    final spriteSheet = await fromJSONAtlas(
        'spritesheet-cute-girl.png', 'spritesheet-cute-girl.json');
    SpriteAnimation walk =
        SpriteAnimation.spriteList(spriteSheet, stepTime: 0.1);
    girl = SpriteAnimationComponent(
        animation: walk, position: Vector2(0, 100), size: Vector2(200, 200));
    add(girl);
    return super.onLoad();
  }

  @override
  void update(double dt) {
    girl.y += dt * 20;
    girl.x += dt * 10;
    super.update(dt);
  }
}
