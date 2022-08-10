import 'package:flutter/material.dart';
import 'package:george_builder/my_george_game.dart';

class ScoreOverlay extends StatelessWidget {
  const ScoreOverlay({
    Key? key,
    required this.game,
  }) : super(key: key);

  final MyGeorgeGame game;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          color: const Color.fromARGB(167, 218, 218, 218),
          child: Image.asset(
            'assets/images/friend.png',
            scale: .8,
          ),
        ),
        const SizedBox(
          width: 12,
        ),
        Container(
          color: const Color.fromARGB(167, 218, 218, 218),
          child: ValueListenableBuilder(
              valueListenable: game.friendNumber,
              builder: (ctx, int value, _) => Text(
                    '$value',
                    style: const TextStyle(
                        fontSize: 28, color: Colors.black45),
                  )),
        ),
        const SizedBox(width: 20),
        Container(
          color: const Color.fromARGB(167, 218, 218, 218),
          child: Image.asset(
            'assets/images/ChocoCake.png',
            scale: .8,
          ),
        ),
        const SizedBox(
          width: 12,
        ),
        Container(
          color: const Color.fromARGB(167, 218, 218, 218),
          child: ValueListenableBuilder(
              valueListenable: game.bakedGroupInventory,
              builder: (ctx, int value, _) => Text(
                    '$value',
                    style: const TextStyle(
                        fontSize: 28, color: Colors.black45),
                  )),
        ),
      ],
    );
  }
}
