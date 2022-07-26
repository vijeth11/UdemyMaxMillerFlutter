import 'package:dino_run/screens/dino_game.dart';
import 'package:flutter/material.dart';

class GameOver extends StatelessWidget {
  final DinoGame instance;
  GameOver(this.instance);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: Colors.black.withOpacity(0.5),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 100, vertical: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Game Over',
                  style: TextStyle(
                      fontFamily: 'Audiowide',
                      fontSize: 30,
                      color: Colors.white)),
              Text('Your score was ${instance.score}',
                  style: TextStyle(
                      fontFamily: 'Audiowide',
                      fontSize: 30,
                      color: Colors.white)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: instance.restartGame,
                    icon: Icon(Icons.replay),
                    iconSize: 30,
                    color: Colors.white,
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed('/');
                    },
                    icon: Icon(Icons.home),
                    iconSize: 30,
                    color: Colors.white,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
