import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:george_builder/main.dart';

class ButtonController extends StatelessWidget {
  final MyGeorgeGame game;
  const ButtonController(this.game, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            FlameAudio.bgm.play('music.mp3');
          },
          icon: const Icon(Icons.volume_up_rounded),
          color: Colors.pink.shade200,
        ),
        IconButton(
            onPressed: () {
              FlameAudio.bgm.stop();
            },
            icon: Icon(
              Icons.volume_off_rounded,
              color: Colors.pink.shade200,
            )),
        Text(
          game.soundTrackName,
          style: TextStyle(color: Colors.pink.shade200, fontSize: 20),
        )
      ],
    );
  }
}
