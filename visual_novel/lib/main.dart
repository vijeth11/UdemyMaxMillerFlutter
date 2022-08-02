import 'package:flame/components.dart';
import 'package:flame/game.dart';
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
      home: Scaffold(
        body: GameWidget(game: MyGame()),
      ),
    );
  }
}

class MyGame extends FlameGame {
  SpriteComponent girl = SpriteComponent();
  SpriteComponent boy = SpriteComponent();
  @override
  Future<void>? onLoad() async {
    girl
      ..sprite = await loadSprite('girl.png')
      ..size = Vector2(300, 300)
      ..y = 100;

    add(girl);

    boy
      ..sprite = await loadSprite('boy.png')
      ..size = Vector2(300, 300)
      ..y = 100
      ..x = 100;

    add(boy);
    return super.onLoad();
  }
}
