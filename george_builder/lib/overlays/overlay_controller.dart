import 'package:flutter/material.dart';
import 'package:george_builder/overlays/joypad.dart';
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
        Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(children: [
              const AudioOverlay(),
              ScoreOverlay(game: game),
            ])),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                      padding: EdgeInsets.only(left: 20, bottom: 10),
                      child: JoyPad(
                          onDirectionChanged: game.changeGeorgeDirection)),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: ValueListenableBuilder(
                  valueListenable: game.displayMessage,
                  builder: (ctx, String value, _) =>
                      value.isEmpty ? Container() : DialogOverlay(game: game)),
            ),
          ],
        )
      ],
    );
  }
}
