import 'package:charlie_chicken/game.dart';
import 'package:flutter/material.dart';

class GameOver extends StatelessWidget {
  static final String name = 'GameOver';
  final CharliChickenGame game;
  const GameOver({Key? key, required this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(
        height: 40,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          game.gameOver && game.lifeLeft > 0
              ? Text(
                  "YOU WON",
                  style: TextStyle(color: Colors.green, fontSize: 60),
                )
              : Text('GAME OVER',
                  style: TextStyle(
                    fontSize: 80,
                    color: Colors.red,
                  ))
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
              onPressed: () {
                game.resumeEngine();
                game.restartGame();
              },
              icon: Icon(
                Icons.refresh,
                textDirection: TextDirection.ltr,
                size: 40,
              )),
          Text(
            "Restart",
            style: TextStyle(fontSize: 40),
          )
        ],
      )
    ]);
  }
}
