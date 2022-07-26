import 'package:dino_run/dino_game.dart';
import 'package:flutter/material.dart';

class GameHud extends StatelessWidget {
  final DinoGame gameInstance;
  GameHud(this.gameInstance);
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(gameInstance.paused ? Icons.play_arrow : Icons.pause),
            onPressed: () {
              gameInstance.displayPauseMenu();
            },
            color: Colors.white,
            iconSize: 30.0,
          ),
          Padding(
            padding: EdgeInsets.only(right: 15),
            child: ValueListenableBuilder(
                valueListenable: gameInstance.life,
                builder: (ctx, int value, child) => Row(
                    children: List.generate(
                        5,
                        (index) => Icon(
                              Icons.favorite,
                              color: index < value ? Colors.red : Colors.black,
                            )))),
          )
        ],
      ),
    );
  }
}
