import 'package:dino_run/dino_game.dart';
import 'package:dino_run/widgets/game_hud.dart';
import 'package:dino_run/widgets/game_over.dart';
import 'package:dino_run/widgets/pause_menu.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.fullScreen();
  Flame.device.setLandscape();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var game = DinoGame();
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Stack(
            children: [
              GameWidget(
                game: game,
                overlayBuilderMap: {
                  'pauseMenu': (ctx, DinoGame gameInstance) =>
                      PauseMenu(gameInstance.resumeGame),
                  'pauseIcon': (ctx, DinoGame gameInstance) =>
                      GameHud(gameInstance),
                  'gameOver': (ctx, DinoGame gameInstance) =>
                      GameOver(gameInstance)
                },
              ),
            ],
          ),
        ));
  }
}
