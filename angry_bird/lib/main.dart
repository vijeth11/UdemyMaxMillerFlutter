import 'package:angry_bird/characters/enemy.dart';
import 'package:angry_bird/characters/obstacle.dart';
import 'package:angry_bird/characters/player.dart';
import 'package:angry_bird/components/ground.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();
  await Flame.device.setLandscape();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Angry Bird',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GameWidget(game: AngryBird()),
    );
  }
}

class AngryBird extends Forge2DGame with HasTappables {
  @override
  Future<void>? onLoad() async {
    await Flame.images.loadAll([
      'background.webp',
      'red.webp',
      'cloud.webp',
      'crate.png',
      'pig.webp',
      'barrel.png'
    ]);
    var background = SpriteComponent(
        sprite: Sprite(Flame.images.fromCache('background.webp')), size: size);
    add(background);
    Vector2 gameSize = screenToWorld(camera.viewport.effectiveSize);
    add(Ground(gameSize));
    Sprite crateSprite = Sprite(Flame.images.fromCache('crate.png'));
    Sprite barelSprite = Sprite(Flame.images.fromCache('barrel.png'));
    add(Enemy(Vector2(gameSize.x / 2, -10)));
    add(Obstacle(Vector2(gameSize.x / 2, -5), barelSprite));
    for (int i = 0; i < 4; i++) {
      add(Obstacle(Vector2(gameSize.x / 2, 5 * i.toDouble()), crateSprite));
    }
    add(Player());
    return super.onLoad();
  }
}
