import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:george_builder/main.dart';

class ButtonController extends StatelessWidget {
  final MyGeorgeGame game;
  const ButtonController(this.game, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              color: const Color(0x8f37474f),
              child: IconButton(
                onPressed: () {
                  FlameAudio.bgm.play('music.mp3');
                },
                icon: const Icon(Icons.volume_up_rounded),
                color: Colors.pink.shade200,
              ),
            ),
            Container(
              color: const Color(0x8f37474f),
              child: IconButton(
                  onPressed: () {
                    FlameAudio.bgm.stop();
                  },
                  icon: Icon(
                    Icons.volume_off_rounded,
                    color: Colors.pink.shade200,
                  )),
            ),
            // Text(
            //   game.soundTrackName,
            //   style: TextStyle(color: Colors.pink.shade200, fontSize: 20),
            // )
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
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
          ),
        )
      ],
    );
  }
}
