import 'package:flutter/material.dart';
import 'package:simple_platform/game/game.dart';
import 'package:simple_platform/game/overlays/main_menu.dart';

class PauseMenu extends StatelessWidget {
  static const id = 'PauseMenu';
  final SimplePlatformer gameRef;

  PauseMenu({super.key, required this.gameRef});

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
                    },
                    child: const Text('Resume'))),
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
