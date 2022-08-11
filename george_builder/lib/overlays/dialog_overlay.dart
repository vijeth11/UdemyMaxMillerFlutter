import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:george_builder/my_george_game.dart';

class DialogOverlay extends StatelessWidget {
  final MyGeorgeGame game;
  const DialogOverlay({Key? key, required this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Color.fromARGB(167, 218, 218, 218)),
      child: AnimatedTextKit(
        isRepeatingAnimation: false,
        animatedTexts: [
          TypewriterAnimatedText(game.displayMessage.value,
              textStyle: TextStyle(fontSize: 12, fontFamily: 'Arcade'),
              speed: Duration(milliseconds: 100))
        ],
        onFinished: game.clearMessage,
      ),
    );
  }
}
