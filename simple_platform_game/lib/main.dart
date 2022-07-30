import 'dart:ui';

import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:simple_platform/game/game.dart';
import 'package:simple_platform/game/hud/game_controll.dart';
import 'package:simple_platform/game/overlays/game_over.dart';
import 'package:simple_platform/game/overlays/main_menu.dart';
import 'package:simple_platform/game/overlays/pause_menu.dart';
import 'package:simple_platform/game/overlays/settings.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();
  await Flame.device.setLandscape();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  SimplePlatformer game = SimplePlatformer();
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simple Platformer',
      theme: ThemeData.dark(),
      home: Scaffold(
        body: Stack(
          children: [
            GameWidget(
              game: game,
              overlayBuilderMap: {
                MainMenu.id: (ctx, SimplePlatformer _gameRef) =>
                    MainMenu(gameRef: _gameRef),
                PauseMenu.id: (ctx, SimplePlatformer _gameRef) =>
                    PauseMenu(gameRef: _gameRef),
                GameOver.id: (ctx, SimplePlatformer _gameRef) =>
                    GameOver(gameRef: _gameRef),
                Settings.id: (ctx, SimplePlatformer _gameRef) =>
                    Settings(gameRef: _gameRef)
              },
              initialActiveOverlays: [MainMenu.id],
            ),
            ValueListenableBuilder(
                valueListenable: game.isOverlayActive,
                builder: (context, bool value, child) =>
                    value ? Container() : GameControl(game))
          ],
        ),
      ),
    );
  }
}
