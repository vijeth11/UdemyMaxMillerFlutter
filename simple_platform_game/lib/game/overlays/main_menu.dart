import 'package:flutter/material.dart';
import 'package:simple_platform/game/actor/game_play.dart';
import 'package:simple_platform/game/game.dart';
import 'package:simple_platform/game/overlays/settings.dart';

class MainMenu extends StatelessWidget {
  static const id = 'MainMenu';
  final SimplePlatformer gameRef;

  const MainMenu({super.key, required this.gameRef});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                width: 100,
                child: ElevatedButton(
                    onPressed: () {
                      gameRef.overlays.remove(id);
                      gameRef.add(GamePlay());
                      gameRef.resumeEngine();
                    },
                    child: const Text('Play'))),
            SizedBox(
                width: 100,
                child: ElevatedButton(
                    onPressed: () {
                      gameRef.overlays.remove(id);
                      gameRef.overlays.add(Settings.id);
                    },
                    child: Text('Settings')))
          ],
        ),
      ),
    );
  }
}
