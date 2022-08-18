import 'package:flutter/material.dart';

class GameOver extends StatelessWidget {
  static final String name = 'GameOver';
  final bool gameWon;
  const GameOver({Key? key, required this.gameWon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(
        height: 40,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          gameWon
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
      )
    ]);
  }
}
