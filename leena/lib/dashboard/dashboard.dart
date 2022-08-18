import 'package:flutter/material.dart';
import 'package:leena/main.dart';

class Dashboard extends StatelessWidget {
  static final String name = 'Dashboard';

  final LeenaGame game;
  const Dashboard({Key? key, required this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        ValueListenableBuilder(
            valueListenable: game.magicLevel,
            builder: (context, int value, _) {
              return Text(
                'Magic: $value',
                style: TextStyle(fontSize: 20),
              );
            }),
        const SizedBox(
          width: 100,
        ),
        ValueListenableBuilder(
            valueListenable: game.remainingTime,
            builder: (ctx, int value, _) => Text(
                  "Power Remaining: $value",
                  style: TextStyle(fontSize: 24),
                ))
      ])
    ]);
  }
}
