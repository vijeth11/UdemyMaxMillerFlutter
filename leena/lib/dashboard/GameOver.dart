import 'package:flutter/material.dart';

class GameOver extends StatelessWidget {
  static final String name = 'GameOver';
  const GameOver({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(
        height: 40,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('GAME OVER',
              style: TextStyle(
                fontSize: 80,
                color: Colors.red,
              ))
        ],
      )
    ]);
  }
}
