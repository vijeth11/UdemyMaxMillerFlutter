import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pokemon/helper/direction.dart';
import 'package:pokemon/widgets/joypad.dart';
import 'package:pokemon/widgets/pokemon_game.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  PokemonGame game = PokemonGame();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(0, 0, 0, 1),
      body: Stack(
        children: [
          GameWidget(game: game),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: JoyPad(onDirectionChanged: onJoyPadDirectionChange),
            ),
          )
        ],
      ),
    );
  }

  void onJoyPadDirectionChange(Direction current) {
    game.onJoyPadDirectionChange(current);
  }
}
