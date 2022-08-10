import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:george_builder/overlays/overlay_controller.dart';
import 'package:george_builder/my_george_game.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.setLandscape();
  Flame.device.fullScreen();
  runApp(MaterialApp(
      home: Scaffold(
    body: GameWidget(
      game: MyGeorgeGame(),
      overlayBuilderMap: {
        'ButtonController': (context, MyGeorgeGame game) =>
            OverlayController(game),
      },
    ),
  )));
}

