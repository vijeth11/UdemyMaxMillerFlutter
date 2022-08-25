import 'package:charlie_chicken/game.dart';
import 'package:charlie_chicken/overlays/game_over.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();
  await Flame.device.setLandscape();
  runApp(MyHome());
}

class MyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        body: GameWidget(
          game: CharliChickenGame(),
          overlayBuilderMap: {
            GameOver.name: (ctx, CharliChickenGame game) => GameOver(                
                game: game,
              )
          },
        ),
      ),
    );
  }
}
