import 'package:flutter/material.dart';
import './audio_overlay.dart';
import './dialog_overlay.dart';
import './score_overlay.dart';
import 'package:george_builder/my_george_game.dart';

class OverlayController extends StatelessWidget {
  final MyGeorgeGame game;
  const OverlayController(this.game, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const AudioOverlay(),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Expanded(flex: 2, child: ScoreOverlay(game: game)),
              Expanded(
                flex: 2,
                child: ValueListenableBuilder(
                    valueListenable: game.displayMessage,
                    builder: (ctx, String value, _) => value.isEmpty
                        ? Container()
                        : DialogOverlay(game: game)),
              )
            ],
          ),
        )
      ],
    );
  }
}
