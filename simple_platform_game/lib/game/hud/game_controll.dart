import 'package:flutter/material.dart';
import 'package:simple_platform/game/actor/game_play.dart';
import 'package:simple_platform/game/game.dart';

class GameControl extends StatelessWidget {
  final SimplePlatformer gameRef;
  GameControl(this.gameRef);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 100),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            GestureDetector(
              child: SizedBox(
                  width: 70,
                  height: 70,
                  child: Image.asset(
                    'assets/images/blue-!square.png',
                    width: 32,
                    height: 32,
                    fit: BoxFit.cover,
                  )),
              onTapDown: (tapDownDetails) {
                if (gameRef.children.last is GamePlay) {
                  final gamePlay = gameRef.children.last as GamePlay;
                  final player = gamePlay.currentLevel.player;
                  player.jumpHit = true;
                }
              },
              onTapUp: (tapUpDetails) {
                if (gameRef.children.last is GamePlay) {
                  final gamePlay = gameRef.children.last as GamePlay;
                  final player = gamePlay.currentLevel.player;
                  player.jumpHit = false;
                }
              },
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              GestureDetector(
                child: SizedBox(
                    width: 70,
                    height: 70,
                    child: Image.asset(
                      'assets/images/blue-!arrowleft.png',
                      width: 32,
                      height: 32,
                      fit: BoxFit.cover,
                    )),
                onTapDown: (tapDownDetails) {
                  if (gameRef.children.last is GamePlay) {
                    final gamePlay = gameRef.children.last as GamePlay;
                    final player = gamePlay.currentLevel.player;
                    player.horizontalMovement(-1);
                  }
                },
                onTapUp: (tapUpDetails) {
                  if (gameRef.children.last is GamePlay) {
                    final gamePlay = gameRef.children.last as GamePlay;
                    gamePlay.currentLevel.player.horizontalMovement(0);
                  }
                },
              ),
              GestureDetector(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: SizedBox(
                    width: 70,
                    height: 70,
                    child: Image.asset(
                      'assets/images/blue-!arrowright.png',
                      width: 32,
                      height: 32,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                onTapDown: (longPressDetails) {
                  if (gameRef.children.last is GamePlay) {
                    final gamePlay = gameRef.children.last as GamePlay;
                    final player = gamePlay.currentLevel.player;
                    player.horizontalMovement(1);
                  }
                },
                onTapUp: (longPressEndDetails) {
                  if (gameRef.children.last is GamePlay) {
                    final gamePlay = gameRef.children.last as GamePlay;
                    gamePlay.currentLevel.player.horizontalMovement(0);
                  }
                },
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
