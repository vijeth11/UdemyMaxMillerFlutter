import 'package:flutter/material.dart';
import 'package:simple_platform/game/actor/game_play.dart';
import 'package:simple_platform/game/game.dart';
import 'package:simple_platform/game/overlays/main_menu.dart';

class GameOver extends StatelessWidget {
  static const id = 'GameOver';
  final SimplePlatformer gameRef;

  GameOver({super.key, required this.gameRef});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.black.withAlpha(100),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
                width: 100,
                child: ElevatedButton(
                    onPressed: () {
                      gameRef.overlays.remove(id);
                      gameRef.resumeEngine();
                      gameRef.removeAll(gameRef.children);
                      gameRef.add(GamePlay());
                      gameRef.isOverlayActive.value = false;
                    },
                    child: const Text('Restart'))),
            SizedBox(
                width: 100,
                child: ElevatedButton(
                    onPressed: () {
                      gameRef.overlays.remove(id);
                      gameRef.pauseEngine();
                      gameRef.removeAll(gameRef.children);
                      gameRef.overlays.add(MainMenu.id);
                    },
                    child: Text('Exit')))
          ],
        ),
      ),
    );
  }
}
